#!/bin/bash
# Logging Plugin - on_agent_error hook
# Logs agent errors with details

AGENT_ID="${AGENT_ID:-unknown}"
ERROR_MESSAGE="${ERROR_MESSAGE:-No error message provided}"
ERROR_TYPE="${ERROR_TYPE:-unknown}"
STACK_TRACE="${STACK_TRACE:-}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

LOG_FILE="${LOG_DIR:-~/.delegado/logs}/agent.log"
ERROR_LOG="${LOG_DIR:-~/.delegado/logs}/error.log"
ACTIVITY_LOG="${LOG_DIR:-~/.delegado/logs}/activity.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Log to agent log
echo "[$TIMESTAMP] ERROR | agent.error | agent_id=$AGENT_ID type=$ERROR_TYPE message=$ERROR_MESSAGE" >> "$LOG_FILE"

# Log to error log with stack trace if available
{
    echo "[$TIMESTAMP] ERROR | agent_id=$AGENT_ID"
    echo "  Type: $ERROR_TYPE"
    echo "  Message: $ERROR_MESSAGE"
    if [ -n "$STACK_TRACE" ]; then
        echo "  Stack Trace:"
        echo "$STACK_TRACE" | sed 's/^/    /'
    fi
    echo "---"
} >> "$ERROR_LOG"

# Activity log summary
echo "[$TIMESTAMP] AGENT_ERROR | $AGENT_ID | $ERROR_TYPE" >> "$ACTIVITY_LOG"

# Check alerting threshold
ERROR_COUNT=$(grep -c "AGENT_ERROR" "$ACTIVITY_LOG" 2>/dev/null || echo "0")
THRESHOLD="${LOGGING_ERROR_THRESHOLD:-10}"

if [ "$ERROR_COUNT" -ge "$THRESHOLD" ]; then
    echo "[$TIMESTAMP] ALERT | error threshold exceeded: $ERROR_COUNT errors" >> "$LOG_FILE"
    
    # Send webhook if configured
    WEBHOOK_URL="${LOGGING_ALERT_WEBHOOK:-}"
    if [ -n "$WEBHOOK_URL" ]; then
        curl -s -X POST "$WEBHOOK_URL" \
            -H "Content-Type: application/json" \
            -d "{\"type\":\"error_threshold\",\"count\":$ERROR_COUNT,\"agent_id\":\"$AGENT_ID\",\"message\":\"$ERROR_MESSAGE\"}" \
            &>/dev/null || true
    fi
fi

exit 0
