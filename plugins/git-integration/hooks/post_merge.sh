#!/bin/bash
# Git Integration Plugin - post_merge hook
# Logging after merge

set -e

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="${DELEGADO_LOG_DIR:-~/.delegado/logs}"

log() {
    echo "[git-hook post_merge] $*" >&2
}

log_git_activity() {
    local activity_type="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")
    local merge_sha=$(git rev-parse HEAD 2>/dev/null || echo "unknown")
    
    mkdir -p "$LOG_DIR"
    echo "[$timestamp] $activity_type | sha=${merge_sha:0:8} | branch=$branch" >> "$LOG_DIR/git-activity.log"
}

main() {
    log "Recording merge..."
    log_git_activity "MERGE"
    exit 0
}

main
