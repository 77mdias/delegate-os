#!/bin/bash
# Logging Plugin - on_agent_end hook
# Logs when an agent ends

AGENT_ID="${AGENT_ID:-unknown}"
EXIT_STATUS="${EXIT_STATUS:-0}"
DURATION_MS="${DURATION_MS:-0}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

LOG_FILE="${LOG_DIR:-~/.delegado/logs}/agent.log"
ACTIVITY_LOG="${LOG_DIR:-~/.delegado/logs}/activity.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Calculate duration string
if [ "$DURATION_MS" -gt 0 ]; then
    if [ "$DURATION_MS" -gt 60000 ]; then
        DURATION_STR="$((DURATION_MS / 60000))m $(((DURATION_MS % 60000) / 1000))s"
    else
        DURATION_STR="${DURATION_MS}ms"
    fi
else
    DURATION_STR="unknown"
fi

# Determine status string
if [ "$EXIT_STATUS" -eq 0 ]; then
    STATUS_STR="success"
    LEVEL="INFO"
else
    STATUS_STR="failed"
    LEVEL="INFO"
fi

echo "[$TIMESTAMP] $LEVEL | agent.end | agent_id=$AGENT_ID status=$STATUS_STR duration=$DURATION_STR exit=$EXIT_STATUS" >> "$LOG_FILE"
echo "[$TIMESTAMP] AGENT_END | $AGENT_ID | $STATUS_STR | $DURATION_STR" >> "$ACTIVITY_LOG"

exit 0
