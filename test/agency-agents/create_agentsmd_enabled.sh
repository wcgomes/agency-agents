#!/bin/bash
set -e

source dev-container-features-test-lib

check "create-agentsmd marker exists" bash -c \
    "test -f /usr/local/share/devcontainer-features/agency-agents-create-agentsmd.enabled"

check "on-create helper exists and is executable" bash -c \
    "test -x /usr/local/share/devcontainer-features/agency-agents-on-create.sh"

check "on-create overwrites AGENTS.md in workspace" bash -c '
    tmp_ws="$(mktemp -d)"
    echo "old content" > "$tmp_ws/AGENTS.md"
    cd "$tmp_ws"
    /usr/local/share/devcontainer-features/agency-agents-on-create.sh
    test -s "$tmp_ws/AGENTS.md"
    ! grep -qx "old content" "$tmp_ws/AGENTS.md"
'

reportResults
