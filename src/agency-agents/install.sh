#!/bin/sh

set -eu

log() {
  echo "[agency-agents-feature] $*"
}

fail() {
  echo "[agency-agents-feature] ERROR: $*" >&2
  exit 1
}

tool="${FEATURE_OPTION_TOOL:-copilot}"

case "$tool" in
  "")
    fail "Option 'tool' cannot be empty."
    ;;
  *[!a-zA-Z0-9_-]*)
    fail "Option 'tool' contains invalid characters: '$tool'."
    ;;
esac

if ! command -v unzip >/dev/null 2>&1; then
  fail "Missing dependency: unzip"
fi

if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
  fail "Missing dependency: curl or wget"
fi

marker_dir="/usr/local/share/devcontainer-features"

target_user="${_REMOTE_USER:-vscode}"
target_home="$(getent passwd "$target_user" | cut -d: -f6 || true)"
if [ -z "$target_home" ]; then
  target_home="/home/$target_user"
fi

# v2 marker forces one rerun for users that already installed with old root-only behavior.
marker_file="$marker_dir/agency-agents-v2-${tool}-${target_user}.done"

if [ -f "$marker_file" ]; then
  log "Installation already completed for tool '$tool'. Skipping."
  exit 0
fi

mkdir -p "$marker_dir"

tmp_dir="$(mktemp -d /tmp/agency-agents-XXXXXX)"
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

log "Running install.sh --tool $tool..."
if [ "$(id -u)" -eq 0 ] && [ "$target_user" != "root" ] && id "$target_user" >/dev/null 2>&1; then
  log "Installing for user '$target_user' (HOME=$target_home)..."
  chown -R "$target_user":"$target_user" "$tmp_dir"
  chmod -R u+rwX,go+rX "$tmp_dir"
  su - "$target_user" -c "cd '$repo_dir' && HOME='$target_home' ./scripts/install.sh --tool '$tool' --no-interactive"
else
  log "Installing for current user '$(id -un)' (HOME=${HOME:-unknown})..."
  (
    cd "$repo_dir"
    ./scripts/install.sh --tool "$tool" --no-interactive
  )
fi

touch "$marker_file"
log "Installation completed for tool '$tool'."
