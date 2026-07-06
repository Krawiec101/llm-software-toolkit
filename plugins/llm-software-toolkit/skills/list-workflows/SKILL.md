---
name: list-workflows
description: List the workflows available in the LLM Software Toolkit plugin and explain when to use each one. Use when the user asks what workflows the plugin provides.
disable-model-invocation: true
---

# List Workflows

List workflows from the plugin's `workflows/` directory. In this release, the canonical workflow is:

- `new-feature` - use for feature implementation work that needs requirements refinement, implementation planning, code changes, tests, validation and PR-ready notes.

Mention that `implement-feature` is an alias concept for `new-feature`, not a separate workflow directory. Do not claim that `debug-bug` exists in this plugin.
