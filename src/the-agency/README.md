
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
| use-agent-zero | If true, includes Canonical Agent Guide section in AGENTS.md and syncs AGENT-ZERO.md to ~/.the-agency/AGENT-ZERO.md. AGENT_ROUTING.md is synced to ~/.the-agency/AGENT_ROUTING.md. | boolean | false |

# Agency Agents Feature - Additional Notes

## Behavior Overview

### Agent Routing Rules (Always Added)
Regardless of the `use-agent-zero` setting, the feature always ensures that agent routing rules are present in your workspace `AGENTS.md` file. This helps LLM agents make informed decisions about which specialist agents to use.

- **When enabled**: Routing rules are added to the workspace and reference `~/.the-agency/AGENT_ROUTING.md`
- **When disabled**: Same routing rules are added, without the Canonical Agent Guide

### Canonical Agent Guide (Optional)
When `use-agent-zero=true`, the feature additionally includes a reference to the Canonical Agent Guide, which syncs the global `AGENT-ZERO.md` file to `~/.the-agency/`.

- **When enabled**: Includes Canonical Agent Guide section pointing to `~/.the-agency/AGENT-ZERO.md`
- **When disabled**: Canonical section is omitted, but routing rules still present

### Content Order (When Enabled)
When `use-agent-zero=true`, the AGENTS.md block follows this order:
1. Canonical Agent Guide (from AGENT-ZERO.md)
2. Agent Routing Rules (from AGENT_ROUTING.md)

This ordering ensures LLM agents first understand the baseline canonical behavior before applying specialized routing rules.

## Use Cases

- **use-agent-zero=false** (default): Minimal setup, just adds routing guidance to workspace
- **use-agent-zero=true**: Full setup with canonical agent baseline + routing rules


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/wcgomes/devcontainer-features/blob/main/src/the-agency/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
