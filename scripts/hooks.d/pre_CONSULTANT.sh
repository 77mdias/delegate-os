#!/bin/bash
# Pre-CONSULTANT hook - prepares consulting workspace
DELEGADO_ROOT="${DELEGADO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
VAULT_PATH="${OBSIDIAN_VAULT:-$HOME/obsidian-vault}"
mkdir -p "$VAULT_PATH/70-CONSULTING"
export DELEGADO_MODE="CONSULTANT"
export DELEGADO_VAULT="$VAULT_PATH/70-CONSULTING"
echo "[HOOK] Consultant mode ready."
