#!/bin/bash
# Git Integration Plugin - on_branch_create hook
# Called when a new branch is created

set -e

LOG_DIR="${DELEGADO_LOG_DIR:-~/.delegado/logs}"

log_branch_activity() {
    local activity_type="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local branch="${BRANCH_NAME:-$(git symbolic-ref --short HEAD 2>/dev/null)}"
    local from_branch="${FROM_BRANCH:-$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "none")}"
    
    mkdir -p "$LOG_DIR"
    echo "[$timestamp] $activity_type | branch=$branch | from=$from_branch" >> "$LOG_DIR/git-activity.log"
}

main() {
    echo "[git-hook on_branch_create] Branch created: ${BRANCH_NAME:-unknown}"
    log_branch_activity "BRANCH_CREATE"
    exit 0
}

main
