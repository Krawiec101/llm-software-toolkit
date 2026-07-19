---
name: php-project-readme
description: Create or minimally update operational README guidance for a local PHP API. Use to document real Docker, environment, endpoint, migration, quality and test commands.
---

# PHP Project README

Read and obey `references/php-api-skill-contract.md`. Preserve manual documentation unless its removal is explicitly approved.

Document local requirements, manual `.env` preparation, direct `docker compose` start/stop and recommended command sequence, dependency installation and manual rerun, optional migrations, `/`, `/health`, `/docs`, tests, coding standard, static analysis, coverage, CRAP, mutation and architecture tests, aggregate validation, and full environment reset. Warn that removing the PostgreSQL volume loses data. When Example exists, give exact removal steps. Include only commands verified against current configuration.

Completion criterion: every documented command matches an executable project command, optional sections match selected features, and destructive reset consequences are explicit.
