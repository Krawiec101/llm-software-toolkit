from __future__ import annotations

import contextlib
import io
import json
import tempfile
import unittest
from pathlib import Path

from cli import toolkit


def run_cli(*args: str) -> tuple[int, str, str]:
    stdout = io.StringIO()
    stderr = io.StringIO()
    with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
        code = toolkit.main(list(args))
    return code, stdout.getvalue(), stderr.getvalue()


def write(path: Path, content: str = "") -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def make_source(root: Path, readme: str) -> None:
    write(root / "README.md", readme)
    write(root / "CHANGELOG.md", "# Changelog\n")
    write(root / "project.example.yaml", "project:\n  name: test\n")
    write(root / "docs" / "lessons-learned.md", "# Lessons\n")
    write(root / "adapters" / "codex.md", "# Codex\n")
    write(root / "adapters" / "claude-code.md", "# Claude\n")
    write(root / "workflows" / "new-feature" / "WORKFLOW.md", "# Workflow\n")
    write(root / "skills" / "release-version" / "SKILL.md", "# Release\n")
    write(root / "cli" / "toolkit.py", "# cli\n")


class ToolkitCliTest(unittest.TestCase):
    def test_skill_files_have_required_frontmatter(self) -> None:
        skills_root = Path(toolkit.__file__).resolve().parents[1] / "skills"

        for skill_file in skills_root.glob("*/SKILL.md"):
            with self.subTest(skill=skill_file.parent.name):
                content = skill_file.read_text(encoding="utf-8")

                self.assertTrue(content.startswith("---\n"))
                self.assertIn(f"name: {skill_file.parent.name}\n", content)
                self.assertIn("description: ", content)

    def test_status_before_install_reports_not_installed(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp) / "project"
            target.mkdir()

            code, stdout, stderr = run_cli("status", "--target", str(target))

            self.assertEqual(code, 0)
            self.assertIn("not installed", stdout)
            self.assertEqual(stderr, "")

    def test_install_creates_managed_copy_and_manifest(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp) / "project"
            target.mkdir()

            code, stdout, stderr = run_cli("install", "--target", str(target))

            managed = target / ".llm-toolkit" / "toolkit"
            manifest_path = target / ".llm-toolkit" / "manifest.json"
            manifest = json.loads(manifest_path.read_text(encoding="utf-8"))

            self.assertEqual(code, 0)
            self.assertIn("Installed toolkit", stdout)
            self.assertEqual(stderr, "")
            self.assertTrue((managed / "README.md").exists())
            self.assertTrue((managed / "skills" / "release-version" / "SKILL.md").exists())
            self.assertFalse((managed / "tests").exists())
            self.assertEqual(manifest["mode"], "local-sync")
            self.assertEqual(manifest["managed_path"], ".llm-toolkit/toolkit")
            self.assertEqual(manifest["source_path"], str(Path(toolkit.__file__).resolve().parents[1]))

    def test_update_replaces_only_managed_toolkit(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            source = root / "source"
            target = root / "project"
            target.mkdir()
            make_source(source, "version 2")

            toolkit_home = target / ".llm-toolkit"
            managed = toolkit_home / "toolkit"
            write(managed / "obsolete.md", "old")
            write(target / "keep.txt", "project data")
            write(
                toolkit_home / "manifest.json",
                json.dumps(
                    {
                        "schema_version": 1,
                        "mode": "local-sync",
                        "source_path": str(source),
                        "managed_path": ".llm-toolkit/toolkit",
                        "installed_at": "2026-07-05T00:00:00Z",
                        "updated_at": "2026-07-05T00:00:00Z",
                    }
                ),
            )

            code, stdout, stderr = run_cli("update", "--target", str(target))
            manifest = json.loads((toolkit_home / "manifest.json").read_text(encoding="utf-8"))

            self.assertEqual(code, 0)
            self.assertIn("Updated toolkit", stdout)
            self.assertEqual(stderr, "")
            self.assertEqual((target / "keep.txt").read_text(encoding="utf-8"), "project data")
            self.assertFalse((managed / "obsolete.md").exists())
            self.assertEqual((managed / "README.md").read_text(encoding="utf-8"), "version 2")
            self.assertEqual(manifest["source_path"], str(source))
            self.assertEqual(manifest["installed_at"], "2026-07-05T00:00:00Z")


if __name__ == "__main__":
    unittest.main()
