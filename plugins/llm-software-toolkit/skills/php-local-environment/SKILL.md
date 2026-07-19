---
name: php-local-environment
description: Configure an idempotent local Docker development environment for a PHP API. Use for PHP-FPM, Nginx, Composer, Xdebug and optional PostgreSQL, never production deployment.
---

# PHP Local Environment

Read and obey `references/php-api-skill-contract.md`. Research current stable base images and official practices before recommending them.

Configure Docker Compose with host port 80 to non-root Nginx port 8080, non-root PHP-FPM, Xdebug, Composer in PHP, bind-mounted code, a separate `vendor` volume, optional persistent PostgreSQL, configurable `LOCAL_UID` and `LOCAL_GID`, `.env.example`, manual local `.env` creation, local Compose env loading, `.env` ignored and untracked, and `.dockerignore`. Install Composer dependencies only when the vendor volume is empty; never rerun automatically merely because `composer.lock` changed. Use direct `docker compose` commands, no Makefile or wrappers, and create no production configuration.

Completion criterion: the approved local stack starts with least-privilege containers, correct volumes and environment hygiene, and the documented manual dependency behavior matches runtime behavior.
