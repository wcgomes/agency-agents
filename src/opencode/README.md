# opencode Feature

Installs the [opencode](https://opencode.ai) CLI and ensures volume-mounted data directories are owned by the correct user.

## What the feature does

1. Runs the official installer (`curl https://opencode.ai/install | bash -s -- --no-modify-path`) as the correct user
2. Creates symlink `/usr/local/bin/opencode` to expose the binary on PATH
3. Installs `opencode-fix-permissions` script in `/usr/local/bin/` — automatically executed via `postStartCommand` to fix volume ownership

## Automatic user detection

The feature detects the user automatically using environment variables available during install:

- `_REMOTE_USER` — the user configured in `devcontainer.json` (via `remoteUser`) or fallback to `_CONTAINER_USER`
- `_REMOTE_USER_HOME` — the home directory of that user

If none are available (fallback), uses `vscode` as default.

For common devcontainer base images:

| Image | Default user |
|---|---|
| `mcr.microsoft.com/devcontainers/base:*` | `vscode` |
| `mcr.microsoft.com/devcontainers/universal:*` | `codespace` |
| GitHub Codespaces | `codespace` |

## Required configuration in `devcontainer.json`

The feature can be added without additional configuration. To customize the user, use the `username` option:

```json
{
  "image": "mcr.microsoft.com/devcontainers/base:trixie",
  "features": {
    "./features/opencode": {}
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

### Available options

| Option | Type | Default | Description |
|---|---|---|---|
| `username` | string | `_REMOTE_USER` or `vscode` | User to install and run opencode for |
| `version` | string | (empty = latest) | Specific version to install (e.g. `1.3.17`) |

### What the feature manages automatically

- **`postStartCommand`** — the feature already declares `postStartCommand: "bash /usr/local/bin/opencode-fix-permissions"` internally, so **no need** to add it to the consumer's `devcontainer.json`
- **Symlink** — `/usr/local/bin/opencode` is created automatically
- **Permissions** — the chown script is generated and invoked automatically after each start

### Mount explanation

| Mount | Purpose |
|---|---|
| `opencode-config` | Configuration files and API keys persistence |
| `opencode-data` | Application data (cache, models, etc.) |
| `opencode-state` | Session state (history, active conversations) |

### Shared volumes between projects

The three named volumes (`opencode-config`, `opencode-data`, `opencode-state`) are global to the Docker daemon. This means:

- **Same project, rebuilds**: data persists between container rebuilds
- **Different projects**: if another devcontainer uses the same volume names, it will access the same data — replicating the behavior of having opencode installed locally on the machine

### What happens without volume mounts?

The feature works perfectly **without** volume mounts. If you don't configure the `mounts`:

- ✅ The CLI (`opencode`) works normally
- ✅ The binary is installed and symlinked to PATH
- ✅ The `fix-permissions` script runs without errors (it just skips non-existent paths)

**Limitation:** Data is stored in the container's ephemeral filesystem. On container rebuild or recreation, configuration, cache, and session state will be **reset** to defaults.

For a persistent experience, we **strongly recommend** adding the volume mounts shown above.

### What is not covered by the feature

The `mounts` (volumes) cannot be declared by the feature — they must be specified in the consumer's `devcontainer.json`. This is a limitation of the devcontainer features spec.
