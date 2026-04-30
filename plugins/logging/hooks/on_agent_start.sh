#!/bin/bash
# Logging Plugin - on_agent_start hook
# Logs when an agent starts

AGENT_ID="${AGENT_ID:-unknown}"
AGENT_MODE="${AGENT_MODE:-default}"
AGENT_TYPE="${AGENT_TYPE:-cli}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

LOG_FILE="${LOG_DIR:-~/.delegado/logs}/agent.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Format: [timestamp] LEVEL | SOURCE | message
echo "[$TIMESTAMP] INFO | agent.start | agent_id=$AGENT_ID mode=$AGENT_MODE type=$AGENT_TYPE" >> "$LOG_FILE"

# Also write to activity log for summary tracking
ACTIVITY_LOG="${LOG_DIR:-~/.delegado/logs}/activity.log"
echo "[$TIMESTAMP] AGENT_START | $AGENT_ID | $AGENT_MODE" >> "$ACTIVITY_LOG"

# Emit structured event if delegated command available
if command -v delegado &>/dev/null; then
    delegado emit agent-start \
        --id "$AGENT_ID" \
        --mode "$AGENT_MODE" \
        --type "$AGENT_TYPE" \
        --timestamp "$TIMESTAMP" 2>/dev/null || true
fi

exit 0
