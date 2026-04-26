#!/bin/bash
set -e

source dev-container-features-test-lib

check "agents-workspace marker old exists (optional)" bash -c \
    "ls /usr/local/share/devcontainer-features/agents-workspace-v1*.done 2>/dev/null | grep -q ." || true

check "agents-workspace-install.sh exists for autoupdate" bash -c \
    "ls /usr/local/share/devcontainer-features/agents-workspace-install.sh 2>/dev/null | grep -q ."

check "agents-workspace-postStartCommand.sh exists for autoupdate" bash -c \
    "ls /usr/local/share/devcontainer-features/agents-workspace-postStartCommand.sh 2>/dev/null | grep -q ."

check "agents-workspace marker new exists" bash -c \
    "ls ~/.local/share/devcontainer-features/agents-workspace.done 2>/dev/null | grep -q ."

reportResults