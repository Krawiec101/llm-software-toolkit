---
name: business-refinement
description: Refine raw feature ideas into business intent, scope, non-goals and tester-observable acceptance criteria. Use when planning a new feature, clarifying product value, or preparing the brief that implementation planning will consume.
---

# Business Refinement

## Steps

1. Read available project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then technology manifests. Record missing sources as assumptions only when they do not require a product decision.
2. Restate the feature as a business outcome, not an implementation request. Continue when the outcome can stand without the original wording.
3. Identify the user or actor, problem, desired outcome and value. Continue when each item is explicit or marked unknown.
4. Separate in-scope work from non-goals. Continue when each boundary could prevent a scope decision later.
5. Write acceptance criteria observable by a tester. Continue when each criterion has a visible behavior, state change or checkable result.
6. Ask open questions only when their answers materially change scope, behavior or risk. Do not invent a clarification question when the brief is already complete. Never replace a material product decision with an assumption.
7. Publish the complete refinement brief to the user. Include every output field below even when a field contains `None`.
8. Ask the user to explicitly approve the published brief. A short response such as `approved`, `OK` or an unambiguous equivalent is sufficient only when it refers to that brief. The original feature or implementation request is not approval of a brief produced later.
9. If the user changes or rejects any part of the brief, update and republish the complete brief, then request approval again.

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

## Approval gate

Do not hand the brief to implementation planning until the latest complete version has explicit user approval. No response, an ambiguous response or unresolved material questions leave the refinement incomplete.

Completion criterion: the latest complete brief can support implementation planning without rereading the raw idea, has no unresolved material product decisions and has explicit user approval.
