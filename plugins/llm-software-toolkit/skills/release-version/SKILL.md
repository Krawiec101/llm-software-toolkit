---
name: release-version
description: Publish a new LLM Software Toolkit plugin version from a patch, minor, or major bump. Use only for plugin runtime, marketplace metadata, changelog, and directly related process notes; never release unrelated repository changes.
---

# Release Version

## Input

Require exactly one bump type: `patch`, `minor`, or `major`.

Treat the bump request as consent to prepare a plugin release. Before any commit or push, show the calculated version, complete release file set, release notes, commit title and tag, then require one explicit publication confirmation.

## Release scope

Allow changes only in:

- `plugins/llm-software-toolkit/`
- `scripts/validate-plugin.sh`, only when its changes validate the plugin version being published
- `.agents/plugins/marketplace.json`
- `.claude-plugin/marketplace.json`
- `CHANGELOG.md`
- `AGENTS.md`, only when documenting repository-wide agent rules that govern plugin development or release work
- `README.md`, only when documenting plugin entrypoints, installation or release workflow boundaries
- `docs/lessons-learned.md`, only when the plugin change introduces a reusable workflow, skill, adapter or release-process lesson

Stop when any tracked, staged or untracked change exists outside this scope. Do not stage, commit, revert, stash or otherwise modify an out-of-scope change.

## Steps

1. Validate the bump type. Continue only when it is exactly `patch`, `minor`, or `major`.
2. Inspect `git status --short` before editing. Continue only when every current change is inside the release scope and belongs to the plugin version being published.
3. Capture the current branch and upstream. Continue only when `git branch --show-current` returns a branch name and `git rev-parse --abbrev-ref --symbolic-full-name "@{u}"` returns `origin/<branch>`.
4. Refresh and read the remote release tags:

```bash
git fetch --tags origin
git ls-remote --tags origin "refs/tags/v*"
```

Continue only when both commands succeed. Treat `origin` as the release source of truth; use local tags only for conflict checks.

5. Select the highest remote SemVer tag after ignoring peeled refs ending in `^{}` and tags that do not match `^v[0-9]+\.[0-9]+\.[0-9]+$`. Continue with `v0.0.0` as the base version when no remote SemVer tag exists.
6. Calculate `<version>` from the base version:

- `patch`: `vX.Y.(Z+1)`
- `minor`: `vX.(Y+1).0`
- `major`: `v(X+1).0.0`

Use normal SemVer for all versions, including `0.x`; for example, `major` from `v0.2.0` becomes `v1.0.0`.

7. Confirm the base tag is safe for the current branch. When the base version is not `v0.0.0`, continue only when `git merge-base --is-ancestor <base-version> HEAD` succeeds.
8. Check for tag conflicts. Continue only when `git tag --list <version>` returns nothing and `git ls-remote --tags origin "refs/tags/<version>"` returns nothing.
9. Inspect the scoped diff and plugin history since the base tag. Continue only when every release item is a plugin runtime, packaging, documentation or process change inside the release scope.
10. Set the version without the leading `v` in both plugin manifests and the Claude Code marketplace entry:

- `plugins/llm-software-toolkit/.codex-plugin/plugin.json`
- `plugins/llm-software-toolkit/.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`

Continue only when all three values equal the calculated version with its leading `v` removed.
11. Update `CHANGELOG.md` with a heading for `<version>` and a concise summary supported by the scoped diff and history. Preserve existing history.
12. Read `docs/lessons-learned.md`. Add a dated entry only when the release introduces a reusable workflow, skill, adapter or release-process lesson; otherwise leave it unchanged.
13. Run the plugin validator. Continue only when validation succeeds.
14. Review `git status --short` and the complete diff. Continue only when every changed file is inside the release scope, every change belongs to this plugin release, version values agree, and release notes are supported by the diff.
15. Propose the commit title `Release <version>`. Show the calculated version, complete file list, release notes, commit title, target branch and tag, then ask the user to confirm publication. Continue only after explicit confirmation of this exact release set.
16. Stage exactly the reviewed release files by explicit path. Do not use `git add .`, `git add -A` or an equivalent broad command. Compare `git diff --cached --name-only` with the confirmed file list and continue only when they match exactly.
17. Create the release commit with the confirmed commit title, then push the current branch to its verified `origin/<branch>` upstream:

```bash
git commit -m "<confirmed commit title>"
git push origin HEAD:<branch>
```

18. Create an annotated release tag and push only that tag:

```bash
git tag -a <version> -m "Release <version>"
git push origin <version>
```

19. Confirm completion by checking that `git ls-remote --tags origin "refs/tags/<version>"` returns the exact remote tag.

## Stop conditions

Stop before committing, tagging or pushing as soon as any step's completion criterion cannot be met. Always stop when an out-of-scope change exists, remote tag state is unavailable, `<version>` already exists, the current branch does not contain the base release, plugin validation fails, version metadata disagrees, the user does not confirm the exact publication set, staged files differ from that set, or any push/tag command fails.

Completion criterion: the confirmed plugin release commit is pushed to the upstream branch, the annotated tag exists locally, the exact tag exists on `origin`, and the report names the version, commit title and published files.
