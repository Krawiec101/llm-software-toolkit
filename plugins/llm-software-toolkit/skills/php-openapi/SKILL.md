---
name: php-openapi
description: Configure current stable OpenAPI documentation for Symfony or Laravel business endpoints. Use for DTO schemas, validation, statuses, errors and a UI at /docs.
---

# PHP OpenAPI

Read and obey `references/php-api-skill-contract.md`. Complete `tooling-research` for a stable framework-compatible solution.

Document business endpoints under `/api/v1`, request and response DTOs, validation, HTTP statuses and errors, with a documentation interface at `/docs`. Do not document `/`, `/health` or `/docs`, and do not require a separate public `openapi.json` endpoint.

Completion criterion: the generated or declared specification matches every approved business HTTP contract and the `/docs` UI works without documenting excluded utility routes.
