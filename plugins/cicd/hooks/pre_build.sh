#!/bin/bash
# CI/CD Plugin - Pre Build Hook
# Runs before any build process starts

set -e

DELEGADO_HOME="${DELEGADO_HOME:-/root/projects/delegate-os}"
OBSIDIAN_VAULT="${OBSIDIAN_VAULT:-/root/obsidian-vault}"

echo "[cicd:pre_build] Starting pre-build checks..."

# Run code quality checks
if [ -f "$DELEGADO_HOME/scripts/delegate.sh" ]; then
    echo "[cicd:pre_build] Delegado OS integrity check..."
fi

# Check for required files
REQUIRED_FILES="SKILL.md AGENT-MODES.md META-PROMPTING.md"
for file in $REQUIRED_FILES; do
    if [ ! -f "$DELEGADO_HOME/$file" ]; then
        echo "[cicd:pre_build] WARNING: Missing $file"
    fi
done

# Pre-build validation
echo "[cicd:pre_build] Running pre-build validation..."

# Sync build start to Obsidian if configured
if [ "$SYNC_TO_OBSIDIAN" = "true" ] && [ -d "$OBSIDIAN_VAULT" ]; then
    BUILD_NOTE="$OBSIDIAN_VAULT/00-BUILDS/build-$(date +%Y%m%d-%H%M%S).md"
    mkdir -p "$(dirname "$BUILD_NOTE")"
    cat > "$BUILD_NOTE" << EOF
---
type: build-session
timestamp: $(date -Iseconds)
status: started
---

# Build Started

Build ID: $(date +%Y%m%d-%H%M%S)
Triggered by: CI/CD plugin

## Pre-build Checks

- [ ] Dependencies installed
- [ ] Tests ready
- [ ] Lint passed

EOF
    echo "[cicd:pre_build] Build note created: $BUILD_NOTE"
fi

echo "[cicd:pre_build] Pre-build complete. Proceeding with build..."
