#!/bin/bash
set -e

source dev-container-features-test-lib

check "marker file exists for opencode install" bash -c \
    "ls /usr/local/share/devcontainer-features/agents-workspace-v1*.done 2>/dev/null | grep -q ."

reportResults