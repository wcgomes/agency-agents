#!/bin/bash
set -e

source dev-container-features-test-lib

check "marker file exists for default auto install" bash -c \
    "ls /usr/local/share/devcontainer-features/agency-agents-v2-auto-*.done 2>/dev/null | grep -q ."

reportResults
