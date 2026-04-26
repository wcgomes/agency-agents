#!/bin/bash
set -e

source dev-container-features-test-lib

TARGET_USER="${_REMOTE_USER:-node}"
TARGET_HOME="/home/$TARGET_USER"

check "marker file created with correct user" bash -c "ls /usr/local/share/devcontainer-features/agents-workspace-v1-${TARGET_USER}.done 2>/dev/null | grep -q ."

reportResults