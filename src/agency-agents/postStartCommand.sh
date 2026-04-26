#!/bin/bash
set -euo pipefail

INSTALL_SCRIPT="${AGENCY_AGENTS_POSTSTART_SCRIPT:-/usr/local/share/devcontainer-features/agency-agents-install.sh}"
MARKER="${HOME}/.local/share/devcontainer-features/agency-agents.done"

TARGET_USER="${USER:-$(whoami)}"
[ -z "$TARGET_USER" ] && TARGET_USER="$(getent passwd | awk -F: '$3 >= 1000 {print $1; exit 0}')"
[ -z "$TARGET_USER" ] && TARGET_USER="vscode"

export USERNAME="$TARGET_USER"
export _REMOTE_USER="$TARGET_USER"
export TOOL="${TOOL:-auto}"
export AUTOUPDATE="${AUTOUPDATE:-true}"

echo "[agency-agents-poststart] Checking installation script..."

if [ ! -f "$INSTALL_SCRIPT" ]; then
    echo "[agency-agents-poststart] Installation script not found at $INSTALL_SCRIPT"
    exit 0
fi

if [ -f "$MARKER" ]; then
    echo "[agency-agents-poststart] Marker found, skipping installation"
    exit 0
fi

if [ "$(id -u)" -eq 0 ] && [ "$TARGET_USER" != "root" ]; then
    echo "[agency-agents-poststart] Running installation script as user $TARGET_USER"
    su - "$TARGET_USER" -c "bash $INSTALL_SCRIPT"
else
    echo "[agency-agents-poststart] Running installation script"
    bash "$INSTALL_SCRIPT"
fi

mkdir -p "$(dirname "$MARKER")"
touch "$MARKER"
echo "[agency-agents-poststart] Installation complete, marker created at $MARKER"