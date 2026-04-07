# Dev Container Features

This repository provides a collection of [dev container Features](https://containers.dev/implementors/features/) for use in dev containers and GitHub Codespaces. Each Feature is independently versioned and published to GitHub Container Registry (GHCR) following the [dev container Feature distribution specification](https://containers.dev/implementors/features-distribution/).

## Feature: `agency-agents`

Adds the [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) agent set to your dev container. During the container build it:

1. Downloads the upstream repository as a ZIP archive.
2. Runs `scripts/convert.sh` to prepare the agents.
3. Runs `scripts/install.sh --no-interactive --parallel` when `tool=auto` (default), or `scripts/install.sh --tool <tool> --no-interactive` for explicit tool mode.

The feature only installs the upstream agent files for the selected tool(s). It does not create or modify workspace `AGENTS.md` files.

Official website: [agencyagents.dev](https://agencyagents.dev)

### Usage

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/YOUR_GITHUB_USER/agency-agents/agency-agents:0": {}
    }
}
```

To install for a specific tool, pass the `tool` option:

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/YOUR_GITHUB_USER/agency-agents/agency-agents:0": {
            "tool": "cursor"
        }
    }
}
```

### Options

| Option | Type   | Default    | Description                                                         |
|--------|--------|------------|---------------------------------------------------------------------|
| `tool` | string | `auto`     | `auto` runs `install.sh --no-interactive --parallel`; otherwise uses `--tool <tool>` (e.g. `copilot`, `cursor`). |

### Credits

The agents installed by this feature come from the [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) repository. All credit for the agent definitions, `convert.sh`, and `install.sh` scripts belongs to the upstream project and its contributors.

Project website: [agencyagents.dev](https://agencyagents.dev)

This repository only wraps that upstream work as a dev container Feature for easier, reproducible installation inside dev containers.

## Feature: `opencode`

Installs the [opencode](https://opencode.ai) AI coding agent CLI and ensures volume-mounted data directories are owned by the correct user. During the container build it:

1. Downloads and runs the opencode installer via `curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path`.
2. Creates a symlink at `/usr/local/bin/opencode` so the CLI is available on `PATH`.
3. Installs a `/usr/local/bin/opencode-fix-permissions` script that fixes ownership of volume-mounted data directories.

The feature runs `opencode-fix-permissions` as a `postStartCommand` to ensure the `config`, `data`, and `state` directories under `~/.opencode` are owned by the dev container user.

Official documentation: [opencode.ai](https://opencode.ai)

### Usage

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/YOUR_GITHUB_USER/devcontainer-features/opencode:0": {}
    }
}
```

To specify the username for volume ownership fixes, pass the `username` option:

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/YOUR_GITHUB_USER/devcontainer-features/opencode:0": {
            "username": "vscode"
        }
    }
}
```

### Options

| Option     | Type   | Default | Description                                                    |
|------------|--------|---------|----------------------------------------------------------------|
| `username` | string | `""`    | Username to own the `~/.opencode` volume-mounted directories.  |
| `version`  | string | `""`    | Specific version to install (e.g. `1.3.17`). Empty = latest.  |

### Volume Mounts

Opencode stores its configuration, data, and state under `~/.opencode` in three subdirectories:

- `config` – configuration files
- `data` – project data and caches
- `state` – runtime state

When these directories are volume-mounted into the container, they may be owned by `root` depending on how the volumes are created. The `opencode-fix-permissions` script runs on container start to `chown` these directories to the specified user, ensuring opencode can read and write them without permission errors.

### Shared Volumes Between Projects

If you share the same `~/.opencode` volume mounts across multiple projects, be aware that opencode's state and data will be shared as well. This can be useful for preserving context between projects, but may also cause unexpected behaviour if projects have conflicting configurations. Consider using separate volume mounts per project if isolation is needed.