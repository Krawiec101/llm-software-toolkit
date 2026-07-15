# LLM Software Toolkit Plugin

This directory is the canonical runtime for LLM Software Toolkit. Install it through Codex or Claude Code plugin mechanisms; do not copy workflow files into a project manually.

## Claude Code

From Claude Code, add this repository as a marketplace and install the plugin:

```text
/plugin marketplace add <repo-url-or-local-path>
/plugin install llm-software-toolkit@llm-software-toolkit
```

For local development from the repository root:

```text
/plugin marketplace add .
/plugin install llm-software-toolkit@llm-software-toolkit
```

Use the workflow skill:

```text
/llm-software-toolkit:new-feature
/llm-software-toolkit:list-workflows
```

Prepare a reviewed local project commit and record it under `Unreleased` without versioning:

```text
/llm-software-toolkit:ship
```

## Codex

Use the repo marketplace entry in `.agents/plugins/marketplace.json`, then add the plugin from the `llm-software-toolkit` marketplace in Codex:

```text
codex plugin marketplace add <repo-url-or-local-path>
codex plugin add llm-software-toolkit@llm-software-toolkit
```

The plugin manifest is:

```text
plugins/llm-software-toolkit/.codex-plugin/plugin.json
```

Use the installed plugin skill `llm-software-toolkit:new-feature` for feature implementation work.

Use `llm-software-toolkit:ship` to record changes under `Unreleased` and create a reviewed local project commit. It never versions, pushes, tags or publishes; `llm-software-toolkit:release-version` is the separate skill for publishing toolkit plugin versions.

## Workflows

- `new-feature` - implement a feature through full business discovery, separate approval of the business brief and technical plan, parallel layer work where independent, tests, validation and PR notes.

`implement-feature` is an alias concept for `new-feature`; it is not a separate workflow directory. `debug-bug` is not included in this plugin release.

## Runtime Boundary

The workflow and skill files in this plugin are the source of truth. Top-level repository docs explain authoring and compatibility, but runtime instructions belong here.
