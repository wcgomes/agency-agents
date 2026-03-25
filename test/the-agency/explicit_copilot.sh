#!/bin/bash
set -e

source dev-container-features-test-lib

check "marker file exists for explicit copilot install" bash -c \
    "ls /usr/local/share/devcontainer-features/the-agency-v3-copilot-false-*.done 2>/dev/null | grep -q ."

reportResults
