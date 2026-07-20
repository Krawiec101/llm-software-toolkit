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
    has_heading "$workflow_file" "wejscia|inputs|required inputs|input" \
        || error "$workflow_file is missing section: wejscia / inputs"
    has_heading "$workflow_file" "wyjscia|outputs|expected outputs|output" \
        || error "$workflow_file is missing section: wyjscia / outputs"
    has_heading "$workflow_file" "kroki|steps" \
        || error "$workflow_file is missing section: kroki / steps"
    has_heading "$workflow_file" "walidacja|validation" \
        || error "$workflow_file is missing section: walidacja / validation"

    if [ "$(basename "$workflow_dir")" = "new-feature" ]; then
        grep -Eiq 'new isolated subagent|fresh isolated subagent' "$workflow_file" \
            || error "$workflow_file must require fresh isolated execution subagents"
        grep -Eiq 'artifact packet' "$workflow_file" \
            || error "$workflow_file must define the execution artifact packet"
        grep -Eiq 'never the full conversation history' "$workflow_file" \
            || error "$workflow_file must prohibit full conversation history handoff"
        grep -Eiq 'do not use local execution.*fallback' "$workflow_file" \
            || error "$workflow_file must fail closed without a local-execution fallback"
        grep -Eiq 'fresh isolated test subagent' "$workflow_file" \
            || error "$workflow_file must require a fresh post-integration test subagent"
        grep -Eiq 'subagent id.*role.*parallel or sequential mode.*handed-off artifacts.*status.*result.*changed areas.*validation.*blockers.*risks' "$workflow_file" \
            || error "$workflow_file must define all delegation report fields"
        grep -Eiq 'must not perform frontend, backend or test execution' "$workflow_file" \
            || error "$workflow_file must prohibit execution roles in the lead context"
    fi
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

scan_sensitive_content

note "Plugin validation passed: $ROOT"
