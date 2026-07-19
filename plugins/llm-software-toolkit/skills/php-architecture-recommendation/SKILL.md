---
name: php-architecture-recommendation
description: Recommend a proportionate PHP API architecture from discovery, including alternatives and override costs. Use when choosing framework conventions, clean vertical slices or a modular monolith.
---

# PHP Architecture Recommendation

Read `references/php-api-skill-contract.md`; apply its inspection and reporting rules if files may change.

1. Read complete discovery and classify descriptively, without scoring, in this order: business areas, rule complexity, 6-12 month growth, future dependencies, then team shape only if relevant.
2. Choose exactly one level: framework-conventional structure; clean architecture organized by vertical slices; or modular monolith with clean architecture, vertical slices and explicit module `PublicApi`.
3. Give at most two alternatives and their complexity, maintenance and risk trade-offs. Explain the same costs if the user overrides the recommendation. Provide a sample directory tree only for the recommendation.
4. For a modular monolith, derive modules from business capabilities; permit only synchronous cross-module calls through interfaces, contract DTOs or thin application facades in `PublicApi`; forbid business logic in facades, internal access, cycles, Shared Kernel and events. List every dependency with direction, contract and business reason, plus a documentation-only JSON module model.

Completion criterion: one proportionate recommendation is justified by every ordered criterion, with no needless abstraction and no unexplained module dependency.
