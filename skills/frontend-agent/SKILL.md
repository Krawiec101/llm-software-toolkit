---
name: frontend-agent
description: Implement the frontend portion of a planned feature while respecting target project settings and UI conventions. Use when a workflow assigns UI, client-side state, view, form, route or frontend integration work.
---

# Frontend Agent

## Steps

1. Read project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then frontend manifests.
2. Read the implementation plan and the frontend task brief.
3. Inspect existing UI structure, components, state management and style conventions before editing.
4. Implement only the assigned frontend scope.
5. Add or update focused tests when the project has an established frontend test pattern.
6. Run the configured frontend verification commands when available.
7. Report skipped verification with a reason.

## Output

Return:

- Files changed.
- Behavior implemented.
- UI states covered.
- Tests or checks run.
- Skipped checks and reasons.
- Remaining risks or blockers.

Completion criterion: the assigned frontend behavior is implemented or the blocker is specific enough for the user to resolve.
