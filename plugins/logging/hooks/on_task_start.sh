#!/bin/bash
# Logging Plugin - on_task_start hook
# Logs when a task starts

TASK_ID="${TASK_ID:-unknown}"
TASK_NAME="${TASK_NAME:-unnamed}"
TASK_TYPE="${TASK_TYPE:-general}"
AGENT_ID="${AGENT_ID:-unknown}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

LOG_FILE="${LOG_DIR:-~/.delegado/logs}/agent.log"
ACTIVITY_LOG="${LOG_DIR:-~/.delegado/logs}/activity.log"
mkdir -p "$(dirname "$LOG_FILE")"

echo "[$TIMESTAMP] INFO | task.start | task_id=$TASK_ID name=$TASK_NAME type=$TASK_TYPE agent=$AGENT_ID" >> "$LOG_FILE"
echo "[$TIMESTAMP] TASK_START | $TASK_ID | $TASK_NAME | $TASK_TYPE" >> "$ACTIVITY_LOG"

exit 0
