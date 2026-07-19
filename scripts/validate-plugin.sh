#!/usr/bin/env sh
set -eu

ROOT="${1:-plugins/llm-software-toolkit}"

error() {
    printf 'error: %s\n' "$1" >&2
    exit 1
}

note() {
    printf '%s\n' "$1"
}

require_file() {
    if [ ! -f "$1" ]; then
        error "missing required file: $1"
    fi
}

has_heading() {
    file="$1"
    pattern="$2"
    grep -Eiq "^##+[[:space:]]*($pattern)([[:space:]]*$|[[:space:]:-])" "$file"
}

validate_workflow() {
    workflow_dir="$1"
    workflow_file="$workflow_dir/WORKFLOW.md"

    require_file "$workflow_file"

    has_heading "$workflow_file" "kiedy uzywac|when to use" \
        || error "$workflow_file is missing section: kiedy uzywac / when to use"
    has_heading "$workflow_file" "kiedy nie uzywac|when not to use" \
        || error "$workflow_file is missing section: kiedy nie uzywac / when not to use"
    has_heading "$workflow_file" "wejscia|inputs|required inputs|input" \
        || error "$workflow_file is missing section: wejscia / inputs"
    has_heading "$workflow_file" "wyjscia|outputs|expected outputs|output" \
        || error "$workflow_file is missing section: wyjscia / outputs"
    has_heading "$workflow_file" "kroki|steps" \
        || error "$workflow_file is missing section: kroki / steps"
    has_heading "$workflow_file" "wymagany kontekst|required context" \
        || error "$workflow_file is missing section: wymagany kontekst / required context"
    has_heading "$workflow_file" "bramki akceptacji|approval gates" \
        || error "$workflow_file is missing section: bramki akceptacji / approval gates"
    has_heading "$workflow_file" "walidacja|validation" \
        || error "$workflow_file is missing section: walidacja / validation"
    has_heading "$workflow_file" "checklista jakosci|quality checklist" \
        || error "$workflow_file is missing section: checklista jakosci / quality checklist"
    has_heading "$workflow_file" "powiazane skille|related skills" \
        || error "$workflow_file is missing section: powiazane skille / related skills"
    has_heading "$workflow_file" "powiazani agenci claude code|related claude code agents" \
        || error "$workflow_file is missing section: powiazani agenci Claude Code"
    has_heading "$workflow_file" "powiazane szablony agentow codex|related codex agent templates" \
        || error "$workflow_file is missing section: powiazane szablony agentow Codex"
    has_heading "$workflow_file" "znane ograniczenia|known limitations" \
        || error "$workflow_file is missing section: znane ograniczenia / known limitations"
}

validate_skill() {
    skill_dir="$1"
    skill_file="$skill_dir/SKILL.md"
    expected_name="$(basename "$skill_dir")"

    require_file "$skill_file"
    first_line="$(sed -n '1p' "$skill_file")"
    [ "$first_line" = "---" ] || error "$skill_file is missing YAML frontmatter"
    skill_name="$(sed -n '2,/^---$/p' "$skill_file" | sed -n 's/^name:[[:space:]]*//p' | head -n 1)"
    [ -n "$skill_name" ] || error "$skill_file frontmatter is missing name"
    [ "$skill_name" = "$expected_name" ] \
        || error "$skill_file name '$skill_name' does not match directory '$expected_name'"
}

line_is_placeholder() {
    line="$1"
    printf '%s\n' "$line" | grep -Eiq '<[^>]*(TOKEN|SECRET|KEY|PASSWORD|CUSTOMER|CLIENT|TENANT)[^>]*>' && return 0
    printf '%s\n' "$line" | grep -Eiq 'example|dummy|redacted|placeholder|changeme|replace-me|sample' && return 0
    return 1
}

scan_sensitive_content() {
    report="${TMPDIR:-/tmp}/llm-toolkit-validate.$$"
    : > "$report"

    find "$ROOT" -type f \( -name '*.md' -o -name '*.json' -o -name '*.yaml' -o -name '*.yml' -o -name '*.sh' \) | while IFS= read -r file; do
        grep -Eni '(api[_-]?key|secret|token|password|private[_-]?key|client[_-]?secret|customer|tenant|account)[[:space:]]*[:=][[:space:]]*["'\'']?[^"'\''][^[:space:]]{5,}' "$file" 2>/dev/null \
            | while IFS= read -r match; do
                if ! line_is_placeholder "$match"; then
                    printf 'error: sensitive or client-specific value candidate in %s: %s\n' "$file" "$match" >> "$report"
                fi
            done
    done

    if [ -s "$report" ]; then
        cat "$report" >&2
        rm -f "$report"
        exit 1
    fi

    rm -f "$report"
}

if [ ! -d "$ROOT" ]; then
    error "plugin root does not exist: $ROOT"
fi

require_file "$ROOT/.codex-plugin/plugin.json"
require_file "$ROOT/.claude-plugin/plugin.json"
require_file "$ROOT/README.md"

if [ -d "$ROOT/workflows" ]; then
    workflow_count=0
    for workflow_dir in "$ROOT"/workflows/*; do
        if [ -d "$workflow_dir" ]; then
            workflow_count=$((workflow_count + 1))
            validate_workflow "$workflow_dir"
        fi
    done

    if [ "$workflow_count" -eq 0 ]; then
        error "$ROOT/workflows exists but contains no workflow directories"
    fi
fi

if [ -d "$ROOT/skills" ]; then
    skill_count=0
    for skill_dir in "$ROOT"/skills/*; do
        if [ -d "$skill_dir" ]; then
            skill_count=$((skill_count + 1))
            validate_skill "$skill_dir"
        fi
    done

    if [ "$skill_count" -eq 0 ]; then
        error "$ROOT/skills exists but contains no skill directories"
    fi
fi

scan_sensitive_content

note "Plugin validation passed: $ROOT"
