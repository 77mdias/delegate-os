#!/bin/bash
# Pre-RESEARCHER hook - prepares research workspace
DELEGADO_ROOT="${DELEGADO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
VAULT_PATH="${OBSIDIAN_VAULT:-$HOME/obsidian-vault}"
mkdir -p "$VAULT_PATH/50-RESEARCH"
export DELEGADO_MODE="RESEARCHER"
export DELEGADO_VAULT="$VAULT_PATH/50-RESEARCH"
echo "[HOOK] Researcher mode ready."
