
# The Agency (the-agency)

Downloads agency-agents from msitarzewski repos and runs convert/install with auto-detection by default.

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
| use-agent-zero | If true, includes Canonical Agent Guide section in AGENTS.md and syncs AGENT-ZERO.md globally. Agent routing rules are always included in AGENTS.md (created if missing, or updated in-place). AGENT_ROUTING.md is always installed to ~/.agents/. | boolean | false |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/wcgomes/devcontainer-features/blob/main/src/the-agency/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
