#!/bin/bash
set -euo pipefail

INSTALL_SCRIPT="${AGENTS_WORKSPACE_POSTSTART_SCRIPT:-/usr/local/share/devcontainer-features/agents-workspace-install.sh}"
MARKER="${HOME}/.local/share/devcontainer-features/agents-workspace.done"

TARGET_USER="${USER:-$(whoami)}"
[ -z "$TARGET_USER" ] && TARGET_USER="$(getent passwd | awk -F: '$3 >= 1000 {print $1; exit 0}')"
[ -z "$TARGET_USER" ] && TARGET_USER="vscode"

export USERNAME="$TARGET_USER"
export _REMOTE_USER="$TARGET_USER"
export TOOL="${TOOL:-all}"
export INCLUDEAGENCY="${INCLUDEAGENCY:-true}"
export AUTOUPDATE="${AUTOUPDATE:-true}"

echo "[agents-workspace-poststart] Checking installation script..."

if [ ! -f "$INSTALL_SCRIPT" ]; then
    echo "[agents-workspace-poststart] Installation script not found at $INSTALL_SCRIPT"
    exit 0
fi

if [ -f "$MARKER" ]; then
    echo "[agents-workspace-poststart] Marker found, skipping installation"
    exit 0
fi

if [ "$(id -u)" -eq 0 ] && [ "$TARGET_USER" != "root" ]; then
    echo "[agents-workspace-poststart] Running installation script as user $TARGET_USER"
    su - "$TARGET_USER" -c "bash $INSTALL_SCRIPT"
else
    echo "[agents-workspace-poststart] Running installation script"
    bash "$INSTALL_SCRIPT"
fi

mkdir -p "$(dirname "$MARKER")"
touch "$MARKER"
echo "[agents-workspace-poststart] Installation complete, marker created at $MARKER"