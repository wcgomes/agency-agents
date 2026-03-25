#!/bin/sh

set -eu

log() {
  echo "[the-agency-feature:on-create] $*"
}

marker_dir="/usr/local/share/devcontainer-features"
enabled_marker="$marker_dir/the-agency-use-agent-zero.enabled"
output_file="$PWD/AGENTS.md"
global_agents_dir="${HOME}/.agents"
global_routing_file="${HOME}/.agents/AGENT_ROUTING.md"
global_agent_zero_file="${HOME}/.agents/AGENT-ZERO.md"
source_url="https://raw.githubusercontent.com/msitarzewski/AGENT-ZERO/main/AGENTS.md"

write_workspace_agents_reference() {
  dst_file="$1"
  references_block_file="$2"

  if [ ! -f "$dst_file" ]; then
    cat "$references_block_file" > "$dst_file"
    return 0
  fi

  upsert_block "$dst_file" \
    "<!-- the-agency-feature:workspace-references:start -->" \
    "<!-- the-agency-feature:workspace-references:end -->" \
    "$references_block_file"
}

upsert_block() {
  dst_file="$1"
  start_marker="$2"
  end_marker="$3"
  block_file="$4"

  tmp_file="$(mktemp /tmp/the-agency-upsert-XXXXXX)"

  if grep -qF "$start_marker" "$dst_file"; then
    awk -v start="$start_marker" -v end="$end_marker" -v replacement="$block_file" '
      BEGIN { in_block=0 }
      {
        if (index($0, start) > 0) {
          while ((getline line < replacement) > 0) {
            print line
          }
          close(replacement)
          in_block=1
          next
        }

        if (in_block == 1) {
          if (index($0, end) > 0) {
            in_block=0
          }
          next
        }

        print
      }
    ' "$dst_file" > "$tmp_file"
  else
    cat "$dst_file" > "$tmp_file"
    printf "\n" >> "$tmp_file"
    cat "$block_file" >> "$tmp_file"
    printf "\n" >> "$tmp_file"
  fi

  mv "$tmp_file" "$dst_file"
}
log "Writing workspace AGENTS.md with agent routing rules"
mkdir -p "$global_agents_dir"

tmp_agents_file=""
references_block_file="$(mktemp /tmp/the-agency-references-XXXXXX)"
cleanup() {
  [ -n "$tmp_agents_file" ] && rm -f "$tmp_agents_file"
  rm -f "$references_block_file"
}
trap cleanup EXIT

# Check if use-agent-zero is enabled
use_agent_zero_enabled=false
if [ -f "$enabled_marker" ]; then
  use_agent_zero_enabled=true
fi

# Build the references block content dynamically based on use-agent-zero flag
{
  echo "<!-- the-agency-feature:workspace-references:start -->"
  
  if [ "$use_agent_zero_enabled" = true ]; then
    echo "# Canonical Agent Guide (Mandatory)"
    echo ""
    echo "Use ~/.agents/AGENT-ZERO.md as the global AGENTS baseline before execution."
    echo ""
  fi
  
  echo "# Agent Routing Rules (Mandatory)"
  echo ""
  echo "Before selecting a specialist agent, first classify the request by division."
  echo "Then use ~/.agents/AGENT_ROUTING.md as the routing reference to choose the primary and fallback agent."
  echo ""
  echo "<!-- the-agency-feature:workspace-references:end -->"
} > "$references_block_file"

# If use-agent-zero is enabled, download and sync AGENT-ZERO
if [ "$use_agent_zero_enabled" = true ]; then
  log "use-agent-zero is enabled. Syncing AGENT-ZERO to global location: $global_agent_zero_file"
  tmp_agents_file="$(mktemp /tmp/the-agency-on-create-XXXXXX)"
  
  if command -v curl >/dev/null 2>&1; then
    if ! curl -fsSL "$source_url" -o "$tmp_agents_file"; then
      log "WARNING: Could not download AGENTS.md with curl. Using routing rules only."
    else
      cp "$tmp_agents_file" "$global_agent_zero_file"
      log "Global AGENT-ZERO synced to $global_agent_zero_file"
    fi
  elif command -v wget >/dev/null 2>&1; then
    if ! wget -qO "$tmp_agents_file" "$source_url"; then
      log "WARNING: Could not download AGENTS.md with wget. Using routing rules only."
    else
      cp "$tmp_agents_file" "$global_agent_zero_file"
      log "Global AGENT-ZERO synced to $global_agent_zero_file"
    fi
  else
    log "WARNING: Neither curl nor wget is available. Using routing rules only."
  fi
else
  log "use-agent-zero is disabled. Writing routing rules only."
fi

write_workspace_agents_reference "$output_file" "$references_block_file"
log "AGENTS.md updated successfully with agent routing rules."
