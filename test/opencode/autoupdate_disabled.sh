#!/bin/bash
set -e

source dev-container-features-test-lib

check "opencode binary exists" test -f /usr/local/bin/opencode

check "autoupdate is disabled by default" bash -c '[ "${OPENCODE_AUTOUPDATE:-false}" = "false" ]'

reportResults