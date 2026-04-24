#!/bin/bash
# AI Integration Plugin - on_model_switch hook
# Called when switching LLM models or providers

FROM_PROVIDER="${FROM_PROVIDER:-unknown}"
TO_PROVIDER="${TO_PROVIDER:-unknown}"
REASON="${REASON:-unspecified}"
FROM_MODEL="${FROM_MODEL:-unknown}"
TO_MODEL="${TO_MODEL:-unknown}"

# Log the switch
LOG_FILE="${DELEGADO_LOG_DIR:-~/.delegado/logs}/model-switches.log"
mkdir -p "$(dirname "$LOG_FILE")"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] SWITCH | from=${FROM_PROVIDER}/${FROM_MODEL} | to=${TO_PROVIDER}/${TO_MODEL} | reason=$REASON" >> "$LOG_FILE"

# Emit event for alerting if configured
if [ "${AI_INTEGRATION_ALERT_ON_SWITCH:-false}" = "true" ]; then
    echo "ALERT: Model switch from ${FROM_PROVIDER} to ${TO_PROVIDER} - $REASON" >&2
fi

exit 0
