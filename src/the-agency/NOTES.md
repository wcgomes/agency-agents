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
