---
name: implementation-plan
description: Plan a refined feature brief into implementation work for frontend, backend and test agents. Use when a feature needs task splits, data flow, integration points, risks, sequencing or acceptance-aligned verification.
---

# Implementation Plan

## Steps

1. Read available project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then technology manifests. Continue when every missing source is recorded as an assumption.
2. Read the business refinement output and preserve its acceptance criteria. Continue when no criterion has been dropped or rewritten.
3. Identify required frontend behavior, backend behavior and test coverage. Continue when each acceptance criterion maps to one or more implementation areas.
4. Define data flow, API, persistence or integration points implied by the feature. Continue when each integration names producer, consumer and changed data.
5. Choose an order of work that reduces integration risk. Continue when dependencies and the first verifiable slice are clear.
6. Record assumptions when project context is missing. Continue when every assumption names the missing source or uncertainty.

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

Completion criterion: each implementation agent can start from its brief without deciding product scope or rediscovering acceptance criteria.
