# Codex Adapter

Use this adapter when working with the toolkit from Codex.

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

Run the workflow stages in order unless the user explicitly asks for a single stage.

## Single skills

Use a single skill when the user asks for a focused task such as business refinement, implementation planning, frontend work, backend work, testing or release tagging.

## Rule

Keep the workflow source as the authority. Do not copy instructions into local prompts unless the user wants a derived prompt.
