#!/bin/bash
# Pre-DEBUGGER hook - prepares debugging workspace
DELEGADO_ROOT="${DELEGADO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
VAULT_PATH="${OBSIDIAN_VAULT:-$HOME/obsidian-vault}"
mkdir -p "$VAULT_PATH/30-BUGS"
export DELEGADO_MODE="DEBUGGER"
export DELEGADO_VAULT="$VAULT_PATH/30-BUGS"
echo "[HOOK] Debugger mode ready."
