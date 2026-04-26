#!/bin/bash
set -euo pipefail

MARKER="${HOME}/.local/share/devcontainer-features/agents-workspace.done"

TARGET_USER="${USER:-$(whoami)}"
[ -z "$TARGET_USER" ] && TARGET_USER="$(getent passwd | awk -F: '$3 >= 1000 {print $1; exit 0}')"
[ -z "$TARGET_USER" ] && TARGET_USER="vscode"

export USERNAME="$TARGET_USER"
export _REMOTE_USER="$TARGET_USER"
export TOOL="${TOOL:-all}"
export INCLUDEAGENCY="${INCLUDEAGENCY:-true}"
export AUTOUPDATE="${AUTOUPDATE:-true}"

log() {
  echo "[agents-workspace-poststart] $*"
}

fail() {
  echo "[agents-workspace-poststart] ERROR: $*" >&2
  exit 1
}

get_remote_commit() {
  local repo="$1"
  curl -fsSL "https://api.github.com/repos/$repo/commits/main" 2>/dev/null | \
    grep -o '"sha": "[a-f0-9]*' | cut -d'"' -f4 | cut -c1-7
}

download_install_script() {
  local tmp_script="/tmp/agents-workspace-install.sh"
  log "Downloading install script..."
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "https://raw.githubusercontent.com/wcgomes/agents-workspace/main/tools/install.sh" -o "$tmp_script" \
      || fail "Failed to download install.sh"
  else
    wget -qO "$tmp_script" "https://raw.githubusercontent.com/wcgomes/agents-workspace/main/tools/install.sh" \
      || fail "Failed to download install.sh"
  fi
  chmod +x "$tmp_script"
  echo "$tmp_script"
}

do_install() {
  log "Starting installation for user '$TARGET_USER'..."

  local marker_dir="/usr/local/share/devcontainer-features"
  local tool="${TOOL:-all}"
  local includeAgency="${INCLUDEAGENCY:-true}"
  local commit_file="$marker_dir/agents-workspace-v1.commit"
  local agency_commit_file="$marker_dir/agency-agents-v1.commit"

  local TARGET_HOME
  TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
  [ -z "$TARGET_HOME" ] && TARGET_HOME="/home/$TARGET_USER"

  local tmp_dir
  tmp_dir="$(mktemp -d /tmp/agents-workspace-XXXXXX)"
  CLEANUP_DIR="$tmp_dir"
  cleanup() {
    rm -rf "$CLEANUP_DIR"
    rm -f /tmp/agents-workspace-install.sh
  }
  trap cleanup EXIT

  mkdir -p "$marker_dir" 2>/dev/null || true

  local install_script
  install_script="$(download_install_script)"
  log "Running install script from $install_script..."
  export HOME="$TARGET_HOME"
  bash "$install_script" --all || log "Install completed with warnings"

  local remote_final_commit
  remote_final_commit="$(get_remote_commit "wcgomes/agents-workspace")"
  [ -n "$remote_final_commit" ] && echo "$remote_final_commit" > "$commit_file" && log "Saved agents-workspace commit: $remote_final_commit"

  if [ "$includeAgency" = "true" ]; then
    local remote_agency_commit
    remote_agency_commit="$(get_remote_commit "msitarzewski/agency-agents")"
    [ -n "$remote_agency_commit" ] && echo "$remote_agency_commit" > "$agency_commit_file" && log "Saved agency-agents commit: $remote_agency_commit"
  fi

  log "Installation completed for tool '$tool'."
}

if [ -f "$MARKER" ]; then
  if [ "$AUTOUPDATE" = "true" ]; then
    log "Marker found, checking for updates..."
    local commit_file="/usr/local/share/devcontainer-features/agents-workspace-v1.commit"
    local agency_commit_file="/usr/local/share/devcontainer-features/agency-agents-v1.commit"
    local includeAgency="$INCLUDEAGENCY"

    if [ -f "$commit_file" ] && [ -s "$commit_file" ]; then
      local installed_agents_workspace_commit
      installed_agents_workspace_commit="$(cat "$commit_file")"
      if [ -n "$installed_agents_workspace_commit" ]; then
        local remote_agents_workspace_commit
        remote_agents_workspace_commit="$(get_remote_commit "wcgomes/agents-workspace")"

        local needs_update=false
        if [ -n "$remote_agents_workspace_commit" ] && [ "$remote_agents_workspace_commit" != "$installed_agents_workspace_commit" ]; then
          log "agents-workspace update available ($installed_agents_workspace_commit → $remote_agents_workspace_commit)"
          needs_update=true
        fi

        if [ "$includeAgency" = "true" ] && [ -f "$agency_commit_file" ]; then
          local installed_agency_agents_commit
          installed_agency_agents_commit="$(cat "$agency_commit_file")"
          if [ -n "$installed_agency_agents_commit" ]; then
            local remote_agency_agents_commit
            remote_agency_agents_commit="$(get_remote_commit "msitarzewski/agency-agents")"
            if [ -n "$remote_agency_agents_commit" ] && [ "$remote_agency_agents_commit" != "$installed_agency_agents_commit" ]; then
              log "agency-agents update available ($installed_agency_agents_commit → $remote_agency_agents_commit)"
              needs_update=true
            fi
          fi
        fi

        if [ "$needs_update" = "true" ]; then
          log "Updates available, updating..."
          rm -f "$MARKER"
          rm -f "$commit_file"
          [ "$includeAgency" = "true" ] && rm -f "$agency_commit_file"
          do_install
          touch "$MARKER"
          log "Update complete"
          exit 0
        fi
      fi
    fi
    log "Already on latest version"
  else
    log "Marker found, autoupdate disabled, skipping"
  fi
  exit 0
fi

log "First installation..."
do_install

touch "$MARKER"
log "Installation complete, marker created at $MARKER"