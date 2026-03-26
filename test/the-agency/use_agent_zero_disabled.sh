#!/bin/bash
set -e

source dev-container-features-test-lib

check "global AGENT_ROUTING.md exists" bash -c \
    "test -s \"$HOME/.the-agency/AGENT_ROUTING.md\""

check "on-create creates AGENTS.md with routing rules only (when disabled)" bash -c '
    # Simulate use-agent-zero=false by ensuring the marker does NOT exist
    tmp_ws="$(mktemp -d)"
    marker_dir="/usr/local/share/devcontainer-features"
    
    cd "$tmp_ws"
    
    # Run the script - since the marker file does not exist, it should add routing rules only
    /usr/local/share/devcontainer-features/the-agency-on-create.sh
    
    test -s "$tmp_ws/AGENTS.md"
    grep -q "How to Choose the Right Specialist Agent (Mandatory)" "$tmp_ws/AGENTS.md"
    grep -q "~/.the-agency/AGENT_ROUTING.md" "$tmp_ws/AGENTS.md"
    ! grep -q "Canonical Agent Guide (Mandatory)" "$tmp_ws/AGENTS.md"
    ! grep -q "~/.the-agency/AGENTS.md" "$tmp_ws/AGENTS.md"
'

check "on-create updates existing AGENTS.md with routing rules only (when disabled)" bash -c '
    tmp_ws="$(mktemp -d)"
    cat > "$tmp_ws/AGENTS.md" <<"EOF"
# User Content

Keep this user content.

<!-- the-agency:workspace-rules:start -->
# Old content
Old routing old canonical
<!-- the-agency:workspace-rules:end -->
EOF
    cd "$tmp_ws"
    
    # Run the script - since the marker file does not exist, it should update with routing rules only
    /usr/local/share/devcontainer-features/the-agency-on-create.sh
    
    test -s "$tmp_ws/AGENTS.md"
    grep -q "Keep this user content." "$tmp_ws/AGENTS.md"
    grep -q "How to Choose the Right Specialist Agent (Mandatory)" "$tmp_ws/AGENTS.md"
    ! grep -q "Canonical Agent Guide (Mandatory)" "$tmp_ws/AGENTS.md"
    ! grep -q "Old content" "$tmp_ws/AGENTS.md"
'

reportResults
