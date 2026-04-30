#!/bin/bash
# Git Integration Plugin - on_branch_delete hook
# Called when a branch is deleted

set -e

LOG_DIR="${DELEGADO_LOG_DIR:-~/.delegado/logs}"

log_branch_activity() {
    local activity_type="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local branch="${BRANCH_NAME:-unknown}"
    
    mkdir -p "$LOG_DIR"
    echo "[$timestamp] $activity_type | branch=$branch" >> "$LOG_DIR/git-activity.log"
}

main() {
    echo "[git-hook on_branch_delete] Branch deleted: ${BRANCH_NAME:-unknown}"
    log_branch_activity "BRANCH_DELETE"
    exit 0
}

main
