---
name: php-project-validation
description: Validate a PHP API implementation against approved ADRs without silently fixing failures. Use for final local environment, HTTP, quality, test and documentation verification.
---

# PHP Project Validation

Read `references/php-api-skill-contract.md`; validation is read-only except for explicitly approved generated reports.

Check applicable image builds, container start, PHP-FPM, Nginx, `/`, `/health`, `/docs`, optional PostgreSQL and migrations, coding standard, static analysis, tests, coverage, CRAP, architecture tests, mutation tests, `.env`, `.gitignore`, `.dockerignore`, README command accuracy and implementation-to-ADR conformity. Do not repair failures silently and never count a skipped control as success.

Completion criterion: every applicable approved-ADR obligation maps to a passed, failed or explicitly skipped check with command evidence; success requires all applicable checks to pass.
