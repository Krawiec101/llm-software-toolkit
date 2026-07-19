---
name: php-example-slice
description: Add an optional removable ExampleItem vertical slice to a PHP API. Use for a small POST-and-GET teaching example, not production domain modeling or full CRUD.
---

# PHP Example Slice

Read and obey `references/php-api-skill-contract.md`; proceed only after the user opts in.

Create one `Example` directory with a neutral `ExampleItem`, separate DTOs, direct use cases, POST create and GET by identifier, plus a repository only when persistence is active. Keep domain logic intentionally small while marking its future location. Add no extra module split, full CRUD, fixtures or elaborate example test infrastructure. Update the approved README file list with exact removal instructions for the directory and related configuration.

Completion criterion: both routes work, the database remains initially empty, and following the documented removal steps leaves no Example-specific configuration.
