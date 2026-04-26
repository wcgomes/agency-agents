#!/bin/bash
set -e

source dev-container-features-test-lib

check "autoupdate enabled - commit file exists" bash -c \
    "ls /usr/local/share/devcontainer-features/agency-agents-v1.commit 2>/dev/null | grep -q ."

check "autoupdate enabled - commit file not empty" bash -c \
    "cat /usr/local/share/devcontainer-features/agency-agents-v1.commit | grep -q ."

reportResults