#!/bin/bash
# Notification Plugin - Session Complete Hook
# Sends notification when a session completes

set -e

DELEGADO_HOME="${DELEGADO_HOME:-/root/projects/delegate-os}"
MODE="${MODE:-unknown}"
DURATION="${DURATION:-unknown}"
SESSION_ID="${SESSION_ID:-$(date +%s)}"

# Load config
NOTIFICATION_CONFIG="$DELEGADO_HOME/plugins/notification/manifest.yaml"

log() {
    echo "[notification:session_complete] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Send Telegram notification
send_telegram() {
    local message="$1"
    local token="${TELEGRAM_BOT_TOKEN:-}"
    local chat_id="${TELEGRAM_CHAT_ID:-}"
    
    if [ -n "$token" ] && [ -n "$chat_id" ]; then
        curl -s -X POST "https://api.telegram.org/bot$token/sendMessage" \
            -d "chat_id=$chat_id" \
            -d "text=$message" \
            -d "parse_mode=Markdown" > /dev/null 2>&1 || true
        log "Telegram notification sent"
    fi
}

# Send Slack notification
send_slack() {
    local message="$1"
    local webhook="${SLACK_WEBHOOK:-}"
    
    if [ -n "$webhook" ]; then
        curl -s -X POST "$webhook" \
            -H 'Content-Type: application/json' \
            -d "{\"text\":\"$message\"}" > /dev/null 2>&1 || true
        log "Slack notification sent"
    fi
}

# Send email notification
send_email() {
    local subject="$1"
    local body="$2"
    local to="${EMAIL_TO:-}"
    local from="${EMAIL_FROM:-noreply@delegado.os}"
    
    if [ -n "$to" ]; then
        echo -e "$body" | mail -s "$subject" -r "$from" "$to" 2>/dev/null || true
        log "Email notification sent"
    fi
}

# Format message
MESSAGE="✅ *Session Complete*

*Mode:* $MODE
*Duration:* ${DURATION}s
*Session:* \`$SESSION_ID\`
*Time:* $(date '+%Y-%m-%d %H:%M:%S')"

# Send to all configured channels
send_telegram "$MESSAGE"
send_slack "$MESSAGE"
send_email "Delegado OS - Session Complete" "$MESSAGE"

log "Session complete notification dispatched"
