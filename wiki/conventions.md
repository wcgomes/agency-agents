# Conventions

## Feature Structure

Each feature lives in `src/<feature>/` with:
- `devcontainer-feature.json` — metadata + options
- `install.sh` — entrypoint script

## Options

Options from `devcontainer-feature.json` are exported as environment variables (uppercase, sanitized). Example: option `tool` becomes `$TOOL` in install.sh.

## Test Structure

Tests live in `test/<feature>/`:
- `default.sh` / `default_auto.sh` — default behavior
- `scenarios.json` — scenario definitions
- `custom_*.sh` — specific option combinations