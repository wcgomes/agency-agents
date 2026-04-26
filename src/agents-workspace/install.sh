#!/bin/sh

set -eu

log() {
  echo "[agents-workspace-feature] $*"
}

fail() {
  echo "[agents-workspace-feature] ERROR: $*" >&2
  exit 1
}

install_packages() {
  if command -v apt-get >/dev/null 2>&1; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -y
    apt-get install -y --no-install-recommends "$@"
    rm -rf /var/lib/apt/lists/*
    return
  fi

  if command -v apk >/dev/null 2>&1; then
    apk add --no-cache "$@"
    return
  fi

  if command -v dnf >/dev/null 2>&1; then
    dnf install -y "$@"
    return
  fi

  if command -v microdnf >/dev/null 2>&1; then
    microdnf install -y "$@"
    return
  fi

  if command -v yum >/dev/null 2>&1; then
    yum install -y "$@"
    return
  fi

  if command -v zypper >/dev/null 2>&1; then
    zypper --non-interactive install --no-recommends "$@"
    return
  fi

  fail "Missing package manager support to install dependencies: $*"
}

ensure_prerequisites() {
  missing=""

  if ! command -v unzip >/dev/null 2>&1; then
    missing="${missing} unzip"
  fi

  if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
    missing="${missing} curl"
  fi

  if [ ! -f /etc/ssl/certs/ca-certificates.crt ]; then
    missing="${missing} ca-certificates"
  fi

  missing="$(echo "$missing" | sed 's/^ *//')"

  [ -n "$missing" ] || return 0

  if [ "$(id -u)" -ne 0 ]; then
    fail "Missing dependencies: $missing. Rebuild as root or preinstall them in the base image."
  fi

  log "Installing missing dependencies:$missing"
  install_packages $missing

  command -v unzip >/dev/null 2>&1 || fail "Dependency installation failed: unzip is still missing"
  command -v curl >/dev/null 2>&1 || command -v wget >/dev/null 2>&1 || fail "Dependency installation failed: curl/wget are still missing"
  [ -f /etc/ssl/certs/ca-certificates.crt ] || fail "Dependency installation failed: CA certificates are still missing"
}

get_remote_commit() {
  local repo="$1"
  curl -fsSL "https://api.github.com/repos/$repo/commits/main" 2>/dev/null | \
    grep -o '"sha": "[a-f0-9]*' | cut -d'"' -f4 | cut -c1-7
}

autoupdate_check() {
  if [ "$autoupdate" != "true" ]; then
    return 0
  fi

  if [ ! -f "$commit_file" ]; then
    log "Autoupdate: skipped (no commit file found)"
    return 0
  fi

  installed_agents_workspace_commit="$(cat "$commit_file")"
  if [ -z "$installed_agents_workspace_commit" ]; then
    log "Autoupdate: skipped (empty commit file)"
    return 0
  fi

  log "Autoupdate: checking for updates..."

  remote_agents_workspace_commit="$(get_remote_commit "wcgomes/agents-workspace")"
  if [ -z "$remote_agents_workspace_commit" ]; then
    log "Autoupdate: skipped (unable to fetch agents-workspace commit)"
    return 0
  fi

  needs_update=false

  if [ "$remote_agents_workspace_commit" != "$installed_agents_workspace_commit" ]; then
    log "Autoupdate: agents-workspace has updates ($installed_agents_workspace_commit → $remote_agents_workspace_commit)"
    needs_update=true
  fi

  if [ "$includeAgency" = "true" ]; then
    if [ -f "$agency_commit_file" ]; then
      installed_agency_agents_commit="$(cat "$agency_commit_file")"
      if [ -n "$installed_agency_agents_commit" ]; then
        remote_agency_agents_commit="$(get_remote_commit "msitarzewski/agency-agents")"
        if [ -n "$remote_agency_agents_commit" ] && [ "$remote_agency_agents_commit" != "$installed_agency_agents_commit" ]; then
          log "Autoupdate: agency-agents has updates ($installed_agency_agents_commit → $remote_agency_agents_commit)"
          needs_update=true
        fi
      fi
    fi
  fi

  if [ "$needs_update" = "false" ]; then
    log "Autoupdate: already on latest version (agents-workspace: $remote_agents_workspace_commit)"
    return 0
  fi

  log "Autoupdate: new versions available, updating..."

  rm -f "$marker_file"
  rm -f "$commit_file"
  [ "$includeAgency" = "true" ] && rm -f "$agency_commit_file"
  return 1
}

