#!/bin/bash
# Backup Plugin - Daily Backup Hook
# Runs daily backup of Delegado OS

set -e

DELEGADO_HOME="${DELEGADO_HOME:-/root/projects/delegate-os}"
BACKUP_PATH="${BACKUP_PATH:-$HOME/.delegado/backups}"
RETENTION_DAYS="${RETENTION_DAYS:-30}"
DATE=$(date +%Y%m%d)

mkdir -p "$BACKUP_PATH"

log() {
    echo "[backup:daily] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log "Starting daily backup..."

BACKUP_FILE="$BACKUP_PATH/delegado-os-$DATE.tar.gz"

# Create backup
tar -czf "$BACKUP_FILE" \
    -C "$DELEGADO_HOME" \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='*.log' \
    --exclude='.delegado/analysis' \
    subagents/ \
    plugins/ \
    scripts/ \
    workflows/ \
    templates/ \
    *.md \
    2>/dev/null && \
    log "Backup created: $BACKUP_FILE ($(du -h $BACKUP_FILE | cut -f1))"

# Cleanup old backups
find "$BACKUP_PATH" -name "delegado-os-*.tar.gz" -mtime +$RETENTION_DAYS -delete
log "Cleaned backups older than $RETENTION_DAYS days"

# Create latest symlink
rm -f "$BACKUP_PATH/delegado-os-latest.tar.gz"
ln -s "$BACKUP_FILE" "$BACKUP_PATH/delegado-os-latest.tar.gz"

log "Daily backup complete"
