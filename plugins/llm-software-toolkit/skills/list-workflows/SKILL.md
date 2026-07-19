---
name: list-workflows
description: List the workflows available in the LLM Software Toolkit plugin and when to use each one.
disable-model-invocation: true
---

# List Workflows

List workflows from the plugin's `workflows/` directory. In this release, the canonical workflows are:

- `new-feature` - use for feature implementation work that needs full business discovery, separate approval of the business brief and technical plan, coordinated parallel implementation where possible, tests, validation and PR-ready notes.
- `new-php-api` - use to create a local Symfony or Laravel JSON REST API from scratch through discovery, proportionate architecture selection, current tooling research, proposed ADRs, explicit approval, implementation and ADR-aligned validation.

Mention that `implement-feature` is an alias concept for `new-feature`, not a separate workflow directory. Do not claim that `debug-bug` exists in this plugin.
