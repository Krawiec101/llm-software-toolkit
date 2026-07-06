# Codex Adapter

Use this adapter when working with the toolkit from Codex.

## Start

1. Read the user request.
2. Select the installed plugin skill that matches the request.
3. For feature implementation, use `llm-software-toolkit:new-feature`.
4. Keep the plugin workflow file as the source of truth.

## New feature workflow

For a new feature request, use the plugin workflow:

```text
plugins/llm-software-toolkit/workflows/new-feature/WORKFLOW.md
```

When the plugin is installed, invoke the namespaced skill `llm-software-toolkit:new-feature` or ask Codex to use the installed plugin's `new-feature` workflow.

## Single skills

Use a single plugin skill when the user asks for a focused task such as business refinement, implementation planning, frontend work, backend work, testing or release tagging.

## Rule

Do not bootstrap the toolkit into a project-managed copy. The native Codex plugin is the runtime boundary.
