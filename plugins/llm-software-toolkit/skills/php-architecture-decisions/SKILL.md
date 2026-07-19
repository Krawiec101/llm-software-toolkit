---
name: php-architecture-decisions
description: Document already-made PHP API decisions as ADRs and an architecture report without inventing decisions. Use after discovery, architecture recommendation and tooling research close planning choices.
---

# PHP Architecture Decisions

Read and obey `references/php-api-skill-contract.md` before changing documentation.

1. Accept only closed upstream decisions; do not choose architecture or tooling. Group material decisions for architecture, contracts, security, framework and PHP, dependencies, persistence, environment, quality, tests, logging, OpenAPI and maintenance; omit trivial settings.
2. Create or update `docs/adr/NNNN-title.md` with number, title, status, date, context, problem, decision, alternatives, trade-offs, consequences, research sources, related ADRs and replacement link when superseded.
3. Before approval, update existing `proposed` ADRs. After explicit report approval, mark related ADRs `approved` before implementation. For a later material change, create a replacement, mark the old ADR `superseded`, update the report and require renewed approval.
4. Maintain `docs/architecture-decision.md` with plan status, discovery summary, recommendation, at most two alternatives, recommendation-only tree, optional documentation-only JSON module model, selected technologies, ADR index, risks, assumptions, implementation plan, `Out of scope for MVP`, and an explicit approval-waiting notice.

Completion criterion: every material closed decision appears once in an indexed ADR, lifecycle links are consistent, and the aggregate report exactly reflects the ADR set.
