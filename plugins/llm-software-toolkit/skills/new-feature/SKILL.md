---
name: new-feature
description: Run the LLM Software Toolkit new-feature workflow for feature implementation work. Use when a feature request needs requirements analysis, code-area discovery, implementation planning, code changes, tests, validation and PR-ready notes.
---

# New Feature

Use the workflow source of truth at `workflows/new-feature/WORKFLOW.md` inside this plugin.

## Steps

1. Read the workflow before planning or editing. Continue only when the workflow sections for inputs, outputs, steps and validation are understood.
2. Gather target project context in the order required by the workflow. Continue when missing context is recorded as assumptions.
3. Execute the workflow stages in order unless the user explicitly asks for a single stage.
4. Preserve each stage output as context for the next stage.
5. End with the workflow's required validation report and PR checklist.

## Output

Return the workflow output requested by `workflows/new-feature/WORKFLOW.md`: refined requirements, implementation plan, patch summary, tests or gaps, validation results, risks and PR checklist.

Completion criterion: the feature workflow has either produced implemented and validated work or a precise blocker report.
