# Security Policy

## Supported Versions

Security updates are provided for the following versions:

| Version | Supported |
| ------- | --------- |
| `develop` branch | :white_check_mark: |
| `main` branch (latest release) | :white_check_mark: |
| Older commits | :x: |

## Reporting a Vulnerability

Please report security vulnerabilities **privately** by emailing **security@acits.ru**.

**Do not open public GitHub issues, pull requests, or discussions for security vulnerabilities.** Public disclosure before a fix is available puts all users at risk.

When reporting, please include:

- A description of the vulnerability and its potential impact
- Steps to reproduce or a proof of concept
- Affected version, branch, or commit
- Any suggested remediation, if known

**Expected response time:** we aim to acknowledge your report within **72 hours** and will keep you informed of progress toward a fix. Please allow reasonable time for the issue to be resolved before any public disclosure.

## Secrets & Credentials

This repository **intentionally excludes** all secrets and environment-specific credentials. They are `.gitignore`d and must be supplied locally by each contributor. Where a secret is required, a committed `*.example` template shows the expected format — copy it and fill in your own values.

Excluded from the repository:

- **Firebase configs** — `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
- **Release signing** — signing keystore and `key.properties`
- **Debug keystore** — `android/keystore/test.keystore`
- **Debug SSL certificates** — Charles debug `.pem` certs

If you ever find a secret, key, or credential that has been **committed to the repository** (in the current tree or in history), please **report it privately** to **security@acits.ru** rather than opening a public issue. Do not commit real secrets under any circumstances; use the provided `*.example` templates instead.
