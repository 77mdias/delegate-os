#!/bin/bash
# Git Integration Plugin - post_push hook
# Logging and notifications after push

set -e

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="${DELEGADO_LOG_DIR:-~/.delegado/logs}"

log() {
    echo "[git-hook post_push] $*" >&2
}

log_git_activity() {
    local activity_type="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local remote="${GIT_REMOTE:-origin}"
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "unknown")
    local commits_pushed=$(git log --oneline "$GIT_SHA1^..HEAD" 2>/dev/null | wc -l || echo "0")
    
    mkdir -p "$LOG_DIR"
    echo "[$timestamp] $activity_type | remote=$remote | branch=$branch | commits=$commits_pushed" >> "$LOG_DIR/git-activity.log"
}

main() {
    log "Recording push..."
    log_git_activity "PUSH"
    exit 0
}

main
