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