tool="${TOOL:-${FEATURE_OPTION_TOOL:-all}}"
includeAgency="${AGENTS_WORKSPACE_INCLUDE_AGENCY:-${INCLUDEAGENCY:-${FEATURE_OPTION_INCLUDE_AGENCY:-true}}}"
autoupdate="${AGENTS_WORKSPACE_AUTOUPDATE:-${AUTOUPDATE:-true}}"

case "$tool" in
  "")
    fail "Option 'tool' cannot be empty."
    ;;
  *[!a-zA-Z0-9_-]*)
    fail "Option 'tool' contains invalid characters: '$tool'."
    ;;
esac

case "$includeAgency" in
  true|false) ;;
  *)
    fail "Option 'includeAgency' must be 'true' or 'false'."
    ;;
esac

ensure_prerequisites

marker_dir="/usr/local/share/devcontainer-features"

marker_file="$marker_dir/agents-workspace-v1.done"
commit_file="$marker_dir/agents-workspace-v1.commit"
agency_commit_file="$marker_dir/agency-agents-v1.commit"
tool_marker="$marker_dir/agents-workspace-v1-${tool}.done"

if [ -f "$marker_file" ] || [ -f "$tool_marker" ]; then
  log "Installation already completed for tool '$tool'."
  if ! autoupdate_check; then
    rm -f "$marker_file"
    rm -f "$tool_marker"
    rm -f "$commit_file"
    [ "$includeAgency" = "true" ] && rm -f "$agency_commit_file"
  else
    exit 0
  fi
fi

if [ -f "$commit_file" ]; then
  autoupdate_check || true
fi

log "Installing agents-workspace..."

tmp_dir="$(mktemp -d /tmp/agents-workspace-XXXXXX)"
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

mkdir -p "$marker_dir"

install_script="$tmp_dir/install.sh"
log "Downloading install.sh..."
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "https://raw.githubusercontent.com/wcgomes/agents-workspace/main/tools/install.sh" -o "$install_script" \
    || fail "Unable to download install.sh"
else
  wget -qO "$install_script" "https://raw.githubusercontent.com/wcgomes/agents-workspace/main/tools/install.sh" \
    || fail "Unable to download install.sh"
fi

chmod +x "$install_script"

install_args=""
case "$tool" in
  all)
    install_args="--all"
    ;;
  opencode|claude|copilot|antigravity)
    install_args="--$tool"
    ;;
esac

if [ "$includeAgency" != "true" ]; then
  install_args="$install_args --no-agency"
fi

log "Running install.sh $install_args..."
if sh "$install_script" $install_args; then
  log "Install completed successfully."
else
  log "Install completed with warnings (some tools may not be available)."
fi

touch "$marker_file"
touch "$tool_marker"

remote_final_commit="$(get_remote_commit "wcgomes/agents-workspace")"
if [ -n "$remote_final_commit" ]; then
  echo "$remote_final_commit" > "$commit_file"
  log "Saved agents-workspace commit: $remote_final_commit"
fi

if [ "$includeAgency" = "true" ]; then
  remote_agency_commit="$(get_remote_commit "msitarzewski/agency-agents")"
  if [ -n "$remote_agency_commit" ]; then
    echo "$remote_agency_commit" > "$agency_commit_file"
    log "Saved agency-agents commit: $remote_agency_commit"
  fi
fi

cp "$0" "$marker_dir/agents-workspace-install.sh"
chmod +x "$marker_dir/agents-workspace-install.sh"

log "Installation completed for tool '$tool'."