#!/bin/bash
#===============================================================================
# Pre-ARCHITECT hook - runs before activating ARCHITECT mode
# Prepares architecture workspace and patterns
#===============================================================================

DELEGADO_ROOT="${DELEGADO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
VAULT_PATH="${OBSIDIAN_VAULT:-$HOME/obsidian-vault}"

mkdir -p "$VAULT_PATH/20-ARCHITECTURE"

echo "[HOOK] Pre-ARCHITECT: Preparing architecture workspace..."

# Load project context if exists
ARCHITECT_PREFS="$DELEGADO_ROOT/.delegado/architect_prefs.json"
if [ -f "$ARCHITECT_PREFS" ]; then
    echo "[HOOK] Loaded architecture preferences"
else
    cat > "$ARCHITECT_PREFS" << 'EOF'
{
  "preferred_patterns": ["repository", "factory", "strategy"],
  "current_architecture": null,
  "tech_stack": [],
  "last_architecture_doc": null
}
EOF
fi

export DELEGADO_MODE="ARCHITECT"
export DELEGADO_VAULT="$VAULT_PATH/20-ARCHITECTURE"
export DELEGADO_DESIGN_PRINCIPLES="SOLID,GRASP,DRY"

echo "[HOOK] Architect mode ready. Vault: $VAULT_PATH/20-ARCHITECTURE"
