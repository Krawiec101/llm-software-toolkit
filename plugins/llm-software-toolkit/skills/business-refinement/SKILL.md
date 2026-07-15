---
name: business-refinement
description: Discover and refine a feature into approved business intent, flows, rules, scope, edge cases, risks and measurable acceptance criteria. Use when a feature idea lacks decision-complete product intent or implementation planning needs an approved business brief.
---

# Business Refinement

## Steps

1. Read available project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then technology manifests. Record missing sources as assumptions only when they do not require a product decision.
2. Restate the feature as a business outcome, not an implementation request. Continue when the outcome can stand without the original wording.
3. Identify the user or actor, problem, expected outcome and business or user value. Continue when each item is explicit; an unknown that materially changes the feature remains an open question.
4. Describe the current flow and the target flow from the actor's perspective. Continue when triggers, main steps and observable outcome are clear for both, or the absence of a current flow is explicit.
5. Identify business rules, constraints and edge cases. Continue when decisions about eligibility, permissions, validation, state transitions, failure behavior and exceptional paths are explicit where relevant.
6. Separate in-scope work from non-goals and record product or delivery risks. Continue when each boundary could prevent a later scope decision and each material risk has an owner, mitigation or open question.
7. Write measurable acceptance criteria observable by a tester. Continue when each criterion names its precondition, action and checkable result without prescribing implementation.
8. Ask open questions whenever their answers materially change value, scope, behavior, acceptance criteria or risk. Do not publish the brief while a material product decision is unresolved, and never replace one with an assumption.
9. Publish the complete refinement brief to the user. Include every output field below even when a field contains `None`.
10. Ask the user to explicitly approve the published brief. A short response such as `approved`, `OK` or an unambiguous equivalent is sufficient only when it refers to that brief. The original feature or implementation request is not approval of a brief produced later.
11. If the user changes or rejects any part of the brief, update and republish the complete brief, then request approval again.

## Output

Return:

- User or actor.
- Problem.
- Expected outcome.
- Business or user value.
- Current flow.
- Target flow.
- Business rules and constraints.
- In scope.
- Out of scope.
- Edge cases.
- Risks and mitigations.
- Acceptance criteria.
- Assumptions.
- Open questions.

## Approval gate

Do not hand the brief to implementation planning until the latest complete version has explicit user approval. No response, an ambiguous response or unresolved material questions leave the refinement incomplete.

Completion criterion: the latest complete brief can support implementation planning without rereading the raw idea, contains a tester-observable definition of success, has no unresolved material product decisions and has explicit user approval.
