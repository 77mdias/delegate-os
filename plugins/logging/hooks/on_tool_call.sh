#!/bin/bash
# Logging Plugin - on_tool_call hook
# Logs tool invocations

TOOL_NAME="${TOOL_NAME:-unknown}"
TOOL_ARGS="${TOOL_ARGS:-}"
TOOL_RESULT="${TOOL_RESULT:-}"
DURATION_MS="${DURATION_MS:-0}"
SUCCESS="${SUCCESS:-true}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

LOG_FILE="${LOG_DIR:-~/.delegado/logs}/agent.log"
ACTIVITY_LOG="${LOG_DIR:-~/.delegado/logs}/activity.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Truncate long args for logging
if [ ${#TOOL_ARGS} -gt 200 ]; then
    TOOL_ARGS="${TOOL_ARGS:0:200}..."
fi

if [ ${#TOOL_RESULT} -gt 200 ]; then
    TOOL_RESULT="${TOOL_RESULT:0:200}..."
fi

# Sanitize for logging (remove newlines, escape pipes)
TOOL_ARGS=$(echo "$TOOL_ARGS" | tr '\n' ' ' | sed 's/|/\\|/g')
TOOL_RESULT=$(echo "$TOOL_RESULT" | tr '\n' ' ' | sed 's/|/\\|/g')

if [ "$SUCCESS" = "true" ]; then
    echo "[$TIMESTAMP] DEBUG | tool.call | tool=$TOOL_NAME duration=${DURATION_MS}ms success=true" >> "$LOG_FILE"
    echo "[$TIMESTAMP] TOOL_CALL | $TOOL_NAME | ${DURATION_MS}ms | OK" >> "$ACTIVITY_LOG"
else
    echo "[$TIMESTAMP] WARN | tool.call | tool=$TOOL_NAME duration=${DURATION_MS}ms success=false" >> "$LOG_FILE"
    echo "[$TIMESTAMP] TOOL_FAIL | $TOOL_NAME | ${DURATION_MS}ms | $TOOL_RESULT" >> "$ACTIVITY_LOG"
fi

exit 0
