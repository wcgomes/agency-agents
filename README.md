# Dev Container Features

This repository provides a collection of [dev container Features](https://containers.dev/implementors/features/) for use in dev containers and GitHub Codespaces. Each Feature is independently versioned and published to GitHub Container Registry (GHCR) following the [dev container Feature distribution specification](https://containers.dev/implementors/features-distribution/).

## Feature: `agency-agents`

Adds the [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) agent set to your dev container. During the container build it:

1. Downloads the upstream repository as a ZIP archive.
2. Runs `scripts/convert.sh` to prepare the agents.
3. Runs `scripts/install.sh --no-interactive --parallel` when `tool=auto` (default), or `scripts/install.sh --tool <tool> --no-interactive` for explicit tool mode.

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

The agents installed by this feature come from the [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) repository. All credit for the agent definitions, `convert.sh`, and `install.sh` scripts belongs to the upstream project and its contributors. This repository only wraps that work as a dev container Feature for easier, reproducible installation inside dev containers.

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

## Distributing Features

### Versioning

Features are individually versioned by the `version` attribute in a Feature's `devcontainer-feature.json`.  Features are versioned according to the semver specification. More details can be found in [the dev container Feature specification](https://containers.dev/implementors/features/#versioning).

### Publishing

> NOTE: The Distribution spec can be [found here](https://containers.dev/implementors/features-distribution/).  
>
> While any registry [implementing the OCI Distribution spec](https://github.com/opencontainers/distribution-spec) can be used, this template will leverage GHCR (GitHub Container Registry) as the backing registry.

Features are meant to be easily sharable units of dev container configuration and installation code.  

This repo contains a **GitHub Action** [workflow](.github/workflows/release.yaml) that will publish each Feature to GHCR. 

*Allow GitHub Actions to create and approve pull requests* should be enabled in the repository's `Settings > Actions > General > Workflow permissions` for auto generation of `src/<feature>/README.md` per Feature (which merges any existing `src/<feature>/NOTES.md`).

By default, each Feature will be prefixed with the `<owner>/<repo>` namespace.  For example, the Feature in this repository can be referenced in a `devcontainer.json` with:

```
ghcr.io/<owner>/agency-agents/agency-agents:1
```

The provided GitHub Action will also publish a "metadata" package with just the namespace, eg: `ghcr.io/<owner>/agency-agents`.  This contains information useful for tools aiding in Feature discovery.

`<owner>/agency-agents` is known as the feature collection namespace.

### Marking Feature Public

Note that by default, GHCR packages are marked as `private`.  To stay within the free tier, Features need to be marked as `public`.

This can be done by navigating to the Feature's "package settings" page in GHCR, and setting the visibility to 'public`.  The URL may look something like:

```
https://github.com/users/<owner>/packages/container/<repo>%2F<featureName>/settings
```

<img width="669" alt="image" src="https://user-images.githubusercontent.com/23246594/185244705-232cf86a-bd05-43cb-9c25-07b45b3f4b04.png">

### Adding Features to the Index

If you'd like your Features to appear in our [public index](https://containers.dev/features) so that other community members can find them, you can do the following:

* Go to [github.com/devcontainers/devcontainers.github.io](https://github.com/devcontainers/devcontainers.github.io)
     * This is the GitHub repo backing the [containers.dev](https://containers.dev/) spec site
* Open a PR to modify the [collection-index.yml](https://github.com/devcontainers/devcontainers.github.io/blob/gh-pages/_data/collection-index.yml) file

This index is from where [supporting tools](https://containers.dev/supporting) like [VS Code Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) and [GitHub Codespaces](https://github.com/features/codespaces) surface Features for their dev container creation UI.

#### Using private Features in Codespaces

For any Features hosted in GHCR that are kept private, the `GITHUB_TOKEN` access token in your environment will need to have `package:read` and `contents:read` for the associated repository.

Many implementing tools use a broadly scoped access token and will work automatically.  GitHub Codespaces uses repo-scoped tokens, and therefore you'll need to add the permissions in `devcontainer.json`

An example `devcontainer.json` can be found below.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
     "ghcr.io/my-org/private-features/hello:1": {
            "greeting": "Hello"
        }
    },
    "customizations": {
        "codespaces": {
            "repositories": {
                "my-org/private-features": {
                    "permissions": {
                        "packages": "read",
                        "contents": "read"
                    }
                }
            }
        }
    }
}
```


