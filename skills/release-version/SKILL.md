---
name: release-version
description: Prepare a repository release version with SemVer tagging. Use when the user wants to tag a concrete vX.Y.Z version, check changelog and lessons learned readiness, create a local annotated git tag, or prepare release push instructions without pushing automatically.
---

# Release Version

## Input

Require a version in the form `vX.Y.Z`, for example `v0.1.0`.

## Steps

1. Validate the requested version against `^v[0-9]+\.[0-9]+\.[0-9]+$`.
2. Read `CHANGELOG.md` and confirm it contains a heading for the requested version.
3. Read `docs/lessons-learned.md` and confirm whether the current release introduced a process lesson. If it did, require an entry before tagging.
4. Run `git status --short` and stop if the working tree is dirty.
5. Check that the tag does not already exist.
6. Create a local annotated tag:

```bash
git tag -a <version> -m "Release <version>"
```

7. Report the tag and the manual push command for this release tag only:

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
