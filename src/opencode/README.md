
# opencode CLI (opencode)

Installs the opencode AI coding agent CLI and ensures volume-mounted data directories are owned by the correct user.

## Example Usage

```json
"features": {
    "ghcr.io/wcgomes/devcontainer-features/opencode:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| username | Username to install opencode for. Defaults to _REMOTE_USER (the container's remote user). | string | - |
| installVscodePlugin | Install the opencode VS Code extension. | boolean | true |
| version | Version to install (e.g. 1.3.17). Empty = latest. | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/wcgomes/devcontainer-features/blob/main/src/opencode/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
