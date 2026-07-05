# Claude Code Adapter

Use this adapter when working with the toolkit from Claude Code.

## Start

1. Read the user request.
2. Read target project context in this order:
   - `project.yaml`
   - `AGENTS.md` or `agent.md`
   - `CLAUDE.md`
   - technology manifests such as `package.json`, `pyproject.toml`, `composer.json`, `go.mod`
3. Select the workflow or skill from `.llm-toolkit/toolkit/`.

## New feature workflow

For a new feature request, use:

```text
.llm-toolkit/toolkit/workflows/new-feature/WORKFLOW.md
```

Follow each stage and preserve its output as context for the next stage.

## Release tagging

For preparing a toolkit version, use:

```text
.llm-toolkit/toolkit/skills/release-version/SKILL.md
```

The skill may create a local annotated git tag, but it must not push without an explicit user request.
