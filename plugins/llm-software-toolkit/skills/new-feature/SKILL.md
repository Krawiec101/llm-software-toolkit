---
name: new-feature
description: Implement a feature through approved business discovery, approved technical planning, coordinated implementation and validation. Use when a feature request spans product decisions, code changes and acceptance verification.
---

# New Feature

Use the workflow source of truth at `workflows/new-feature/WORKFLOW.md` inside this plugin.

## Steps

1. Read the complete workflow before planning or editing. Continue when its inputs, outputs, stages, approval gates and validation criteria are understood.
2. Execute its stages and stop gates in order unless the user explicitly requests one focused stage. Continue when every completed stage satisfies its local continuation condition.
3. Preserve each approved artifact and stage report as context for the next stage. Continue when no downstream task must rediscover or reinterpret an upstream decision.
4. End with the workflow's required validation report and PR checklist.

## Output

Return every output required by `workflows/new-feature/WORKFLOW.md`.

Completion criterion: the feature workflow has either produced implemented and validated work or a precise blocker report.
