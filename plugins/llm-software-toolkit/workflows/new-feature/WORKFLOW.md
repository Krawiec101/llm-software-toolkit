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

When an input is missing, record it as an assumption only when it does not require a product decision. Ask the user when the answer materially changes scope, behavior or risk. Do not invent questions for a complete request.

## Wyjscia

Expected outputs:

- Explicitly approved discovery brief with business value, flows, rules, scope, edge cases, risks and measurable acceptance criteria.
- Separately approved technical plan with changed areas, contracts, data flow, dependencies, compatibility, verification and sequencing.
- Delegation report for every execution subagent.
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

1. Run business discovery. Use `skills/business-refinement/SKILL.md` to identify the actor, problem, value, current and target flows, business rules, constraints, scope, non-goals, edge cases, risks, measurable acceptance criteria, assumptions and open questions. Resolve every material product decision, publish the complete brief and obtain explicit user approval of that exact version. The initial request to implement the feature is not approval of the later brief. If the user changes or rejects it, republish the complete revised brief and request approval again.
2. Pass the refinement gate. Until the latest brief is explicitly approved, stop the workflow: do not produce the final implementation plan, edit files or invoke frontend, backend or test implementation agents. No response, an ambiguous response or unresolved material questions do not pass the gate.
3. Identify code areas to change. Inspect existing modules, routes, UI components, domain logic, persistence, tests and integration points before deciding where the feature belongs.
4. Plan implementation. Use `skills/implementation-plan/SKILL.md` to map every acceptance criterion to frontend, backend and test briefs; define contracts, data flow, integration points, dependencies, migration or compatibility work, risks and implementation order. Classify frontend/backend briefs as independent or ordered.
5. Pass the technical-plan gate. Publish the complete technical plan and obtain explicit user approval of that exact version. Until approval, stop the workflow: do not edit implementation files or invoke implementation agents. Approval of the business brief or the initial request does not approve this plan. If any material part changes, republish the complete plan and request approval again.
6. Require native isolated subagents. The lead context owns discovery, planning, dispatch, integration and the final report; it must not perform frontend, backend or test execution. If the host cannot create a new subagent without the main conversation history, stop as blocked. Do not use local execution, role simulation or a full-history child as fallback.
7. Build one artifact packet per assigned role. Each packet must contain the role, approved business brief, approved technical plan, role task brief, assigned acceptance criteria, constraints and pointers to repository instructions. The packet is complete only when the role can execute without the main conversation history; do not dispatch an incomplete packet.
8. Dispatch implementation. Create a new isolated frontend subagent for frontend work and a new isolated backend subagent for backend work. Invoke independent briefs together and wait for both; invoke dependent briefs sequentially in the plan's dependency order and record the constraint. Every used role receives only its artifact packet and repository state, never the full conversation history. Use `skills/frontend-agent/SKILL.md` and `skills/backend-agent/SKILL.md` within their approved briefs; neither may change product scope or the shared contract independently.
9. Integrate the smallest coherent feature slice in the lead context. Reconcile reports and shared contracts without taking over unfinished role implementation. If rework is needed, dispatch a new isolated role subagent with a revised artifact packet.
10. Verify after integration. Create a fresh isolated test subagent with its artifact packet only after frontend/backend integration is complete. Use `skills/test-agent/SKILL.md` to map every acceptance criterion to automated or manual checks and add focused coverage where the project has a pattern.
11. Run integration validation in the lead context. Execute the repository's configured tests, lint, type checks or build commands that match the integrated surface. Record commands, results and skipped checks.
12. Describe changes. For every dispatched subagent report: subagent id, role, parallel or sequential mode, handed-off artifacts, status, result, changed areas, validation, blockers and risks. Also summarize integrated behavior, assumptions and residual risks.
13. Prepare the PR checklist. Confirm acceptance criteria coverage, validation status, migration or compatibility notes, documentation updates and follow-up work.

## Walidacja

The workflow is complete only when every acceptance criterion is verified or listed as an explicit gap. The final report must include:

- Implemented behavior.
- Approved business brief and technical-plan status.
- For every execution subagent: id, role, parallel or sequential mode, handed-off artifacts, status, result, changed areas, validation, blockers and risks.
- Tests added or updated.
- Commands run and results.
- Skipped validation with reasons.
- Remaining risk and follow-up items.
- PR checklist status.

## Checklista jakosci

- The implementation follows existing repository patterns and ownership boundaries.
- Every product-scope decision is backed by the refined requirements or recorded as an assumption.
- The latest complete refinement brief received explicit user approval before planning or implementation began.
- The latest complete technical plan received separate explicit user approval before implementation files changed or implementation agents were invoked.
- No frontend, backend or test execution occurred in the lead context, a full-history child or a simulated role.
- Every used execution role was a new isolated subagent receiving the complete artifact packet.
- Independent frontend and backend briefs were invoked together; every sequential path is justified by a plan dependency.
- The test role was a fresh isolated subagent dispatched only after integration.
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

Claude Code must provide fresh Task subagents for every used frontend, backend and test role. Project-defined role agents may be used only when each invocation is new and receives the artifact packet instead of the main conversation history.

## Powiazane szablony agentow Codex

Codex must provide fresh isolated subagents for every used frontend, backend and test role. A dedicated template is unnecessary when the native subagent call can supply the role skill and artifact packet without forking full conversation history.

## Znane ograniczenia

- This workflow does not include a bug-debugging procedure; do not add `debug-bug` behavior here.
- It assumes local validation commands can be discovered from the project. If not, record the gap instead of inventing commands.
- It does not define product requirements by itself; unclear product decisions remain assumptions or questions.
- It should not be copied into a project manually. Install and invoke it through the native plugin mechanism.
- Hosts without native isolated subagent capability cannot run this workflow; focused standalone execution skills remain available outside `new-feature`.
