#!/bin/sh

set -eu

log() {
  echo "[the-agency-feature] $*"
}

fail() {
  echo "[the-agency-feature] ERROR: $*" >&2
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

  # Minimal images may lack a CA bundle required for HTTPS downloads.
  if [ ! -f /etc/ssl/certs/ca-certificates.crt ]; then
    missing="${missing} ca-certificates"
  fi

  # Trim leading spaces for cleaner logs and checks.
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

# Dev Container Features export options as uppercase env vars (e.g. TOOL).
# Keep FEATURE_OPTION_TOOL as a compatibility fallback.
tool="${TOOL:-${FEATURE_OPTION_TOOL:-auto}}"
use_agent_zero="${USE_AGENT_ZERO:-${FEATURE_OPTION_USE_AGENT_ZERO:-false}}"

case "$tool" in
  "")
    fail "Option 'tool' cannot be empty."
    ;;
  *[!a-zA-Z0-9_-]*)
    fail "Option 'tool' contains invalid characters: '$tool'."
    ;;
esac

case "$use_agent_zero" in
  true|false)
    ;;
  *)
    fail "Option 'use-agent-zero' must be 'true' or 'false'. Got: '$use_agent_zero'."
    ;;
esac

ensure_prerequisites

marker_dir="/usr/local/share/devcontainer-features"

target_user="${_REMOTE_USER:-vscode}"
target_home="$(getent passwd "$target_user" | cut -d: -f6 || true)"
if [ -z "$target_home" ]; then
  target_home="/home/$target_user"
fi

# v3 marker includes use-agent-zero so config changes trigger a rerun.
marker_file="$marker_dir/the-agency-v3-${tool}-${use_agent_zero}-${target_user}.done"
on_create_helper_src="$(dirname "$0")/on-create.sh"
on_create_helper_dst="$marker_dir/the-agency-on-create.sh"
routing_template_src="$(dirname "$0")/AGENT_ROUTING.md"
global_agents_dir="${HOME}/.agents"
routing_global_dst="$global_agents_dir/AGENT_ROUTING.md"
use_agent_zero_marker="$marker_dir/the-agency-use-agent-zero.enabled"

if [ -f "$marker_file" ]; then
  log "Installation already completed for tool '$tool'. Skipping."
  exit 0
fi

mkdir -p "$marker_dir"
mkdir -p "$global_agents_dir"

[ -f "$on_create_helper_src" ] || fail "Missing script: on-create.sh"
[ -f "$routing_template_src" ] || fail "Missing file: AGENT_ROUTING.md"
cp "$on_create_helper_src" "$on_create_helper_dst"
cp "$routing_template_src" "$routing_global_dst"
chmod 0755 "$on_create_helper_dst"
chmod 0644 "$routing_global_dst"
log "AGENT_ROUTING.md installed to global: $routing_global_dst"

if [ "$use_agent_zero" = "true" ]; then
  touch "$use_agent_zero_marker"
else
  rm -f "$use_agent_zero_marker"
fi

tmp_dir="$(mktemp -d /tmp/the-agency-XXXXXX)"
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

zip_file="$tmp_dir/agency-agents.zip"

log "Downloading repository ZIP..."
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "https://github.com/msitarzewski/agency-agents/archive/refs/heads/main.zip" -o "$zip_file" \
    || curl -fsSL "https://github.com/msitarzewski/agency-agents/archive/refs/heads/master.zip" -o "$zip_file" \
    || fail "Unable to download repository ZIP (main/master)."
else
  wget -qO "$zip_file" "https://github.com/msitarzewski/agency-agents/archive/refs/heads/main.zip" \
    || wget -qO "$zip_file" "https://github.com/msitarzewski/agency-agents/archive/refs/heads/master.zip" \
    || fail "Unable to download repository ZIP (main/master)."
fi

log "Extracting repository ZIP..."
unzip -q "$zip_file" -d "$tmp_dir"

repo_dir="$(find "$tmp_dir" -mindepth 1 -maxdepth 1 -type d | head -n1 || true)"
[ -n "$repo_dir" ] || fail "Could not locate extracted repository directory."

[ -f "$repo_dir/scripts/convert.sh" ] || fail "Missing script: scripts/convert.sh"
[ -f "$repo_dir/scripts/install.sh" ] || fail "Missing script: scripts/install.sh"

chmod +x "$repo_dir/scripts/convert.sh" "$repo_dir/scripts/install.sh"

log "Running convert.sh..."
(
  cd "$repo_dir"
  ./scripts/convert.sh
)

if [ "$tool" = "auto" ]; then
  log "Running install.sh --no-interactive --parallel (auto tool detection)..."
else
  log "Running install.sh --tool $tool --no-interactive..."
fi

if [ "$(id -u)" -eq 0 ] && [ "$target_user" != "root" ] && id "$target_user" >/dev/null 2>&1; then
  log "Installing for user '$target_user' (HOME=$target_home)..."
  chown -R "$target_user":"$target_user" "$tmp_dir"
  chmod -R u+rwX,go+rX "$tmp_dir"
  if [ "$tool" = "auto" ]; then
    su - "$target_user" -c "cd '$repo_dir' && HOME='$target_home' ./scripts/install.sh --no-interactive --parallel"
  else
    su - "$target_user" -c "cd '$repo_dir' && HOME='$target_home' ./scripts/install.sh --tool '$tool' --no-interactive"
  fi
else
  log "Installing for current user '$(id -un)' (HOME=${HOME:-unknown})..."
  (
    cd "$repo_dir"
    if [ "$tool" = "auto" ]; then
      ./scripts/install.sh --no-interactive --parallel
    else
      ./scripts/install.sh --tool "$tool" --no-interactive
    fi
  )
fi

touch "$marker_file"
log "Installation completed for tool '$tool'."
