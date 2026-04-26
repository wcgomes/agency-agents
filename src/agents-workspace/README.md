# Agents Workspace (agents-workspace)

AI agent workspace with specialist agents for orchestrated, minimal, and self-learning workflows.

## Example Usage

```json
"features": {
    "ghcr.io/wcgomes/devcontainer-features/agents-workspace:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| tool | Tool to install: opencode, claude, copilot, antigravity, all (default: all) | string | all |
| includeAgency | Install agency-agents (144+ specialized agents) | boolean | true |
| autoupdate | Check for updates on container start | boolean | true |

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/wcgomes/devcontainer-features/blob/main/src/agents-workspace/devcontainer-feature.json)._