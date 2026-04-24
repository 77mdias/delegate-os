#!/bin/bash
# Git Integration Plugin - post_commit hook
# Logging and notifications after commits

set -e

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="${DELEGADO_LOG_DIR:-~/.delegado/logs}"

log() {
    echo "[git-hook post_commit] $*" >&2
}

log_git_activity() {
    local activity_type="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local commit_sha=$(git rev-parse HEAD 2>/dev/null || echo "unknown")
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")
    local author=$(git log -1 --format='%an <%ae>' 2>/dev/null || echo "unknown")
    local subject=$(git log -1 --format='%s' 2>/dev/null || echo "")
    
    mkdir -p "$LOG_DIR"
    echo "[$timestamp] $activity_type | sha=${commit_sha:0:8} | branch=$branch | author=$author | $subject" >> "$LOG_DIR/git-activity.log"
}

main() {
    log "Recording commit..."
    log_git_activity "COMMIT"
    exit 0
}

main
