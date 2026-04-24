#!/bin/bash
# Git Integration Plugin - pre_commit hook
# Validates commit messages and branch names before commit

set -e

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$PLUGIN_DIR/manifest.yaml"

# Source shared functions if available
DELEGADO_CONFIG_DIR="${DELEGADO_CONFIG_DIR:-~/.delegado}"
if [ -f "$DELEGADO_CONFIG_DIR/lib/common.sh" ]; then
    source "$DELEGADO_CONFIG_DIR/lib/common.sh"
fi

# Parse config (simple YAML parser)
get_config() {
    local key="$1"
    grep "^${key}:" "$CONFIG_FILE" 2>/dev/null | head -1 | sed 's/.*:\s*//' | tr -d '"'
}

get_config_list() {
    local key="$1"
    sed -n "/^${key}:/,/^[a-z]/p" "$CONFIG_FILE" 2>/dev/null | grep -E "^\s+-" | sed 's/.*-\s*//' | tr -d '"'
}

log() {
    echo "[git-hook pre_commit] $*" >&2
}

# Get commit message (from argument or file)
COMMIT_MSG="${1:-$(cat /dev/stdin 2>/dev/null | head -1)}"

# If no message provided via args, try git's commit-msg hook
if [ -z "$COMMIT_MSG" ] && [ -f "$1" ] && [[ "$1" == *.tmp ]]; then
    COMMIT_MSG=$(cat "$1")
fi

# Validate commit message format
validate_commit_message() {
    local msg="$1"
    local type_pattern="^(feat|fix|docs|style|refactor|test|chore|perf|ci|revert)(\(.+\))?: .+"
    
    if [ -z "$msg" ]; then
        log "ERROR: Empty commit message"
        return 1
    fi
    
    if ! echo "$msg" | grep -qE "$type_pattern"; then
        log "ERROR: Invalid commit message format"
        log "Expected: <type>(<scope>): <subject>"
        log "Types: feat, fix, docs, style, refactor, test, chore, perf, ci, revert"
        return 1
    fi
    
    # Check subject length
    local subject=$(echo "$msg" | head -1 | sed 's/.*:\s*//')
    local max_len=$(get_config "max_commit_subject_length" || echo "72")
    if [ ${#subject} -gt "$max_len" ]; then
        log "WARNING: Commit subject exceeds $max_len characters (${#subject})"
    fi
    
    return 0
}

# Check branch name
validate_branch_name() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")
    
    if [ -z "$branch" ]; then
        return 0  # Detached HEAD, skip branch check
    fi
    
    # Check protected branches
    local protected=$(get_config_list "protected_branches")
    for prot in $protected; do
        if [ "$branch" = "$prot" ]; then
            log "WARNING: Committing directly to protected branch '$branch'"
            return 0  # Allow but warn
        fi
    done
    
    # Check prefix requirement
    local require_prefix=$(get_config "require_branch_prefix" || echo "false")
    if [ "$require_prefix" = "true" ]; then
        local prefixes=$(get_config_list "branch_prefixes")
        local valid=0
        for prefix in $prefixes; do
            if [[ "$branch" == "$prefix"* ]]; then
                valid=1
                break
            fi
        done
        if [ "$valid" -eq 0 ]; then
            log "ERROR: Branch name '$branch' does not match required prefix pattern"
            log "Valid prefixes: $prefixes"
            return 1
        fi
    fi
    
    return 0
}

# Main execution
main() {
    log "Running pre-commit validation..."
    
    # Only validate if we have a commit message
    if [ -n "$COMMIT_MSG" ]; then
        validate_commit_message "$COMMIT_MSG"
    fi
    
    validate_branch_name
    
    log "Pre-commit validation passed"
    exit 0
}

main
