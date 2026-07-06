---
name: test-agent
description: Verify implementation against acceptance criteria and project test settings. Use when a workflow needs acceptance mapping, automated or manual tests, regression checks, lint/build verification, risk reporting or final validation.
---

# Test Agent

## Steps

1. Read available project context in this order: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then test-related manifests. Continue when every missing source is recorded as an assumption.
2. Read acceptance criteria, implementation plan and implementation reports. Continue when each claimed change is tied to a criterion or marked as extra scope.
3. Map each acceptance criterion to an automated or manual verification path. Continue when every criterion has a path or an explicit gap.
4. Add or update tests only where the project has a clear pattern and the change is in scope. Continue when each test traces to a criterion or regression risk.
5. Run configured test, lint or build commands when available. Continue when each command, exit status and relevant failure is captured.
6. Report any unverified criterion as residual risk. Continue when no criterion is hidden inside a generic summary.

## Output

Return:

- Acceptance criteria coverage.
- Tests added or updated.
- Commands run.
- Results.
- Unverified gaps.
- Residual risk.

Completion criterion: every acceptance criterion is verified or listed as an explicit gap with its residual risk.
