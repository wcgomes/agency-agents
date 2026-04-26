#!/bin/bash
set -e

source dev-container-features-test-lib

check "agents-workspace marker file exists" bash -c \
    "ls /usr/local/share/devcontainer-features/agents-workspace-v1*.done 2>/dev/null | grep -q ."

check "agents-workspace-install.sh exists for autoupdate" bash -c \
    "ls /usr/local/share/devcontainer-features/agents-workspace-install.sh 2>/dev/null | grep -q ."

check "agents-workspace commit file exists" bash -c \
    "ls /usr/local/share/devcontainer-features/agents-workspace-v1.commit 2>/dev/null | grep -q ."

reportResults