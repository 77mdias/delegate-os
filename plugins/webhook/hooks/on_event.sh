#!/bin/bash
# Webhook Plugin - Event Handler
# Dispatches events to configured webhook endpoints

set -e

DELEGADO_HOME="${DELEGADO_HOME:-/root/projects/delegate-os}"
MANIFEST="$DELEGADO_HOME/plugins/webhook/manifest.yaml"
TIMEOUT="${TIMEOUT:-10}"
RETRY_COUNT="${RETRY_COUNT:-3}"

log() {
    echo "[webhook] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Extract endpoints from manifest (simplified - use yq in production)
send_webhook() {
    local url="$1"
    local event="$2"
    local payload="$3"
    local secret="$4"
    
    local headers="Content-Type: application/json"
    if [ -n "$secret" ]; then
        local signature=$(echo -n "$payload" | openssl dgst -sha256 -hmac "$secret" | cut -d' ' -f2)
        headers="$headers\nX-Delegado-Signature: sha256=$signature"
    fi
    
    for attempt in $(seq 1 $RETRY_COUNT); do
        response=$(curl -s -w "%{http_code}" \
            --max-time $TIMEOUT \
            -X POST "$url" \
            -H "Content-Type: application/json" \
            -d "$payload" 2>/dev/null || echo "000")
        
        if [ "$response" = "200" ] || [ "$response" = "201" ]; then
            log "Webhook sent successfully to $url (attempt $attempt)"
            return 0
        fi
        
        log "Webhook failed (attempt $attempt/$RETRY_COUNT): $response"
        [ $attempt -lt $RETRY_COUNT ] && sleep 2
    done
    
    log "Webhook failed after $RETRY_COUNT attempts"
    return 1
}

EVENT="${1:-session_complete}"
SESSION_ID="${2:-$(date +%s)}"
MODE="${3:-unknown}"

PAYLOAD=$(cat << EOF
{
    "event": "$EVENT",
    "session_id": "$SESSION_ID",
    "mode": "$MODE",
    "timestamp": "$(date -Iseconds)",
    "source": "delegado-os"
}
EOF
)

# Read endpoints from config and send
if [ -f "$MANIFEST" ]; then
    # For each configured endpoint that matches this event
    # Simplified - in production use yq or jq to parse YAML
    for url_var in WEBHOOK_URL_1 WEBHOOK_URL_2; do
        url="${!url_var}"
        if [ -n "$url" ]; then
            secret_var="${url_var/_URL_/_SECRET_}"
            secret="${!secret_var}"
            send_webhook "$url" "$EVENT" "$PAYLOAD" "$secret"
        fi
    done
fi

log "Event processed: $EVENT"
