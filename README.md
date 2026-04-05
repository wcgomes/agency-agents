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
        "ghcr.io/YOUR_GITHUB_USER/agency-agents/agency-agents:1": {}
    }
}
```

To install for a specific tool, pass the `tool` option:

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/YOUR_GITHUB_USER/agency-agents/agency-agents:1": {
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
