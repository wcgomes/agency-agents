# Features

## opencode

Installs opencode CLI and fixes volume-mounted directory permissions.

Options:
- `username` (default: _REMOTE_USER) — user to install for
- `version` (default: empty/latest) — install specific version
- `autoupdate` (default: false) — auto-upgrade on container start

Idempotency: marker uses version if specified, else "latest"

## agency-agents

Installs msitarzewski/agency-agents for Cursor/Copilot integration.

Options:
- `tool` (default: auto) — tool to install agents for
- `autoupdate` (default: true) — check for updates on container start via GitHub API

## agency-agents

Installs msitarzewski/agency-agents for Cursor/Copilot integration.
Option `tool` (default: auto) — tool to install agents for.
Option `autoupdate` (default: true) — check for updates on container start via GitHub API.