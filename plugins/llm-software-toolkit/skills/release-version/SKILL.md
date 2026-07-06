---
name: release-version
description: Release a repository from a patch, minor, or major bump by calculating the next SemVer from origin tags, preparing release notes, confirming the commit title, pushing the branch, and pushing exactly one annotated tag.
---

# Release Version

## Input

Require exactly one bump type: `patch`, `minor`, or `major`.

Treat the bump request as consent to prepare release docs, create a release commit, push the current branch to `origin`, create an annotated tag, and push exactly that tag. Ask the user only to confirm or replace the commit title.

## Steps

1. Validate the bump type. Continue only when it is exactly `patch`, `minor`, or `major`.
2. Capture the current branch and upstream. Continue only when `git branch --show-current` returns a branch name and `git rev-parse --abbrev-ref --symbolic-full-name "@{u}"` returns `origin/<branch>`.
3. Refresh and read the remote release tags:

```bash
git fetch --tags origin
git ls-remote --tags origin "refs/tags/v*"
```

Continue only when both commands succeed. Treat `origin` as the release source of truth; use local tags only for conflict checks.

4. Select the highest remote SemVer tag after ignoring peeled refs ending in `^{}` and tags that do not match `^v[0-9]+\.[0-9]+\.[0-9]+$`. Continue with `v0.0.0` as the base version when no remote SemVer tag exists.
5. Calculate `<version>` from the base version:

- `patch`: `vX.Y.(Z+1)`
- `minor`: `vX.(Y+1).0`
- `major`: `v(X+1).0.0`

Use normal SemVer for all versions, including `0.x`; for example, `major` from `v0.2.0` becomes `v1.0.0`.

6. Confirm the base tag is safe for the current branch. When the base version is not `v0.0.0`, continue only when `git merge-base --is-ancestor <base-version> HEAD` succeeds.
7. Check for tag conflicts. Continue only when `git tag --list <version>` returns nothing and `git ls-remote --tags origin "refs/tags/<version>"` returns nothing.
8. Inspect `git status --short`, `git diff`, and `git log <base-version>..HEAD` when a base tag exists, or the full available history when the base is `v0.0.0`. Use this context to prepare release notes.
9. Update `CHANGELOG.md` with a heading for `<version>` and a concise summary supported by the inspected diff or log. Preserve existing changelog history.
10. Read `docs/lessons-learned.md`. Add a dated entry only when the release changes workflow, skill, adapter, or process rules; otherwise leave it unchanged.
11. Review the resulting diff. Continue only when every release note and optional lessons learned entry is backed by the inspected changes.
12. Propose the commit title `Release <version>` and ask the user to confirm it or provide a replacement. Continue only after the commit title is confirmed.
13. Stage the release docs and any current repository changes described by the release notes. Continue only when no unrelated or unclear change is staged.
14. Create the release commit with the confirmed commit title, then push the current branch to its verified `origin/<branch>` upstream:

```bash
git commit -m "<confirmed commit title>"
git push origin HEAD:<branch>
```

15. Create an annotated release tag and push only that tag:

```bash
git tag -a <version> -m "Release <version>"
git push origin <version>
```

16. Confirm completion by checking that `git ls-remote --tags origin "refs/tags/<version>"` returns the exact remote tag.

## Stop conditions

Stop before committing, tagging, or pushing as soon as any step's completion criterion cannot be met. Always stop when remote tag state is unavailable, `<version>` already exists, the current branch does not contain the base release, the user does not confirm a commit title, release notes are unsupported, unrelated changes would be staged, or any push/tag command fails.

Completion criterion: the release commit is pushed to the upstream branch, the annotated tag exists locally, the exact tag exists on `origin`, and the report names the calculated version and confirmed commit title.
