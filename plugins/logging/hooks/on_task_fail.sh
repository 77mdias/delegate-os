#!/bin/bash
# Logging Plugin - on_task_fail hook
# Logs when a task fails

TASK_ID="${TASK_ID:-unknown}"
TASK_NAME="${TASK_NAME:-unnamed}"
ERROR_MESSAGE="${ERROR_MESSAGE:-Unknown error}"
DURATION_MS="${DURATION_MS:-0}"
AGENT_ID="${AGENT_ID:-unknown}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

LOG_FILE="${LOG_DIR:-~/.delegado/logs}/agent.log"
ERROR_LOG="${LOG_DIR:-~/.delegado/logs}/error.log"
ACTIVITY_LOG="${LOG_DIR:-~/.delegado/logs}/activity.log"
mkdir -p "$(dirname "$LOG_FILE")"

echo "[$TIMESTAMP] ERROR | task.fail | task_id=$TASK_ID name=$TASK_NAME error=$ERROR_MESSAGE agent=$AGENT_ID duration=${DURATION_MS}ms" >> "$LOG_FILE"

{
    echo "[$TIMESTAMP] TASK_FAIL | $TASK_ID | $TASK_NAME"
    echo "  Error: $ERROR_MESSAGE"
    echo "  Duration: ${DURATION_MS}ms"
    echo "---"
} >> "$ERROR_LOG"

echo "[$TIMESTAMP] TASK_FAIL | $TASK_ID | $TASK_NAME | $ERROR_MESSAGE" >> "$ACTIVITY_LOG"

exit 0
