
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
| create-agentsmd | If true, writes AGENTS.md from AGENT-ZERO to the workspace root during onCreateCommand (always overwrites). | boolean | false |

## Credits

The agents installed by this feature come from [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents).

When `create-agentsmd=true`, the `AGENTS.md` file is sourced from [msitarzewski/AGENT-ZERO](https://github.com/msitarzewski/AGENT-ZERO).



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/wcgomes/devcontainer-features/blob/main/src/agency-agents/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
