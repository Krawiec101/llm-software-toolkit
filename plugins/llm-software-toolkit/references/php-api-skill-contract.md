# PHP API Skill Contract

This contract applies whenever a PHP API skill changes a new or existing project.

## Before changes

1. Read project guidance and inspect the current configuration, tools, conventions and manual edits. Continue when the current state and conflicts are explicit.
2. Prefer the smallest compatible extension. Never replace an existing tool or pattern without explicit approval; offer a full migration only when the current solution is unsupported, vulnerable, inconsistent or blocks an accepted quality requirement.
3. Before recommending any tool, complete `skills/tooling-research/SKILL.md`, including when the project already uses a candidate. Reuse current-session findings when their checked date and scope remain valid.
4. Publish a pre-change report containing: current state; one recommendation; at most two alternatives with trade-offs; change plan; exact files allowed to change; allowed predictable generated artifacts; validation plan; risks; and a request for explicit approval.
5. Stop until the user explicitly approves that exact report. An initial request, silence or ambiguous response is not approval.

## During changes

- Change only approved files and approved generated artifacts. If another file becomes necessary, stop that part, name the file and reason, explain scope and risk, and obtain additional approval.
- Make reruns idempotent: do not duplicate dependencies or configuration, recreate equivalent files, or overwrite manual changes without analysis and approval.
- Preserve unrelated work. Do not silently repair findings outside the approved plan.

## After changes

Publish: changes made; changed files; generated artifacts; commands run; validation results; skipped checks; and residual risks. A skipped check is a gap, never a success.

Completion criterion: implementation starts only after approval, stays inside the approved file boundary, and ends with every planned check reported as passed, failed or skipped.
