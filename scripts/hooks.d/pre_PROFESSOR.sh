#!/bin/bash
#===============================================================================
# Pre-PROFESSOR hook - runs before activating PROFESSOR mode
# Prepares learning context and workspace
#===============================================================================

DELEGADO_ROOT="${DELEGADO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
VAULT_PATH="${OBSIDIAN_VAULT:-$HOME/obsidian-vault}"

# Ensure education vault exists
mkdir -p "$VAULT_PATH/10-EDUCATION"

echo "[HOOK] Pre-PROFESSOR: Preparing learning environment..."

# Load learning preferences if exists
LEARNING_PREFS="$DELEGADO_ROOT/.delegado/learning_prefs.json"
if [ -f "$LEARNING_PREFS" ]; then
    echo "[HOOK] Loaded learning preferences"
else
    # Create default preferences
    cat > "$LEARNING_PREFS" << 'EOF'
{
  "preferred_learning_style": "hands-on",
  "difficulty": "intermediate",
  "topics_covered": [],
  "study_streak": 0
}
EOF
    echo "[HOOK] Created default learning preferences"
fi

# Set context for professor mode
export DELEGADO_MODE="PROFESSOR"
export DELEGADO_VAULT="$VAULT_PATH/10-EDUCATION"
export DELEGADO_TEACHING_METHOD="four_cs"

echo "[HOOK] Professor mode ready. Vault: $VAULT_PATH/10-EDUCATION"
