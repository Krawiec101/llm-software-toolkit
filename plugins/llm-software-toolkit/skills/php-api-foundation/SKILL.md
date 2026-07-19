---
name: php-api-foundation
description: Establish framework-native REST and JSON foundations for a Symfony or Laravel API. Use for routes, DTO boundaries, validation and centralized safe HTTP errors without CQRS or buses.
---

# PHP API Foundation

Read and obey `references/php-api-skill-contract.md`; research any recommended package or non-core mechanism.

Configure JSON REST under `/api/v1`, empty `200 OK` at `/`, `{"status":"ok"}` at `/health`, and `/docs` outside the API prefix. Give each use case separate input and output DTOs, framework validation, direct endpoint-to-use-case calls, dedicated application exceptions with stable codes, framework-native central error mapping, safe responses and `X-Request-ID` even on errors. Domain objects never cross the HTTP boundary. Recommend `201` plus `Location` for create, `204` for update/delete, and `200`/`404` for reads while allowing approved overrides. Add no CQRS or command, query or message bus.

Completion criterion: every approved route and failure path obeys the DTO boundary, response contract and request-ID rule without introducing excluded messaging abstractions.
