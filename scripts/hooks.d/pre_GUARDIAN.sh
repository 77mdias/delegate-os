#!/bin/bash
# Pre-GUARDIAN hook - prepares security workspace
DELEGADO_ROOT="${DELEGADO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
VAULT_PATH="${OBSIDIAN_VAULT:-$HOME/obsidian-vault}"
mkdir -p "$VAULT_PATH/40-SECURITY"
export DELEGADO_MODE="GUARDIAN"
export DELEGADO_VAULT="$VAULT_PATH/40-SECURITY"
echo "[HOOK] Guardian mode ready."
