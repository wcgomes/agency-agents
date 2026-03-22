#!/bin/bash
set -e

source dev-container-features-test-lib

check "agency-agents marker file exists" bash -c \
    "ls /usr/local/share/devcontainer-features/agency-agents-v2-copilot-*.done 2>/dev/null | grep -q ."

reportResults
