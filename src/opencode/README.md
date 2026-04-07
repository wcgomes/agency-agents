# opencode Feature

Instala a CLI do [opencode](https://opencode.ai) e garante que os diretórios de dados montados como volume sejam ownership do usuário correto.

## O que a feature faz

1. Executa o installer oficial (`curl https://opencode.ai/install | bash -s -- --no-modify-path`) como o usuário correto
2. Cria symlink `/usr/local/bin/opencode` para expor o binário no PATH
3. Instala script `opencode-fix-permissions` em `/usr/local/bin/` — executado automaticamente via `postStartCommand` para corrigir ownership dos volumes

## Detecção automática de usuário

A feature detecta o usuário automaticamente usando as variáveis de ambiente disponíveis durante o install:

- `_REMOTE_USER` — o usuário configurado no `devcontainer.json` (via `remoteUser`) ou fallback para `_CONTAINER_USER`
- `_REMOTE_USER_HOME` — o home directory desse usuário

Se nenhuma estiver disponível (fallback), usa `vscode` como padrão.

Para imagens base de devcontainer comuns:

| Imagem | Usuário padrão |
|---|---|
| `mcr.microsoft.com/devcontainers/base:*` | `vscode` |
| `mcr.microsoft.com/devcontainers/universal:*` | `codespace` |
| GitHub Codespaces | `codespace` |

## Configuração necessária no `devcontainer.json`

A feature pode ser adicionada sem configuração adicional. Para customizar o usuário, use a opção `username`:

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

### Opções disponíveis

| Opção | Tipo | Default | Descrição |
|---|---|---|---|
| `username` | string | `_REMOTE_USER` ou `vscode` | Usuário para instalar e executar o opencode |
| `version` | string | (vazio = latest) | Versão específica a instalar (ex: `1.3.17`) |

### O que a feature gerencia automaticamente

- **`postStartCommand`** — a feature já declara `postStartCommand: "bash /usr/local/bin/opencode-fix-permissions"` internamente, então **não é necessário** adicioná-lo no `devcontainer.json` do consumidor
- **Symlink** — `/usr/local/bin/opencode` é criado automaticamente
- **Permissões** — o script de chown é gerado e invocado automaticamente após cada start

### Explicação dos mounts

| Mount | Propósito |
|---|---|
| `opencode-config` | Persistência de configurações e chaves de API |
| `opencode-data` | Dados da aplicação (cache, modelos, etc.) |
| `opencode-state` | Estado da sessão (histórico, conversas ativas) |

### Volumes compartilhados entre projetos

Os três volumes nomeados (`opencode-config`, `opencode-data`, `opencode-state`) são globais ao daemon Docker. Isso significa que:

- **Mesmo projeto, rebuilds**: dados persistem entre rebuilds do container
- **Projetos diferentes**: se outro devcontainer usar os mesmos nomes de volume, acessará os mesmos dados — replicando o comportamento de ter o opencode instalado localmente na máquina

### O que não é coberto pela feature

Os `mounts` (volumes) não podem ser declarados pela feature — precisam constar no `devcontainer.json` do consumidor. Isso é uma limitação da spec de devcontainer features.
