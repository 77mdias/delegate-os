#!/bin/bash
# Monitoring Plugin - Session Start Hook
# Tracks when a new session begins

set -e

DELEGADO_HOME="${DELEGADO_HOME:-/root/projects/delegate-os}"
METRICS_DIR="$DELEGADO_HOME/.delegado/metrics"
SESSION_ID="${1:-$(date +%s)}"

mkdir -p "$METRICS_DIR/sessions"

SESSION_START="$METRICS_DIR/sessions/$SESSION_ID.start"
cat > "$SESSION_START" << EOF
{
  "session_id": "$SESSION_ID",
  "started": "$(date -Iseconds)",
  "mode": "${MODE:-unknown}",
  "user": "${USER:-unknown}"
}
EOF

echo "[monitoring] Session $SESSION_ID started"
