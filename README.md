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

## Repo and Feature Structure

Similar to the [`devcontainers/features`](https://github.com/devcontainers/features) repo, this repository has a `src` folder.  Each Feature has its own sub-folder, containing at least a `devcontainer-feature.json` and an entrypoint script `install.sh`.

```
├── src
│   ├── agency-agents
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
...
```

An [implementing tool](https://containers.dev/supporting#tools) will composite [the documented dev container properties](https://containers.dev/implementors/features/#devcontainer-feature-json-properties) from the feature's `devcontainer-feature.json` file, and execute in the `install.sh` entrypoint script in the container during build time.  Implementing tools are also free to process attributes under the `customizations` property as desired.

### Options

All available options for a Feature should be declared in the `devcontainer-feature.json`.  The syntax for the `options` property can be found in the [devcontainer Feature json properties reference](https://containers.dev/implementors/features/#devcontainer-feature-json-properties).

For example, the `agency-agents` feature exposes a `tool` string option.  If no option is provided in a user's `devcontainer.json`, the value defaults to `auto`.

```jsonc
{
    // ...
    "options": {
        "tool": {
            "type": "string",
            "default": "auto",
            "description": "Tool name passed to ./scripts/install.sh --tool <tool>. Use 'auto' for --parallel auto-detection."
        }
    }
}
```

Options are exported as Feature-scoped environment variables.  The option name is capitalised and sanitised according to [option resolution](https://containers.dev/implementors/features/#option-resolution).

```bash
#!/bin/sh

tool="${TOOL:-auto}"

...
```