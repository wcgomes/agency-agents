#!/bin/bash
set -e

source dev-container-features-test-lib

check "agency-agents marker file exists" bash -c \
    "ls /usr/local/share/devcontainer-features/agency-agents-v1-auto-*.done 2>/dev/null | grep -q ."

check "agency-agents-install.sh exists for autoupdate" bash -c \
    "ls /usr/local/share/devcontainer-features/agency-agents-install.sh 2>/dev/null | grep -q ."

reportResults
