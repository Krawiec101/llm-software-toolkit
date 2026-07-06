# New Feature Workflow

## Kiedy uzywac

Use this workflow when a request asks for a new product or engineering capability that needs requirements clarification, code changes, tests and a PR-ready summary. Treat `implement-feature` as a semantic alias for this workflow; the canonical directory name is `new-feature`.

Use it when the feature can be delivered through normal repository work: inspect the codebase, plan the change, implement the smallest coherent slice, update tests, run local validation and report the result.

## Kiedy nie uzywac

Do not use this workflow for pure bug diagnosis, incident response, security review, release publishing, dependency upgrades, broad migrations, CI repair, code review without implementation, or exploratory technical analysis that does not yet have product intent.

Do not use it when the user explicitly asks for only one focused skill such as business refinement, implementation planning, frontend work, backend work, testing or release work.

## Wejscia

Required inputs:

- Raw feature idea, issue, ticket, PR request or product requirement.
- Known business context, user or actor and expected outcome.
- Target repository branch or working tree context when relevant.
- Project constraints from `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, and technology manifests.
- Acceptance criteria when already known.

When an input is missing, record it as an assumption or ask only if it materially changes scope, behavior or risk.

## Wyjscia

Expected outputs:

- Refined requirement summary with scope and non-goals.
- Implementation plan with changed areas, data flow and sequencing.
- Patch implementing the feature, unless blocked.
- Tests added or updated, or a clear test gap with reason.
- Local validation results.
- Change summary suitable for PR notes.
- PR checklist with remaining risk.

## Wymagany kontekst

Before planning or editing, read target project context in this order:

1. `project.yaml`, if present.
2. `AGENTS.md` or `agent.md`, if present.
3. `CLAUDE.md`, if present.
4. Technology manifests such as `package.json`, `pyproject.toml`, `composer.json`, `go.mod`.

Record missing context as explicit assumptions.

## Kroki

1. Analyze requirements. Use `skills/business-refinement/SKILL.md` to identify the actor, problem, expected outcome, in-scope work, out-of-scope work, acceptance criteria, assumptions and open questions.
2. Identify code areas to change. Inspect existing modules, routes, UI components, domain logic, persistence, tests and integration points before deciding where the feature belongs.
3. Plan implementation. Use `skills/implementation-plan/SKILL.md` to produce frontend, backend and test briefs, data flow, integration points, risks and suggested order of work.
4. Implement the smallest coherent feature slice. Use `skills/frontend-agent/SKILL.md` and `skills/backend-agent/SKILL.md` when the work naturally splits across UI and backend concerns; otherwise keep the change in the relevant layer.
5. Add or update tests. Use `skills/test-agent/SKILL.md` to map acceptance criteria to automated or manual checks and add focused coverage where the project has a pattern.
6. Run local validation. Execute the repository's configured tests, lint, type checks or build commands that match the changed surface. Record commands, results and skipped checks.
7. Describe changes. Summarize files changed, behavior implemented, tests run, assumptions and residual risks.
8. Prepare the PR checklist. Confirm acceptance criteria coverage, validation status, migration or compatibility notes, documentation updates and follow-up work.

## Walidacja

The workflow is complete only when every acceptance criterion is verified or listed as an explicit gap. The final report must include:

- Implemented behavior.
- Tests added or updated.
- Commands run and results.
- Skipped validation with reasons.
- Remaining risk and follow-up items.
- PR checklist status.

## Checklista jakosci

- The implementation follows existing repository patterns and ownership boundaries.
- Every product-scope decision is backed by the refined requirements or recorded as an assumption.
- Tests trace to acceptance criteria or regression risk.
- Validation commands are appropriate to the changed surface.
- The final summary is short enough to paste into a PR.
- No secrets, customer-specific data or private environment details are added to the workflow output.

## Powiazane skille

- `skills/new-feature/SKILL.md` - native plugin entrypoint for this workflow.
- `skills/business-refinement/SKILL.md` - requirement refinement.
- `skills/implementation-plan/SKILL.md` - implementation planning.
- `skills/frontend-agent/SKILL.md` - frontend implementation.
- `skills/backend-agent/SKILL.md` - backend implementation.
- `skills/test-agent/SKILL.md` - acceptance and regression validation.

## Powiazani agenci Claude Code

No dedicated Claude Code subagent is required. If the target project already defines frontend, backend, test or review subagents, the lead session may delegate the matching stage while preserving this workflow as the source of truth.

## Powiazane szablony agentow Codex

No dedicated Codex agent template is required. Invoke the plugin skill `llm-software-toolkit:new-feature` or ask Codex to use this workflow from the installed plugin.

## Znane ograniczenia

- This workflow does not include a bug-debugging procedure; do not add `debug-bug` behavior here.
- It assumes local validation commands can be discovered from the project. If not, record the gap instead of inventing commands.
- It does not define product requirements by itself; unclear product decisions remain assumptions or questions.
- It should not be copied into a project manually. Install and invoke it through the native plugin mechanism.
