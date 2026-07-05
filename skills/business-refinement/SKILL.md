---
name: business-refinement
description: Refine a raw feature idea into business intent, scope, non-goals and acceptance criteria. Use when planning a new feature, clarifying product value, or preparing a brief before implementation agents start work.
---

# Business Refinement

## Steps

1. Read project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then technology manifests.
2. Restate the feature in business terms.
3. Identify the user or actor, problem, desired outcome and value.
4. Separate in-scope work from out-of-scope work.
5. Write acceptance criteria that are observable by a tester.
6. List open questions only when they materially change scope, behavior or risk.

## Output

Return:

- User or actor.
- Problem.
- Expected outcome.
- In scope.
- Out of scope.
- Acceptance criteria.
- Assumptions.
- Open questions.

Completion criterion: an implementation planner can create frontend, backend and test briefs without needing the original raw idea.
