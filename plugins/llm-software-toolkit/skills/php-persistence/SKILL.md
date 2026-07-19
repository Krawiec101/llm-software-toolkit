---
name: php-persistence
description: Add approved PostgreSQL persistence to a Symfony or Laravel API using mature framework-compatible data and migration tools. Use only when persistence is required.
---

# PHP Persistence

Read and obey `references/php-api-skill-contract.md`. Stop when persistence is not required. Ask the user to choose ORM or DBAL/query builder, then complete `tooling-research` for tools and identifier version.

Use PostgreSQL only. Never build an ORM, DBAL, query builder, database client or migration system. Define use-case-shaped repository contracts with infrastructure implementations; no generic `BaseRepository` or copied ORM API. Offer combined read/write repository or separate read model/query service without calling the latter CQRS. Use mature migrations run manually through PHP after environment rebuild, never at image build or every restart. Wrap modifying use cases with a transaction decorator; use an attribute only through a stable existing mechanism, never custom reflection. Reads are non-transactional by default. Recommend researched UUID while allowing an approved identifier override.

Completion criterion: approved persistence, migrations, identifier and transaction boundaries work without home-grown infrastructure or misleading CQRS terminology.
