#!/bin/bash
# CI/CD Plugin - Post Build Hook
# Runs after successful build completion

set -e

DELEGADO_HOME="${DELEGADO_HOME:-/root/projects/delegate-os}"
OBSIDIAN_VAULT="${OBSIDIAN_VAULT:-/root/obsidian-vault}"
BUILD_STATUS="${BUILD_STATUS:-success}"

echo "[cicd:post_build] Build completed with status: $BUILD_STATUS"

if [ "$BUILD_STATUS" = "success" ]; then
    # Sync success to Obsidian
    if [ -d "$OBSIDIAN_VAULT" ]; then
        BUILD_LOG="$OBSIDIAN_VAULT/00-BUILDS/build-$(date +%Y%m%d-%H%M%S)-success.md"
        mkdir -p "$(dirname "$BUILD_LOG")"
        cat > "$BUILD_LOG" << EOF
---
type: build-success
timestamp: $(date -Iseconds)
build_id: $(date +%Y%m%d-%H%M%S)
---

# ✅ Build Successful

Build completed successfully.
Artifacts ready for deployment.

## Next Steps

- Run integration tests
- Deploy to staging
- Update documentation

EOF
    fi
    
    echo "[cicd:post_build] Build success logged to Obsidian"
fi
