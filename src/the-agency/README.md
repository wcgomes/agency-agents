
# The Agency (the-agency)

A complete AI agency at your fingertips - From frontend wizards to Reddit community ninjas, from whimsy injectors to reality checkers. Each agent is a specialized expert with personality, processes, and proven deliverables. Credits: https://github.com/msitarzewski/agency-agents.

## Example Usage

```json
"features": {
    "ghcr.io/wcgomes/devcontainer-features/the-agency:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| tool | Tool name passed to ./scripts/install.sh --tool <tool>. Use 'auto' for --parallel auto-detection. | string | auto |
| use-agent-zero | If true, includes Canonical Agent Guide section in AGENTS.md and syncs AGENT-ZERO.md to ~/.the-agency/AGENT-ZERO.md. | boolean | false |

# Agency Agents Feature - Additional Notes

## Behavior Overview

### Workspace Rules (Always Added)
Regardless of the `use-agent-zero` setting, the feature always ensures a managed workspace `AGENTS.md` block is present.

- **When enabled**: Includes Canonical Agent Guide section and a generic specialist-agent selection rule
- **When disabled**: Includes only the generic specialist-agent selection rule

### Canonical Agent Guide (Optional)
When `use-agent-zero=true`, the feature additionally includes a reference to the Canonical Agent Guide, which syncs the global `AGENT-ZERO.md` file to `~/.the-agency/`.

- **When enabled**: Includes Canonical Agent Guide section pointing to `~/.the-agency/AGENT-ZERO.md`
- **When disabled**: Canonical section is omitted

### Content Order (When Enabled)
When `use-agent-zero=true`, the AGENTS.md block follows this order:
1. Canonical Agent Guide (from AGENT-ZERO.md)
2. The Agency Agents rule

This ordering ensures LLM agents first understand the baseline canonical behavior before applying workspace-level specialist-agent guidance.

## Use Cases

- **use-agent-zero=false** (default): Minimal setup with specialist-agent guidance in workspace AGENTS.md
- **use-agent-zero=true**: Full setup with canonical baseline + workspace specialist-agent guidance


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/wcgomes/devcontainer-features/blob/main/src/the-agency/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
