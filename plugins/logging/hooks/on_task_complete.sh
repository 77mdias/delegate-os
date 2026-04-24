#!/bin/bash
# Logging Plugin - on_task_complete hook
# Logs when a task completes successfully

TASK_ID="${TASK_ID:-unknown}"
TASK_NAME="${TASK_NAME:-unnamed}"
DURATION_MS="${DURATION_MS:-0}"
RESULT="${RESULT:-}"
AGENT_ID="${AGENT_ID:-unknown}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

LOG_FILE="${LOG_DIR:-~/.delegado/logs}/agent.log"
ACTIVITY_LOG="${LOG_DIR:-~/.delegado/logs}/activity.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Calculate human-readable duration
if [ "$DURATION_MS" -gt 60000 ]; then
    DURATION_STR="$((DURATION_MS / 60000))m $(((DURATION_MS % 60000) / 1000))s"
elif [ "$DURATION_MS" -gt 0 ]; then
    DURATION_STR="${DURATION_MS}ms"
else
    DURATION_STR="unknown"
fi

# Truncate result if too long
if [ ${#RESULT} -gt 200 ]; then
    RESULT="${RESULT:0:200}..."
fi

echo "[$TIMESTAMP] INFO | task.complete | task_id=$TASK_ID name=$TASK_NAME duration=$DURATION_STR agent=$AGENT_ID" >> "$LOG_FILE"
echo "[$TIMESTAMP] TASK_COMPLETE | $TASK_ID | $TASK_NAME | $DURATION_STR" >> "$ACTIVITY_LOG"

exit 0
