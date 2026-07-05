"""Install, update and inspect LLM Software Toolkit copies in target projects."""

from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


TOOLKIT_HOME = ".llm-toolkit"
MANAGED_DIR = "toolkit"
MANIFEST_NAME = "manifest.json"
MODE = "local-sync"
SCHEMA_VERSION = 1

COPY_ITEMS = (
    "README.md",
    "CHANGELOG.md",
    "project.example.yaml",
    "docs",
    "adapters",
    "workflows",
    "skills",
    "cli",
)

EXCLUDED_NAMES = {
    ".git",
    ".llm-toolkit",
    "__pycache__",
    ".pytest_cache",
    ".mypy_cache",
    ".ruff_cache",
    ".DS_Store",
}


class ToolkitError(RuntimeError):
    """Expected CLI error that should be shown without a traceback."""


def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def source_root() -> Path:
    return Path(__file__).resolve().parents[1]


def resolve_existing_dir(path: str, label: str) -> Path:
    resolved = Path(path).expanduser().resolve()
    if not resolved.exists():
        raise ToolkitError(f"{label} does not exist: {resolved}")
    if not resolved.is_dir():
        raise ToolkitError(f"{label} is not a directory: {resolved}")
    return resolved


def target_layout(target: Path) -> dict[str, Path]:
    home = target / TOOLKIT_HOME
    return {
        "home": home,
        "managed": home / MANAGED_DIR,
        "manifest": home / MANIFEST_NAME,
        "tmp": home / f"{MANAGED_DIR}.tmp",
    }


def is_inside(path: Path, parent: Path) -> bool:
    try:
        path.resolve().relative_to(parent.resolve())
    except ValueError:
        return False
    return True


def ensure_safe_managed_path(target: Path, managed: Path) -> None:
    expected_parent = target / TOOLKIT_HOME
    if managed.name != MANAGED_DIR or managed.parent != expected_parent:
        raise ToolkitError(f"Refusing unsafe managed path: {managed}")
    if not is_inside(managed, target):
        raise ToolkitError(f"Managed path is outside target project: {managed}")


def ignore_names(_: str, names: list[str]) -> set[str]:
    return {name for name in names if name in EXCLUDED_NAMES}


def copy_item(source: Path, destination: Path) -> None:
    if source.is_dir():
        shutil.copytree(source, destination, ignore=ignore_names)
        return
    if source.is_file():
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, destination)
        return
    raise ToolkitError(f"Source item is neither file nor directory: {source}")


def sync_toolkit(source: Path, target: Path) -> None:
    layout = target_layout(target)
    layout["home"].mkdir(parents=True, exist_ok=True)
    ensure_safe_managed_path(target, layout["managed"])

    if layout["tmp"].exists():
        shutil.rmtree(layout["tmp"])
    layout["tmp"].mkdir(parents=True)

    try:
        for item in COPY_ITEMS:
            source_item = source / item
            if not source_item.exists():
                raise ToolkitError(f"Required source item is missing: {source_item}")
            copy_item(source_item, layout["tmp"] / item)

        if layout["managed"].exists():
            shutil.rmtree(layout["managed"])
        layout["tmp"].replace(layout["managed"])
    except Exception:
        if layout["tmp"].exists():
            shutil.rmtree(layout["tmp"])
        raise


def git_output(source: Path, args: list[str]) -> str | None:
    try:
        result = subprocess.run(
            ["git", *args],
            cwd=source,
            capture_output=True,
            text=True,
            check=False,
        )
    except OSError:
        return None
    if result.returncode != 0:
        return None
    return result.stdout.strip()


def source_commit(source: Path) -> str | None:
    return git_output(source, ["rev-parse", "HEAD"])


def current_branch(source: Path) -> str | None:
    return git_output(source, ["branch", "--show-current"])


