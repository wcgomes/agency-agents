
# Agency Agents (agency-agents)

Downloads agency-agents from msitarzewski repos and runs convert/install with auto-detection by default.

## Example Usage

```json
"features": {
    "ghcr.io/wcgomes/devcontainer-features/agency-agents:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| tool | Tool name passed to ./scripts/install.sh --tool <tool>. Use 'auto' for --parallel auto-detection. | string | auto |
| create-agentsmd | If true, writes AGENTS.md from msitarzewski/AGENT-ZERO to the workspace root on container creation (always overwrites). | boolean | false |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/wcgomes/devcontainer-features/blob/main/src/agency-agents/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
