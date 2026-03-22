#!/bin/sh

set -eu

log() {
  echo "[agency-agents-feature:on-create] $*"
}

marker_dir="/usr/local/share/devcontainer-features"
enabled_marker="$marker_dir/agency-agents-create-agentsmd.enabled"
output_file="$PWD/AGENTS.md"
source_url="https://raw.githubusercontent.com/msitarzewski/AGENT-ZERO/main/AGENTS.md"

if [ ! -f "$enabled_marker" ]; then
  log "create-agentsmd is disabled. Skipping AGENTS.md sync."
  exit 0
fi

log "Syncing AGENTS.md from AGENT-ZERO to workspace root: $output_file"

if command -v curl >/dev/null 2>&1; then
  if ! curl -fsSL "$source_url" -o "$output_file"; then
    log "WARNING: Could not download AGENTS.md with curl. Skipping without failing."
    exit 0
  fi
elif command -v wget >/dev/null 2>&1; then
  if ! wget -qO "$output_file" "$source_url"; then
    log "WARNING: Could not download AGENTS.md with wget. Skipping without failing."
    exit 0
  fi
else
  log "WARNING: Neither curl nor wget is available. Skipping AGENTS.md sync."
  exit 0
fi

log "AGENTS.md written successfully (overwrite enabled)."
