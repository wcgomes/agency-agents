#!/bin/bash
set -e

source dev-container-features-test-lib

check "marker file exists for no-agency install" bash -c \
    "ls /usr/local/share/devcontainer-features/agents-workspace-v1*.done 2>/dev/null | grep -q ."

check "agency-agents commit file should NOT exist when includeAgency=false" bash -c \
    "! ls /usr/local/share/devcontainer-features/agency-agents-v1.commit 2>/dev/null | grep -q ."

reportResults