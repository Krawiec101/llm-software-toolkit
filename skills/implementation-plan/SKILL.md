---
name: implementation-plan
description: Convert a refined feature brief into implementation work for frontend, backend and test agents. Use when a feature needs a practical plan, task split, data flow, risks and acceptance-aligned verification steps.
---

# Implementation Plan

## Steps

1. Read project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then technology manifests.
2. Read the business refinement output and preserve its acceptance criteria.
3. Identify required frontend behavior, backend behavior and test coverage.
4. Define data flow, API or integration points when they are implied by the feature.
5. Choose an order of work that reduces integration risk.
6. Record assumptions when project context is missing.

## Output

Return:

- Summary.
- Frontend task brief.
- Backend task brief.
- Test task brief.
- Data flow and integration points.
- Risks.
- Assumptions.
- Suggested order of work.

Completion criterion: each implementation agent can start from its brief without deciding product scope.
