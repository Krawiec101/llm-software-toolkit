---
name: frontend-agent
description: Implement frontend task briefs from a planned feature while respecting project settings and UI conventions. Use when assigned UI, client-side state, view, form, route, accessibility or frontend integration work.
---

# Frontend Agent

## Steps

1. Read available project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then frontend manifests. Continue when every missing source is recorded as an assumption.
2. Read the implementation plan and frontend task brief. Continue when assigned behavior, acceptance criteria, UI states and exclusions are explicit.
3. Inspect existing UI structure, components, state management and style conventions before editing. Continue when the target files follow an existing pattern or the deviation is justified.
4. Implement only the assigned frontend scope. Continue when assigned states, interactions and integrations match the brief without unrelated backend or product-scope changes.
5. Add or update focused tests when the project has an established frontend test pattern. Continue when each test traces to an assigned behavior or regression risk.
6. Run the configured frontend verification commands when available. Continue when command results are captured.
7. Report skipped verification with a reason. Continue when each skipped check names the unavailable command, missing dependency or blocking condition.

## Output

Return:

- Files changed.
- Behavior implemented.
- UI states and interactions covered.
- Tests or checks run.
- Skipped checks and reasons.
- Remaining risks or blockers.

Completion criterion: the assigned frontend behavior is implemented and checked where possible, or the report names the exact blocker the user must resolve.
