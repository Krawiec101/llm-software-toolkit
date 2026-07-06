# Claude Code Adapter

Use this adapter when working with the toolkit from Claude Code.

## Start

1. Read the user request.
2. Select the installed plugin skill that matches the request.
3. For feature implementation, use `/llm-software-toolkit:new-feature`.
4. Preserve each workflow stage output as context for the next stage.

## New feature workflow

For a new feature request, use the plugin workflow:

```text
plugins/llm-software-toolkit/workflows/new-feature/WORKFLOW.md
```

When the plugin is installed, invoke:

```text
/llm-software-toolkit:new-feature
```

## Release

For preparing and publishing a toolkit release, use:

```text
/llm-software-toolkit:release-version patch
/llm-software-toolkit:release-version minor
/llm-software-toolkit:release-version major
```

## Rule

Do not bootstrap the toolkit into a project-managed copy. The native Claude Code plugin is the runtime boundary.
