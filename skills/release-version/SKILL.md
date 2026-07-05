---
name: release-version
description: Release a concrete vX.Y.Z repository version with SemVer tagging. Use when the user wants changelog and lessons-learned readiness checked, a local annotated git tag created, or release push instructions prepared without pushing automatically.
---

# Release Version

## Input

Require a version in the form `vX.Y.Z`, for example `v0.1.0`.

## Steps

1. Validate the requested version against `^v[0-9]+\.[0-9]+\.[0-9]+$`. Continue only when the version matches exactly.
2. Read `CHANGELOG.md` and confirm it contains a heading for the requested version. Continue only when the heading is present.
3. Read `docs/lessons-learned.md` and decide whether the release changed workflow, skill, adapter or process rules. Continue only when no process lesson is implied or a matching entry exists.
4. Run `git status --short`. Continue only when the working tree is clean.
5. Check that the tag does not already exist. Continue only when the version is untagged.
6. Create a local annotated tag and confirm it exists. Continue when `git tag --list <version>` returns the requested tag:

```bash
git tag -a <version> -m "Release <version>"
```

7. Report the tag and the manual push command for this release tag only. Done when the command names the exact tag:

```bash
git push origin <version>
```

## Stop conditions

Stop before tagging when:

- The version is not SemVer in `vX.Y.Z` form.
- `CHANGELOG.md` lacks the version entry.
- A required lessons learned entry is missing.
- The working tree is dirty.
- The tag already exists.

Completion criterion: the local annotated tag exists and the user has an explicit manual push command, or the report lists the exact blocker.
