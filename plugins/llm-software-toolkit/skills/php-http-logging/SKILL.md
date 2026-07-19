---
name: php-http-logging
description: Configure privacy-aware structured HTTP logging for a local PHP API. Use for PSR-3 JSON stdout logs, request correlation, bounded bodies and safe errors.
---

# PHP HTTP Logging

Read and obey `references/php-api-skill-contract.md`. Complete `tooling-research` for the mature PSR-3 library; allow the user to reject logging.

For every HTTP request, log JSON to stdout with method, path, status, duration, generated UUID request ID and the same ID in related logs and every `X-Request-ID` response. For `application/json`, record raw request and response text up to 64 KB each with truncation flags. Mask at least password, token, authorization, cookie, secrets and environment credentials; omit authentication headers, multipart and binary bodies. Keep full development stack traces in logs but HTTP errors safe. Limit MVP scope to request traffic and request-handling failures, not elaborate startup logging.

Completion criterion: success and error paths correlate safely, body limits and masking are verified, and no excluded content reaches logs.
