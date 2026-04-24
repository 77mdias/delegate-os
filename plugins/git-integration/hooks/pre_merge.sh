#!/bin/bash
# Git Integration Plugin - pre_merge hook
# Validation before merge

set -e

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$PLUGIN_DIR/manifest.yaml"

log() {
    echo "[git-hook pre_merge] $*" >&2
}

check_merge_to_protected() {
    local to_branch="${TO_BRANCH:-$(git rev-parse --abbrev-ref HEAD 2>/dev/null)}"
    
    if grep -q "protected_branches:" "$CONFIG_FILE" 2>/dev/null; then
        local protected=$(sed -n '/^protected_branches:/,/^[a-z]/p' "$CONFIG_FILE" 2>/dev/null | grep -E "^\s+-" | sed 's/.*-\s*//')
        
        for prot in $protected; do
            if [ "$to_branch" = "$prot" ]; then
                log "WARNING: Merge to protected branch '$to_branch'"
                log "Consider if this merge requires review/approval"
            fi
        done
    fi
}

main() {
    log "Running pre-merge validation..."
    check_merge_to_protected
    log "Pre-merge validation passed"
    exit 0
}

main
