# Lessons Learned

Ten dokument zapisuje wnioski z rozwoju toolkitu. Dopisuj wpis, gdy zmiana ujawnila blad procesu, niejasnosc workflowu, brakujaca regule albo decyzje, ktora powinna zostac zapamietana.

## Template

```md
### YYYY-MM-DD - Short title

- Change: What changed.
- Lesson: What we learned.
- Follow-up: What should be improved next.
```

## Entries

### 2026-07-10 - Shipping and releasing need separate boundaries

- Change: Added `ship` for reviewed local project commits while keeping `release-version` responsible for plugin publication.
- Lesson: Commit preparation and release publication need different consent gates and Git boundaries even when both maintain a changelog.
- Follow-up: Keep branch guards, explicit file staging and post-confirmation state checks mandatory for local shipping.

### 2026-07-10 - Plugin releases need an explicit boundary

- Change: Restricted `release-version` to plugin runtime, marketplace metadata and directly related release documentation.
- Lesson: A release skill should publish a reviewed plugin artifact set, not treat every current repository change as release content.
- Follow-up: Keep the release allowlist, synchronized version checks and staged-file comparison as mandatory publication gates.

### 2026-07-06 - Runtime should be installed as a plugin

- Change: Moved workflow and skill runtime under `plugins/llm-software-toolkit/` and removed shell bootstrap installation from the public flow.
- Lesson: A toolkit meant for Codex and Claude Code should use native plugin installation instead of asking agents to copy managed files into each project.
- Follow-up: Keep top-level docs descriptive and keep runtime behavior inside the plugin.

### 2026-07-06 - Release skills should own the full release flow

- Change: Expanded `release-version` from local tag preparation into a remote-first patch/minor/major release workflow.
- Lesson: A release skill is easier to use when the user chooses release intent, not an exact tag, and the skill checks remote state before publishing.
- Follow-up: Keep release automation narrow by pushing the current branch and exact calculated tag only.

### 2026-07-05 - Installation should start from the target project

- Change: Added bootstrap installers that fetch and sync the toolkit from public Git in the target project directory.
- Lesson: A toolkit used across projects should optimize for the caller's current directory and avoid duplicate install paths.
- Follow-up: Keep install and update commands idempotent so the same bootstrap command can be rerun safely.

### 2026-07-05 - Skill steps need local completion gates

- Change: Tightened every skill step with a checkable continuation condition.
- Lesson: Short skills still need explicit local gates; a single final criterion leaves too much room for agents to advance early.
- Follow-up: Keep future skills compact, but make each step prove it is ready for the next one.

### 2026-07-05 - Start small, keep workflow visible

- Change: Initial repo plan starts with one workflow, small skills and local sync tooling.
- Lesson: A small structure makes it easier to see where agents misread instructions before adding more automation.
- Follow-up: After first real use, tighten the steps that caused unclear outputs.
