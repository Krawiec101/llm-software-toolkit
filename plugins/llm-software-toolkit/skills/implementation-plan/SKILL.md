---
name: implementation-plan
description: Plan an approved business brief into a decision-complete technical plan for user approval and implementation agents. Use when a feature needs task ownership, contracts, data flow, dependencies, compatibility, sequencing or acceptance-aligned verification.
---

# Implementation Plan

## Steps

1. Read available project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then technology manifests. Continue when every missing source is recorded as an assumption.
2. Read the latest explicitly approved business refinement output and preserve its acceptance criteria verbatim. Stop if approval is missing or any material product question remains unresolved.
3. Inspect the relevant code areas before choosing an approach. Continue when the plan follows an existing pattern or explains why a deviation is required.
4. Map every acceptance criterion to frontend, backend and test work as applicable. Continue when every criterion has an implementation owner and verification path.
5. Define changed interfaces and contracts, including API, events, persistence, validation and data flow where relevant. Continue when each integration names its producer, consumer, data shape and failure behavior.
6. Identify dependencies between task briefs and classify frontend/backend work as independent or ordered. Continue when parallelizable work and every sequencing constraint are explicit.
7. Define migration, rollout, backward-compatibility and documentation work where relevant. Use `None` when an area is genuinely unaffected rather than omitting it.
8. Choose an integration order that reduces risk and identifies the first verifiable slice. Continue when implementation, integration and validation checkpoints are explicit.
9. Record risks and assumptions. Continue when each risk has a mitigation or verification and every assumption names the missing source or uncertainty.
10. Publish the complete technical plan to the user and request explicit approval of that exact version. Do not invoke implementation agents or edit implementation files before approval.
11. If the user changes or rejects any material part of the plan, update and republish the complete plan, then request approval again.

## Output

Return:

- Summary.
- Acceptance criteria mapping.
- Frontend task brief.
- Backend task brief.
- Test task brief.
- Changed interfaces and contracts.
- Data flow and integration points.
- Dependencies and parallelization decision.
- Migration, compatibility, rollout and documentation notes.
- Risks.
- Assumptions.
- Suggested order of work.

## Approval gate

Do not hand task briefs to implementation agents until the latest complete technical plan has explicit user approval. The approval of the business brief or the original implementation request does not approve the technical plan. No response, an ambiguous response or a material plan change leaves planning incomplete.

Completion criterion: the latest technical plan is explicitly approved and each implementation agent can start from its brief without deciding product scope, contracts, dependencies or acceptance criteria.
