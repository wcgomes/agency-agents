#!/bin/bash
set -e

source dev-container-features-test-lib

check "use-agent-zero marker exists" bash -c \
    "test -f /usr/local/share/devcontainer-features/the-agency-use-agent-zero.enabled"

check "on-create helper exists and is executable" bash -c \
    "test -x /usr/local/share/devcontainer-features/the-agency-on-create.sh"

check "global AGENT_ROUTING.md exists" bash -c \
    "test -s \"$HOME/.the-agency/AGENT_ROUTING.md\""

check "on-create creates AGENTS.md in workspace when missing" bash -c '
    tmp_ws="$(mktemp -d)"
    cd "$tmp_ws"
    /usr/local/share/devcontainer-features/the-agency-on-create.sh
    test -s "$tmp_ws/AGENTS.md"
'

check "on-create upserts only feature blocks in existing AGENTS.md" bash -c '
    tmp_ws="$(mktemp -d)"
    cat > "$tmp_ws/AGENTS.md" <<"EOF"
# User Managed Content

Keep this line untouched.

<!-- the-agency-feature:workspace-references:start -->
# Old Canonical Header
old canonical body
# Old Routing Header
old routing body
<!-- the-agency-feature:workspace-references:end -->
EOF
    cd "$tmp_ws"
    /usr/local/share/devcontainer-features/the-agency-on-create.sh
    test -s "$tmp_ws/AGENTS.md"
    grep -q "Keep this line untouched." "$tmp_ws/AGENTS.md"
    grep -q "How to Choose the Right Specialist Agent (Mandatory)" "$tmp_ws/AGENTS.md"
    grep -q "Canonical Agent Guide (Mandatory)" "$tmp_ws/AGENTS.md"
    ! grep -q "old routing body" "$tmp_ws/AGENTS.md"
    ! grep -q "old canonical body" "$tmp_ws/AGENTS.md"
'

check "on-create references global AGENT_ROUTING.md in AGENTS.md" bash -c '
    tmp_ws="$(mktemp -d)"
    cd "$tmp_ws"
    /usr/local/share/devcontainer-features/the-agency-on-create.sh
    grep -q "~/.the-agency/AGENT_ROUTING.md" "$tmp_ws/AGENTS.md"
'

check "on-create writes global AGENT-ZERO.md" bash -c '
    tmp_ws="$(mktemp -d)"
    cd "$tmp_ws"
    /usr/local/share/devcontainer-features/the-agency-on-create.sh
    test -s "$HOME/.the-agency/AGENT-ZERO.md"
'

check "on-create references global AGENT-ZERO.md in AGENTS.md" bash -c '
    tmp_ws="$(mktemp -d)"
    cd "$tmp_ws"
    /usr/local/share/devcontainer-features/the-agency-on-create.sh
    grep -q "~/.the-agency/AGENT-ZERO.md" "$tmp_ws/AGENTS.md"
'

check "on-create injects agent routing rules header into AGENTS.md" bash -c '
    tmp_ws="$(mktemp -d)"
    cd "$tmp_ws"
    /usr/local/share/devcontainer-features/the-agency-on-create.sh
    grep -q "How to Choose the Right Specialist Agent (Mandatory)" "$tmp_ws/AGENTS.md"
'

check "on-create injects canonical agent guide header into AGENTS.md" bash -c '
    tmp_ws="$(mktemp -d)"
    cd "$tmp_ws"
    /usr/local/share/devcontainer-features/the-agency-on-create.sh
    grep -q "Canonical Agent Guide (Mandatory)" "$tmp_ws/AGENTS.md"
'

reportResults
