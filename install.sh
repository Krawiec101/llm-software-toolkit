#!/usr/bin/env sh
set -eu

REPO_URL="${LLM_TOOLKIT_REPO_URL:-https://github.com/Krawiec101/llm-software-toolkit.git}"
REF="${LLM_TOOLKIT_REF:-main}"
CACHE_DIR="${LLM_TOOLKIT_CACHE_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}/llm-software-toolkit/source}"
PROJECT_DIR="$(pwd -P 2>/dev/null || pwd)"
TOOLKIT_HOME=".llm-toolkit"
MANAGED_DIR="toolkit"
MANIFEST_NAME="manifest.json"
COPY_ITEMS="README.md CHANGELOG.md install.ps1 install.sh docs adapters workflows skills"

need_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "error: $1 was not found" >&2
        exit 1
    fi
}

utc_now() {
    date -u '+%Y-%m-%dT%H:%M:%SZ'
}

json_escape() {
    printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

assert_child_path() {
    case "$1" in
        "$PROJECT_DIR"/*) ;;
        *)
            echo "error: refusing unsafe path outside target project: $1" >&2
            exit 1
            ;;
    esac
}

read_installed_at() {
    if [ ! -f "$1" ]; then
        printf '%s' "$2"
        return
    fi

    installed="$(sed -n 's/^[[:space:]]*"installed_at"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$1" | head -n 1)"
    if [ -n "$installed" ]; then
        printf '%s' "$installed"
    else
        printf '%s' "$2"
    fi
}

sync_toolkit() {
    source_dir="$1"
    home_dir="$PROJECT_DIR/$TOOLKIT_HOME"
    managed="$home_dir/$MANAGED_DIR"
    tmp="$home_dir/$MANAGED_DIR.tmp"

    assert_child_path "$managed"
    assert_child_path "$tmp"
    mkdir -p "$home_dir"

    if [ -e "$tmp" ]; then
        rm -rf "$tmp"
    fi
    mkdir -p "$tmp"

    for item in $COPY_ITEMS; do
        source_item="$source_dir/$item"
        target_item="$tmp/$item"
        if [ ! -e "$source_item" ]; then
            echo "error: required source item is missing: $source_item" >&2
            rm -rf "$tmp"
            exit 1
        fi
        cp -R "$source_item" "$target_item"
    done

    if [ -e "$managed" ]; then
        rm -rf "$managed"
    fi
    mv "$tmp" "$managed"
}

write_manifest() {
    manifest_path="$1"
    installed_at="$2"
    updated_at="$3"
    source_commit="$4"
    mkdir -p "$(dirname "$manifest_path")"

    {
        printf '{\n'
        printf '  "schema_version": 1,\n'
        printf '  "mode": "git-bootstrap",\n'
        printf '  "source_remote": "%s",\n' "$(json_escape "$REPO_URL")"
        printf '  "source_ref": "%s",\n' "$(json_escape "$REF")"
        printf '  "source_commit": "%s",\n' "$(json_escape "$source_commit")"
        printf '  "managed_path": "%s/%s",\n' "$TOOLKIT_HOME" "$MANAGED_DIR"
        printf '  "installed_at": "%s",\n' "$(json_escape "$installed_at")"
        printf '  "updated_at": "%s",\n' "$(json_escape "$updated_at")"
        printf '  "copy_items": [\n'
        first=1
        for item in $COPY_ITEMS; do
            if [ "$first" -eq 1 ]; then
                first=0
            else
                printf ',\n'
            fi
            printf '    "%s"' "$(json_escape "$item")"
        done
        printf '\n'
        printf '  ]\n'
        printf '}\n'
    } > "$manifest_path"
}

need_command git

if [ -d "$CACHE_DIR/.git" ]; then
    git -C "$CACHE_DIR" remote set-url origin "$REPO_URL"
    git -C "$CACHE_DIR" fetch --tags origin
    git -C "$CACHE_DIR" checkout "$REF"
    BRANCH="$(git -C "$CACHE_DIR" rev-parse --abbrev-ref HEAD)"
    if [ "$BRANCH" != "HEAD" ]; then
        git -C "$CACHE_DIR" pull --ff-only origin "$BRANCH"
    fi
elif [ -e "$CACHE_DIR" ]; then
    echo "error: cache path exists but is not a git repository: $CACHE_DIR" >&2
    exit 1
else
    mkdir -p "$(dirname "$CACHE_DIR")"
    git clone "$REPO_URL" "$CACHE_DIR"
    git -C "$CACHE_DIR" checkout "$REF"
fi

NOW="$(utc_now)"
MANIFEST="$PROJECT_DIR/$TOOLKIT_HOME/$MANIFEST_NAME"
INSTALLED_AT="$(read_installed_at "$MANIFEST" "$NOW")"
SOURCE_COMMIT="$(git -C "$CACHE_DIR" rev-parse HEAD)"

sync_toolkit "$CACHE_DIR"
write_manifest "$MANIFEST" "$INSTALLED_AT" "$NOW" "$SOURCE_COMMIT"

echo "Installed toolkit into $PROJECT_DIR/$TOOLKIT_HOME/$MANAGED_DIR"
echo "Manifest: $MANIFEST"
echo "Toolkit source: $CACHE_DIR"
echo "Toolkit ref: $REF"
