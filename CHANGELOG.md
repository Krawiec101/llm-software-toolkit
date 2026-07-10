# Changelog

All notable changes to this project will be documented in this file.

## v1.2.0 - 2026-07-10

- Add the `ship` skill for changelog-aware, reviewed local commits with mandatory `main` and `master` branch guards.
- Allow `release-version` to include root README updates when they document plugin entrypoints or release boundaries.
- Keep project commit preparation separate from plugin version publishing and remote Git operations.

## v1.1.0 - 2026-07-10

- Restrict `release-version` to plugin runtime, marketplace metadata and directly related release documentation.
- Require synchronized plugin versions, successful validation and explicit confirmation of the exact publication set before commit or push.
- Prevent release commits from staging, modifying or publishing unrelated repository changes.

## v1.0.0 - 2026-07-06

- Move the toolkit runtime into `plugins/llm-software-toolkit/` as the canonical Codex and Claude Code plugin.
- Add native plugin manifests, marketplace metadata, workflow entrypoint skills and plugin-first documentation.
- Remove shell bootstrap installation as the public distribution model.

## v0.3.0 - 2026-07-06

- Change `release-version` to calculate patch/minor/major releases from remote tags, prepare release notes, confirm only the commit title, and push the branch plus exact release tag.

## v0.2.0 - 2026-07-05

- Add one-command project installation scripts that fetch and sync the toolkit from the public Git repository.
- Remove the duplicate install path so installation has a single Git-based bootstrap flow.

## v0.1.1 - 2026-07-05

- Tighten all skill instructions with clearer invocation descriptions and checkable step completion criteria.

## v0.1.0 - 2026-07-05

- Add initial toolkit structure with local sync tooling, workflow, skills, adapters, changelog and lessons learned docs.
