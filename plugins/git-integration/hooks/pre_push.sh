#!/bin/bash
# Git Integration Plugin - pre_push hook
# Validation before push

set -e

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$PLUGIN_DIR/manifest.yaml"

log() {
    echo "[git-hook pre_push] $*" >&2
}

# Check if pushing to protected branch
check_protected_branch() {
    local remote="$1"
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || return 0)
    
    # Get protected branches from config
    if grep -q "protected_branches:" "$CONFIG_FILE" 2>/dev/null; then
        local protected=$(sed -n '/^protected_branches:/,/^[a-z]/p' "$CONFIG_FILE" 2>/dev/null | grep -E "^\s+-" | sed 's/.*-\s*//')
        
        for prot in $protected; do
            if [ "$branch" = "$prot" ]; then
                log "WARNING: Pushing directly to protected branch '$branch'"
                log "Consider using a pull request for changes to this branch"
                return 0  # Allow push but warn
            fi
        done
    fi
}

# Check for large files
check_file_sizes() {
    local size_limit=10  # MB
    
    # Check staged files over size limit
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
            local size_mb=$((size / 1024 / 1024))
            
            if [ "$size_mb" -gt "$size_limit" ]; then
                log "WARNING: Large file detected: $file (${size_mb}MB)"
                log "Consider using Git LFS for large files"
            fi
        fi
    done < <(git diff --cached --name-only)
}

# Check branch name validity
check_branch_name() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || return 0)
    
    # Invalid characters
    if echo "$branch" | grep -qE '[\~^:\[\]\\?\*"@{}]'; then
        log "ERROR: Branch name contains invalid characters: $branch"
        return 1
    fi
    
    # Ends with .lock
    if echo "$branch" | grep -qE '\.lock$'; then
        log "ERROR: Branch name cannot end with .lock: $branch"
        return 1
    fi
}

main() {
    log "Running pre-push validation..."
    
    check_branch_name
    check_protected_branch
    check_file_sizes
    
    log "Pre-push validation passed"
    exit 0
}

main
