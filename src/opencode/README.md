
# opencode CLI (opencode)

Installs the opencode AI coding agent CLI and ensures volume-mounted data directories are owned by the correct user.

## Example Usage

```json
{
  "image": "mcr.microsoft.com/devcontainers/base:trixie",
  "features": {
    "ghcr.io/wcgomes/devcontainer-features/opencode:0": {}
  },
  "mounts": [
    {
      "source": "opencode-config",
      "target": "/home/vscode/.config/opencode",
      "type": "volume"
    },
    {
      "source": "opencode-data",
      "target": "/home/vscode/.local/share/opencode",
      "type": "volume"
    },
    {
      "source": "opencode-state",
      "target": "/home/vscode/.local/state/opencode",
      "type": "volume"
    }
  ]
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| username | Username to install opencode for. Defaults to _REMOTE_USER (the container's remote user). | string | - |
| version | Version to install (e.g. 1.3.17). Empty = latest. | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/wcgomes/devcontainer-features/blob/main/src/opencode/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
