#!/bin/bash
set -e

source dev-container-features-test-lib

check "marker file exists for explicit all install" bash -c \
    "ls /usr/local/share/devcontainer-features/agency-agents-v2-all-*.done 2>/dev/null | grep -q ."

reportResults
