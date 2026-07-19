---
name: php-testing-tooling
description: Configure a researched PHP testing stack and accepted unit, API, mutation or architecture-test scope. Use for test framework setup and the root smoke test.
---

# PHP Testing Tooling

Read and obey `references/php-api-skill-contract.md`. Ask for unit, API/functional, mutation and architecture testing preferences, then complete `tooling-research` for the selected framework and mutation tool.

Add a smoke test asserting `/` returns an empty `200 OK`. If mutation testing is selected, propose a blocking minimum threshold, allow override and record the accepted threshold in an ADR. Do not add Testcontainers, a separate PostgreSQL test database, full integration infrastructure or ExampleItem tests in MVP.

Completion criterion: selected test commands run, the root smoke test passes, and any accepted mutation threshold blocks below its ADR value.
