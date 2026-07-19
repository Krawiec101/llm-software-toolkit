# New PHP API Workflow

## Kiedy uzywac

Use this workflow to create a new local backend REST API from scratch with PHP and either Symfony or Laravel, JSON, PHP-FPM, Nginx and optional PostgreSQL.

## Kiedy nie uzywac

Do not use it as the main workflow for an existing application, HTML or CLI applications, production or staging setup, authentication or authorization, GraphQL, JSON:API, queues, asynchronous communication, event buses, CQRS, distributed tracing, external integrations, pagination, filtering, sorting, Testcontainers, CI/CD, GitHub Actions or Kubernetes. Individual related skills may be invoked independently on existing projects under their approval contract.

## Wejscia

- Project name, base namespace, purpose, use cases, business areas and MVP boundary.
- Symfony or Laravel preference, persistence need and testing preferences.
- Expected growth over 6-12 months, future dependencies and team shape where architecturally relevant.
- Target directory and applicable project guidance.

## Wyjscia

- `docs/architecture-decision.md` and proposed or approved ADRs under `docs/adr/`.
- One recommended architecture, at most two alternatives and a directory tree for only the recommendation.
- An approved and locally implemented PHP API project, when the planning gate passes.
- Validation evidence and `docs/implementation-report.md`.

## Wymagany kontekst

Before planning or editing, read `project.yaml` when present, `AGENTS.md` or `agent.md`, `CLAUDE.md`, existing architecture reports and ADRs, technology manifests and the complete skill files used by the current stage. Record missing non-material context as assumptions; ask about material product decisions.

## Kroki

1. Discover the application with `php-application-discovery`. Continue when every required discovery field is explicit and no material product question remains.
2. Classify it with `php-architecture-recommendation`, in order by business areas, business-rule complexity, expected 6-12 month growth, future dependencies, then team shape only when relevant. Continue with one descriptive, non-scored recommendation among framework conventions, clean architecture with vertical slices, or modular monolith with clean architecture, vertical slices and module `PublicApi`.
3. Complete `tooling-research` for every time-dependent technology choice. Continue when stable, compatible, maintained and commercially usable recommendations have dated sources.
4. Close the planning decisions, then use `php-architecture-decisions` to create or update proposed ADRs and `docs/architecture-decision.md`. Group material decisions sensibly; do not create ADRs for trivial options.
5. Publish the complete architecture report and stop at the planning gate. Do not scaffold, install dependencies, create Docker files, change implementation files or invoke implementation skills before explicit approval of the current report and an instruction to implement.
6. After approval, change every related ADR from `proposed` to `approved` before implementation. Then invoke exactly one framework bootstrap, followed as applicable by local environment, API foundation, persistence, HTTP logging, OpenAPI, optional example slice, quality tooling, testing tooling, architecture tests and project README. Every independently invoked skill still applies its own approval contract.
7. Validate with `php-project-validation` against all approved ADRs. Do not silently fix failures or count skipped checks as passed.
8. Create `docs/implementation-report.md` with `implementation-report`. The workflow succeeds only when every approved ADR is reported as implemented.

## Bramki akceptacji

- Clear approval such as `approved`, `zaakceptowane` or `rozpocznij implementacje` passes only when it unambiguously refers to the current architecture report and directs implementation.
- Before approval, revise existing `proposed` ADRs rather than creating version copies.
- After approval, a material change to architecture, scope, security, contracts or tooling requires a new ADR, marks the old ADR `superseded`, updates the report and returns to the planning gate. The superseded ADR names its replacement.

## Wznowienie

On resume, read the architecture report and indexed ADRs, compare the project with approved decisions, and report completed, missing, manual, divergent and conflicting work without reverting manual changes. Record minor divergence; obtain a decision for material divergence. Repeat time-sensitive research for PHP, framework, Composer packages, quality, testing, OpenAPI, logging, official skills and practices. Do not repeat accepted business discovery or architecture classification without need. Stop and reopen the ADR gate if a selected tool is unsupported, vulnerable, incompatible or abandoned.

## Walidacja

Validate images, containers, PHP-FPM, Nginx, `/`, `/health`, `/docs`, optional PostgreSQL and migrations, formatting checks, static analysis, tests, coverage, CRAP, architecture and mutation tests, environment-file hygiene, README commands and implementation-to-ADR conformity according to accepted scope. Record every command and result.

## Checklista jakosci

- The architecture is the simplest justified level; simple CRUD does not gain ceremonial layers.
- Modular boundaries follow business capabilities, expose only synchronous `PublicApi` contracts and have no cycles; every cross-module dependency records direction, contract and business reason.
- The report contains one recommendation, no more than two alternatives, risks, assumptions, implementation plan, out-of-scope MVP section and an approval-waiting status.
- No implementation preceded approval; ADR lifecycle and resumption rules were followed.
- No out-of-scope feature, secret, customer-specific datum or production configuration was introduced.

## Powiazane skille

Entrypoint: `skills/new-php-api/SKILL.md`. Planning: `php-application-discovery`, `php-architecture-recommendation`, `tooling-research`, `php-architecture-decisions`. Implementation: `symfony-project-bootstrap`, `laravel-project-bootstrap`, `php-local-environment`, `php-api-foundation`, `php-persistence`, `php-http-logging`, `php-openapi`, `php-example-slice`, `php-quality-tooling`, `php-testing-tooling`, `php-architecture-tests`, `php-project-readme`. Completion: `php-project-validation`, `implementation-report`.

## Powiazani agenci Claude Code

No dedicated agent is required. Project-defined agents may execute approved stages without changing this workflow's gates or decisions.

## Powiazane szablony agentow Codex

No dedicated template is required. Invoke `llm-software-toolkit:new-php-api` from the installed plugin.

## Znane ograniczenia

The first version supports only the scope listed under `Kiedy uzywac`; it does not generate production-ready deployment. Tool choices must be researched at execution time and are intentionally not pinned here.
