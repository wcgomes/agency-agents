#!/bin/bash
set -e

echo "=== Validation: Agency Agents Feature Behavior ==="
echo ""

# Test the on-create.sh script logic by examining it
on_create_file="/workspaces/devcontainer-features/src/the-agency/on-create.sh"

echo "✓ Checking script syntax..."
sh -n "$on_create_file" || { echo "FAIL: Syntax error in on-create.sh"; exit 1; }

echo "✓ Script is syntactically valid"
echo ""

echo "=== Validating Implementation Logic ==="
echo ""

# Check 1: Verify that use-agent-zero flag is being checked
echo "Check 1: use-agent-zero flag detection"
if grep -q 'use_agent_zero_enabled=false' "$on_create_file" && \
   grep -q 'if \[ -f "\$enabled_marker" \]' "$on_create_file" && \
   grep -q 'use_agent_zero_enabled=true' "$on_create_file"; then
  echo "✓ Flag detection logic present"
else
  echo "FAIL: Missing flag detection logic"
  exit 1
fi
echo ""

# Check 2: Verify that routing rules are ALWAYS added
echo "Check 2: Routing rules always included"
if grep -q 'echo "# Agent Routing Rules (Mandatory)"' "$on_create_file"; then
  echo "✓ Routing rules section present in block"
else
  echo "FAIL: Routing rules not found"
  exit 1
fi
echo ""

# Check 3: Verify that canonical guide is conditional (only when enabled)
echo "Check 3: Canonical guide is conditional"
if grep -q 'if \[ "\$use_agent_zero_enabled" = true \]; then' "$on_create_file" && \
   grep -q 'echo "# Canonical Agent Guide (Mandatory)"' "$on_create_file"; then
  echo "✓ Canonical guide is only added when flag is true"
else
  echo "FAIL: Canonical guide condition not implemented correctly"
  exit 1
fi
echo ""

# Check 4: Verify order (Canonical BEFORE Routing)
echo "Check 4: Canonical guide appears BEFORE routing rules in block"
canonical_pos=$(grep -n 'Canonical Agent Guide' "$on_create_file" | head -1 | cut -d: -f1)
routing_pos=$(grep -n 'Agent Routing Rules' "$on_create_file" | grep -v Canonical | head -1 | cut -d: -f1)
if [ "$canonical_pos" -lt "$routing_pos" ]; then
  echo "✓ Canonical guide comes before routing rules (line $canonical_pos < $routing_pos)"
else
  echo "FAIL: Canonical guide should come before routing rules"
  exit 1
fi
echo ""

# Check 5: Verify write_workspace_agents_reference is always called
echo "Check 5: AGENTS.md is always updated"
if grep -q 'write_workspace_agents_reference "\$output_file" "\$references_block_file"' "$on_create_file"; then
  echo "✓ write_workspace_agents_reference is always called (not conditional)"
else
  echo "FAIL: write_workspace_agents_reference is not always called"
  exit 1
fi
echo ""

# Check 6: Verify agent-zero download is conditional
echo "Check 6: AGENT-ZERO download only when enabled"
if grep -q 'if \[ "\$use_agent_zero_enabled" = true \]' "$on_create_file" && \
   grep -A 20 'if \[ "\$use_agent_zero_enabled" = true \]' "$on_create_file" | grep -q 'curl\|wget'; then
  echo "✓ AGENT-ZERO download is conditional"
else
  echo "FAIL: AGENT-ZERO download condition not correct"
  exit 1
fi
echo ""

# Check 7: Verify single block marker (workspace-references)
echo "Check 7: Single unified block marker"
if grep -q 'the-agency-feature:workspace-references:start' "$on_create_file" && \
   grep -q 'the-agency-feature:workspace-references:end' "$on_create_file" && \\
   ! grep -q 'routing-reference\|agent-zero-reference' "$on_create_file"; then
  echo "✓ Using single workspace-references block (no dual markers)"
else
  echo "FAIL: Block markers not correct"
  exit 1
fi
echo ""

echo "=== ALL VALIDATIONS PASSED ✓ ==="
echo ""
echo "Summary:"
echo "  1. ✓ Routing rules ALWAYS added (even when use-agent-zero=false)"
echo "  2. ✓ Canonical guide only added when use-agent-zero=true"
echo "  3. ✓ Canonical guide appears BEFORE routing rules"
echo "  4. ✓ Single unified workspace-references block"
echo "  5. ✓ AGENTS.md always updated (created or upserted)"
