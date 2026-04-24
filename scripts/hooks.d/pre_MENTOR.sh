#!/bin/bash
# Pre-MENTOR hook - prepares career workspace
DELEGADO_ROOT="${DELEGADO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
VAULT_PATH="${OBSIDIAN_VAULT:-$HOME/obsidian-vault}"
mkdir -p "$VAULT_PATH/60-CAREER"
export DELEGADO_MODE="MENTOR"
export DELEGADO_VAULT="$VAULT_PATH/60-CAREER"
echo "[HOOK] Mentor mode ready."