def load_manifest(target: Path) -> dict[str, Any]:
    manifest_path = target_layout(target)["manifest"]
    if not manifest_path.exists():
        raise ToolkitError(f"Toolkit is not installed in target: {target}")
    try:
        with manifest_path.open("r", encoding="utf-8") as handle:
            data = json.load(handle)
    except json.JSONDecodeError as exc:
        raise ToolkitError(f"Manifest is not valid JSON: {manifest_path}") from exc
    if not isinstance(data, dict):
        raise ToolkitError(f"Manifest must be a JSON object: {manifest_path}")
    return data


def write_manifest(target: Path, manifest: dict[str, Any]) -> None:
    manifest_path = target_layout(target)["manifest"]
    manifest_path.parent.mkdir(parents=True, exist_ok=True)
    with manifest_path.open("w", encoding="utf-8") as handle:
        json.dump(manifest, handle, indent=2, sort_keys=True)
        handle.write("\n")


def build_manifest(
    *,
    source: Path,
    installed_at: str,
    updated_at: str,
) -> dict[str, Any]:
    return {
        "schema_version": SCHEMA_VERSION,
        "mode": MODE,
        "source_path": str(source),
        "source_commit": source_commit(source),
        "source_branch": current_branch(source),
        "managed_path": f"{TOOLKIT_HOME}/{MANAGED_DIR}",
        "installed_at": installed_at,
        "updated_at": updated_at,
        "copy_items": list(COPY_ITEMS),
    }


def command_install(args: argparse.Namespace) -> int:
    target = resolve_existing_dir(args.target, "Target")
    source = source_root()
    layout = target_layout(target)

    if layout["manifest"].exists() and not args.force:
        raise ToolkitError(f"Toolkit is already installed: {layout['manifest']}")

    now = utc_now()
    sync_toolkit(source, target)
    manifest = build_manifest(source=source, installed_at=now, updated_at=now)
    write_manifest(target, manifest)
    print(f"Installed toolkit into {layout['managed']}")
    print(f"Manifest: {layout['manifest']}")
    return 0


def command_update(args: argparse.Namespace) -> int:
    target = resolve_existing_dir(args.target, "Target")
    existing = load_manifest(target)
    source_path = existing.get("source_path")
    if not isinstance(source_path, str) or not source_path:
        raise ToolkitError("Manifest does not contain a valid source_path")

    source = resolve_existing_dir(source_path, "Source")
    sync_toolkit(source, target)
    manifest = build_manifest(
        source=source,
        installed_at=str(existing.get("installed_at", utc_now())),
        updated_at=utc_now(),
    )
    write_manifest(target, manifest)
    print(f"Updated toolkit in {target_layout(target)['managed']}")
    print(f"Source: {source}")
    return 0


def command_status(args: argparse.Namespace) -> int:
    target = resolve_existing_dir(args.target, "Target")
    layout = target_layout(target)
    if not layout["manifest"].exists():
        print(f"Toolkit is not installed in {target}")
        return 0

    manifest = load_manifest(target)
    print(f"Toolkit is installed in {layout['managed']}")
    print(f"Mode: {manifest.get('mode', 'unknown')}")
    print(f"Source: {manifest.get('source_path', 'unknown')}")
    print(f"Installed at: {manifest.get('installed_at', 'unknown')}")
    print(f"Updated at: {manifest.get('updated_at', 'unknown')}")
    if manifest.get("source_commit"):
        print(f"Source commit: {manifest['source_commit']}")
    if manifest.get("source_branch"):
        print(f"Source branch: {manifest['source_branch']}")
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="toolkit.py",
        description="Install and update LLM Software Toolkit in target projects.",
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    install = subparsers.add_parser("install", help="Install toolkit into a target project.")
    install.add_argument("--target", required=True, help="Target project path.")
    install.add_argument("--force", action="store_true", help="Reinstall when a manifest already exists.")
    install.set_defaults(func=command_install)

    update = subparsers.add_parser("update", help="Update an existing toolkit installation.")
    update.add_argument("--target", required=True, help="Target project path.")
    update.set_defaults(func=command_update)

    status = subparsers.add_parser("status", help="Show toolkit installation status.")
    status.add_argument("--target", required=True, help="Target project path.")
    status.set_defaults(func=command_status)

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        return args.func(args)
    except ToolkitError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
