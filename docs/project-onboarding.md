# Project Onboarding

This guide explains how a project should use LLM Software Toolkit without copying workflow files by hand.

## Principle

Install the toolkit as a native plugin in the agent tool. The target project should reference the plugin's workflows and skills, not vendor the runtime files into its own repository.

## Recommended project setup

1. Add a short note to the project's agent guidance file, such as `AGENTS.md` or `CLAUDE.md`, saying that feature work should use the installed `llm-software-toolkit:new-feature` workflow.
2. Keep project-specific commands, environment notes and architecture rules in the target project's own guidance files.
3. Let the plugin provide repeatable workflow procedure.
4. Do not copy `WORKFLOW.md` or `SKILL.md` files into the project unless you intentionally fork the toolkit.

## Codex users

Install the plugin from the repository marketplace used by your team:

```text
codex plugin marketplace add <repo-url-or-local-path>
codex plugin add llm-software-toolkit@llm-software-toolkit
```

Then start feature work by invoking or requesting:

```text
llm-software-toolkit:new-feature
```

For focused work, use one of the narrower plugin skills such as `business-refinement`, `implementation-plan`, `frontend-agent`, `backend-agent` or `test-agent`.

## Claude Code users

Install the plugin from the repository marketplace used by your team, then start feature work with:

```text
/llm-software-toolkit:new-feature
```

Use `/llm-software-toolkit:list-workflows` to check what this plugin currently provides.

## Updating the toolkit

Projects should update the installed plugin through the tool's plugin update mechanism. Do not edit plugin cache files directly and do not manually copy workflow files into the project.

## Project-local extensions

If a project needs extra behavior, prefer adding project-local guidance or project-local skills that reference the toolkit workflow. Fork the toolkit only when the shared workflow itself should change for every project.
