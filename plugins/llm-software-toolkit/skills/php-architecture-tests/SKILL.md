---
name: php-architecture-tests
description: Configure blocking PHP architecture tests from an approved architecture. Use for layer direction and modular PublicApi boundary enforcement.
---

# PHP Architecture Tests

Read and obey `references/php-api-skill-contract.md`. Complete `tooling-research` for a stable architecture-test tool and derive configuration from the approved architecture, never from the report's documentation-only JSON.

For a simple or clean project, enforce approved dependency direction. For a modular monolith, also enforce cross-module access only through `PublicApi`, no access to another module's internals, no cycles, and allowance for thin `PublicApi` facades. Keep these tests blocking.

Completion criterion: representative forbidden dependencies fail, allowed dependencies pass, and the rules cover every approved layer or module.
