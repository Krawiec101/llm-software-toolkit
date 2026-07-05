---
name: backend-agent
description: Implement backend task briefs from a planned feature while respecting project settings and backend conventions. Use when assigned API, domain logic, persistence, migration, job, event, authorization or integration work.
---

# Backend Agent

## Steps

1. Read available project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then backend manifests. Continue when every missing source is recorded as an assumption.
2. Read the implementation plan and backend task brief. Continue when assigned behavior, acceptance criteria, data contracts and exclusions are explicit.
3. Inspect existing module boundaries, API patterns, validation, authorization, persistence and test style before editing. Continue when the target files follow an existing pattern or the deviation is justified.
4. Implement only the assigned backend scope. Continue when APIs, domain effects and persistence changes match the brief without unrelated frontend or product-scope changes.
5. Add or update focused tests when the project has an established backend test pattern. Continue when each test traces to an assigned behavior or regression risk.
6. Run the configured backend verification commands when available. Continue when command results are captured.
7. Report skipped verification with a reason. Continue when each skipped check names the unavailable command, missing dependency or blocking condition.

## Output

Return:

- Files changed.
- Behavior implemented.
- API, persistence, authorization or integration notes.
- Tests or checks run.
- Skipped checks and reasons.
- Remaining risks or blockers.

Completion criterion: the assigned backend behavior is implemented and checked where possible, or the report names the exact blocker the user must resolve.
