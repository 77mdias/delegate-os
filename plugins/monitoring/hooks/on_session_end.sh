#!/bin/bash
# Monitoring Plugin - Session End Hook
# Computes and stores session metrics

set -e

DELEGADO_HOME="${DELEGADO_HOME:-/root/projects/delegate-os}"
METRICS_DIR="$DELEGADO_HOME/.delegado/metrics"
SESSION_ID="${1:-$(date +%s)}"

mkdir -p "$METRICS_DIR/sessions"

# Mark session end
if [ -f "$METRICS_DIR/sessions/$SESSION_ID.start" ]; then
    cat > "$METRICS_DIR/sessions/$SESSION_ID.end" << EOF
{
  "session_id": "$SESSION_ID",
  "ended": "$(date -Iseconds)",
  "mode": "${MODE:-unknown}",
  "tasks_completed": "${TASKS_COMPLETED:-0}",
  "errors": "${ERRORS:-0}"
}
EOF
    
    # Aggregate mode usage
    MODE_NAME="${MODE:-unknown}"
    MODE_COUNT_FILE="$METRICS_DIR/mode_usage_$(date +%Y%m).json"
    echo "[monitoring] Session $SESSION_ID ended"
fi

# Cleanup old metrics (retention)
find "$METRICS_DIR/sessions" -name "*.start" -mtime +30 -delete 2>/dev/null || true
find "$METRICS_DIR/sessions" -name "*.end" -mtime +30 -delete 2>/dev/null || true
