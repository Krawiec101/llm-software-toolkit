---
name: business-refinement
description: Refine raw feature ideas into business intent, scope, non-goals and tester-observable acceptance criteria. Use when planning a new feature, clarifying product value, or preparing the brief that implementation planning will consume.
---

# Business Refinement

## Steps

1. Read available project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then technology manifests. Continue when every missing source is recorded as an assumption.
2. Restate the feature as a business outcome, not an implementation request. Continue when the outcome can stand without the original wording.
3. Identify the user or actor, problem, desired outcome and value. Continue when each item is explicit or marked unknown.
4. Separate in-scope work from non-goals. Continue when each boundary could prevent a scope decision later.
5. Write acceptance criteria observable by a tester. Continue when each criterion has a visible behavior, state change or checkable result.
6. List open questions only when they materially change scope, behavior or risk. Continue when every open question explains its impact.

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

Completion criterion: an implementation planner can create frontend, backend and test briefs from this output without rereading the raw idea.
