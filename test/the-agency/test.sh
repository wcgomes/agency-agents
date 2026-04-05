#!/bin/bash
set -e

source dev-container-features-test-lib

check "the-agency marker file exists" bash -c \
    "ls /usr/local/share/devcontainer-features/the-agency-v4-auto-*.done 2>/dev/null | grep -q ."

reportResults
