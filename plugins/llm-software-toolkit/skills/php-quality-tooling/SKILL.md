---
name: php-quality-tooling
description: Configure researched PHP formatting, static analysis, coverage and CRAP quality gates. Use for separate fix/check commands and a non-mutating aggregate Composer quality script.
---

# PHP Quality Tooling

Read and obey `references/php-api-skill-contract.md`. Complete `tooling-research` for each proposed tool and let the user explicitly decline parts of the set.

Configure coding standard with separate fix and check modes, static analysis at its maximum available level without a baseline, coverage with a user-approved threshold and justified exclusions, and a blocking maximum CRAP of `5`. Exclude migrations, configuration, bootstrap, generated and framework code where appropriate, never real application logic merely to raise metrics. Provide individual commands and a Composer aggregate such as `composer quality`; the aggregate is check-only and never modifies files.

Completion criterion: every accepted quality command is reproducible, the aggregate is non-mutating, and coverage and CRAP gates fail when their approved thresholds are violated.
