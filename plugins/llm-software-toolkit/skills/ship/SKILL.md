---
name: ship
description: Ship a coherent project change by recording it under the changelog's Unreleased section and preparing one safe local commit. Use when the user asks to ship a change or maintain the changelog as part of a commit; never version, push, tag or publish.
---

# Ship

## Boundary

Create exactly one local commit from one coherent, user-confirmed change set and record it under `Unreleased`. Do not create release headings, modify version metadata, push, tag, publish, bump versions, install Git hooks, change Git configuration, stash, revert, or discard changes.

## Steps

1. Read project instructions in this order when present: `project.yaml`, `AGENTS.md` or `agent.md`, `CLAUDE.md`, then technology manifests. Inspect `git status --short`, including staged and untracked files. Continue only in a Git worktree with changes to review.
2. Read the current branch with `git branch --show-current`. Stop when it returns nothing or returns `main` or `master`. Treat this check as the mandatory branch guard; do not install a persistent hook.
3. Inspect the complete staged and unstaged diffs, relevant untracked files, and recent commit history. Select one coherent change set supported by the user's request. Leave unrelated changes untouched and report them separately. Stop when no coherent set can be identified without user direction.
4. Find an existing changelog case-insensitively, preferring a project instruction's explicit path and otherwise the changelog nearest the repository root. Add concise entries supported by the selected diff under its existing `Unreleased` heading; if that heading is absent, create it immediately before the newest release heading without changing released history. Do not create a version heading or modify version files. If no changelog exists, ask for explicit approval before creating repository-root `CHANGELOG.md` with an `Unreleased` section; do not continue to commit until the changelog decision is resolved.
5. Run the focused tests, linters or validators required by project instructions and relevant to the selected change. Record every command and result. Stop when a required check fails or cannot be run without an unresolved blocker.
6. Read recent commit subjects and propose one message matching the repository's established language and format. Describe the selected change, not the act of committing it.
7. Show the exact proposed file list, changelog path and `Unreleased` entry summary, validation commands and results, proposed commit message, and any excluded working-tree changes. Confirm that no version metadata or release heading changed. Ask for explicit confirmation of this exact commit set and message. Do not treat an earlier request to ship as this confirmation.
8. After confirmation, repeat the branch guard and `git status --short`. Stop if the branch, selected files, their contents, or staging state changed since the review. Stage each confirmed path explicitly; never use `git add .`, `git add -A`, `git add --all`, or an equivalent broad command.
9. Compare `git diff --cached --name-only` with the confirmed file list and inspect the complete cached diff. Stop unless the lists match exactly and the cached diff still represents the confirmed coherent change. Create the local commit with the confirmed message.
10. Read the resulting commit hash, subject and file list. Report them with the changelog path, `Unreleased` entry and validation results. Leave every excluded change untouched and do not perform any remote or versioning operation.

## Stop conditions

Stop before committing on `main` or `master`, detached HEAD, an empty or incoherent change set, an unresolved changelog decision, a version or release-heading change introduced by `ship`, failed required validation, missing explicit confirmation, any post-confirmation change to the reviewed state, or any mismatch between confirmed and staged files.

Completion criterion: exactly one confirmed local commit exists on a non-protected branch, contains only the reviewed coherent change and its `Unreleased` changelog update, changes no version metadata, and the final report names its hash, message, files, changelog and validation results.
