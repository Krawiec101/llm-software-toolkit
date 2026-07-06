# Authoring Guide

This guide defines how to add or update toolkit runtime artifacts.

## Plugin-first rule

Runtime artifacts belong under:

```text
plugins/llm-software-toolkit/
```

Do not create top-level runtime copies of workflows, skills or adapters. Top-level documentation may reference the plugin, but the plugin remains the source of truth.

## Workflow as a first-class artifact

A workflow is a repeatable operating procedure for development work. Use a workflow when the task spans multiple stages, produces multiple outputs, or needs coordination between skills, agents, checks and summaries.

Use a skill instead of a workflow when the task is narrow and can be completed through one focused instruction set. Use documentation when the content is background knowledge rather than an executable procedure. Use a command or prompt template when the operation is mostly invocation syntax. Use a Codex or Claude Code agent when the workflow needs a dedicated execution persona or tool boundary.

## Required workflow structure

Each workflow lives in:

```text
plugins/llm-software-toolkit/workflows/<workflow-name>/WORKFLOW.md
```

Each `WORKFLOW.md` must include sections for:

- Name or title.
- Kiedy uzywac.
- Kiedy nie uzywac.
- Wejscia.
- Wyjscia.
- Kroki.
- Walidacja.
- Checklista jakosci.
- Powiazane skille.
- Powiazani agenci Claude Code.
- Powiazane szablony agentow Codex.
- Znane ograniczenia.

Use English or ASCII Polish headings consistently. The validator accepts the required Polish headings and common English equivalents.

## Workflow classification

Classify each proposed workflow before adding files:

- New feature implementation: workflow plus supporting skills.
- Debugging or regression analysis: future workflow candidate, not included in the current plugin.
- Code review or security review: usually a skill or dedicated agent; promote to workflow only when it coordinates inspection, findings, fixes and validation.
- Refactor: workflow when it includes safety analysis, staged edits and broad validation; skill when it is a local refactor checklist.
- Test writing: usually a skill unless it coordinates product acceptance, fixtures and CI gates.
- CI repair: workflow when it spans remote check discovery, logs, local reproduction and patching.
- Release preparation: skill or workflow depending on whether it publishes artifacts.
- Migration: workflow when schema, data, compatibility and rollout are all in scope.
- Technical analysis before implementation: workflow only when it has structured outputs and decision gates.
- Issue, ticket or PR work: workflow when the artifact drives multiple implementation stages; otherwise a prompt template can be enough.

## Quality rules

- Keep workflows decision-complete enough for an agent to execute without inventing scope.
- Keep workflow steps behavior-level; do not duplicate every line from related skills.
- Link related skills instead of copying their full instructions.
- Avoid project-specific or customer-specific facts.
- Use placeholders for examples that might otherwise look private, such as `<API_TOKEN>` or `<CUSTOMER_NAME>`.
- Never include real secrets, tokens, keys, passwords or private customer data.
- Add or update validation when adding new workflow requirements.
