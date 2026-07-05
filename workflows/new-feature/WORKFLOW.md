# New Feature Workflow

Use this workflow to turn a feature idea into implementation and verification work. Keep each stage output compact and usable by the next stage.

## Required context pass

Before stage 1, read target project context in this order:

1. `project.yaml`, if present.
2. `AGENTS.md` or `agent.md`, if present.
3. `CLAUDE.md`, if present.
4. Technology manifests such as `package.json`, `pyproject.toml`, `composer.json`, `go.mod`.

Record missing context as explicit assumptions.

## Stage 1 - Business refinement

Use `skills/business-refinement/SKILL.md`.

Input:

- Raw feature idea.
- Known business or user context.
- Project constraints discovered in the context pass.

Output:

- User or actor.
- Problem and expected outcome.
- In scope.
- Out of scope.
- Acceptance criteria.
- Open questions or assumptions.

Completion criterion: another agent can understand what business result the feature should produce without rereading the conversation.

## Stage 2 - Implementation plan

Use `skills/implementation-plan/SKILL.md`.

Input:

- Business refinement output.
- Project context.

Output:

- Frontend task brief.
- Backend task brief.
- Test task brief.
- Data flow and integration points.
- Risks, assumptions and order of work.

Completion criterion: frontend, backend and test agents can start from their assigned briefs without inventing scope.

## Stage 3 - Frontend agent

Use `skills/frontend-agent/SKILL.md`.

Input:

- Implementation plan.
- Frontend task brief.
- Project UI conventions and commands.

Output:

- Files changed.
- UI behavior implemented.
- States covered.
- Verification performed or skipped with reason.

Completion criterion: frontend work is implemented or clearly blocked with exact missing information.

## Stage 4 - Backend agent

Use `skills/backend-agent/SKILL.md`.

Input:

- Implementation plan.
- Backend task brief.
- Project backend conventions and commands.

Output:

- Files changed.
- API, model, persistence or integration behavior implemented.
- Compatibility or migration notes.
- Verification performed or skipped with reason.

Completion criterion: backend work is implemented or clearly blocked with exact missing information.

## Stage 5 - Test agent

Use `skills/test-agent/SKILL.md`.

Input:

- Business acceptance criteria.
- Implementation plan.
- Frontend and backend reports.
- Project test commands.

Output:

- Tests added or updated.
- Commands run.
- Results.
- Remaining gaps and risk.

Completion criterion: the feature is verified against acceptance criteria or the remaining risk is explicit.
