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

### 2026-07-20 - Release scope must include its validator

- Change: Allowed `release-version` to publish changes to the repository plugin validator when they validate the plugin version being released.
- Lesson: A release skill cannot require a validator while excluding necessary validator changes from its release allowlist.
- Follow-up: Keep validation tooling narrowly allowlisted by exact path and require every validator change to belong to the plugin release.

### 2026-07-20 - Execution-role isolation must fail closed

- Change: Required fresh history-isolated frontend, backend and test subagents in `new-feature`, with complete artifact packets and observable delegation reports.
- Lesson: Delegation language still permits lead-context execution or full-history children unless isolation, handoff contents and the no-fallback failure mode are explicit.
- Follow-up: Keep discovery, planning and integration in the lead; block the workflow when native isolation is unavailable and preserve standalone role skills outside it.

### 2026-07-19 - Decision support should elicit before advising

- Change: Split `decision-tradeoffs` into requirements clarification, separate benefits and drawbacks turns for each option, and a later analysis that responds before adding new considerations.
- Lesson: A decision-support skill can produce a useful answer while failing to teach if it supplies tradeoffs too early, groups every option together or combines positive and negative reflection in one prompt.
- Follow-up: Keep explicit wait gates after requirements, benefits and drawbacks for each option, then distinguish user-supplied arguments from model-added considerations.

### 2026-07-15 - Planning gates and delegation must be observable

- Change: Added full business discovery, a separate technical-plan approval gate, explicit concurrent delegation for independent frontend/backend work and `Unreleased`-only changelog handling in `ship`.
- Lesson: Naming a planning stage or multiple agents does not ensure user approval or real concurrency; workflows must define visible stop gates, invocation timing and reporting evidence.
- Follow-up: Keep business and technical approvals distinct, require reasons for non-parallel execution, and reserve version metadata for the release workflow.

### 2026-07-11 - Repository agent rules can be release artifacts

- Change: Allowed root `AGENTS.md` in plugin releases when it documents repository-wide rules for plugin development or publication.
- Lesson: Agent instructions can be part of the shipped development process even when they live outside the plugin runtime directory.
- Follow-up: Keep `AGENTS.md` release-scoped to reusable plugin or release rules; reject unrelated project instructions.

### 2026-07-11 - Requirement refinement needs explicit user approval

- Change: Added a mandatory refinement brief and approval gate before implementation planning or code changes in the `new-feature` workflow.
- Lesson: A refinement step can be skipped or performed only internally unless the workflow requires a visible artifact and an explicit user response.
- Follow-up: Keep product questions limited to material decisions, but never let assumptions or an initial implementation request bypass approval of the latest complete brief.

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
