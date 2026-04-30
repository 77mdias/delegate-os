#!/bin/bash
# AI Integration Plugin - on_llm_response hook
# Called after each LLM API response

PROVIDER="${PROVIDER:-openai}"
MODEL="${MODEL:-gpt-4o}"
LATENCY_MS="${LATENCY_MS:-0}"
TOKENS_USED="${TOKENS_USED:-0}"
STATUS="${STATUS:-success}"

# Log the response
LOG_FILE="${DELEGADO_LOG_DIR:-~/.delegado/logs}/ai-responses.log"
mkdir -p "$(dirname "$LOG_FILE")"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] RESPONSE | provider=$PROVIDER | model=$MODEL | latency=${LATENCY_MS}ms | tokens=$TOKENS_USED | status=$STATUS" >> "$LOG_FILE"

# Track usage costs (approximate)
case "$PROVIDER" in
    openai)
        # GPT-4o: $2.50/1M input, $10/1M output
        if [ "$TOKENS_USED" -gt 0 ]; then
            COST_APPROX=$(echo "scale=6; $TOKENS_USED * 0.000005" | bc 2>/dev/null || echo "0.000")
            echo "[$TIMESTAMP] COST | provider=$PROVIDER | cost=$$COST_APPROX" >> "$LOG_FILE"
        fi
        ;;
    anthropic)
        # Claude 3.5 Sonnet: $3/1M input, $15/1M output
        if [ "$TOKENS_USED" -gt 0 ]; then
            COST_APPROX=$(echo "scale=6; $TOKENS_USED * 0.000018" | bc 2>/dev/null || echo "0.000")
            echo "[$TIMESTAMP] COST | provider=$PROVIDER | cost=$$COST_APPROX" >> "$LOG_FILE"
        fi
        ;;
esac

exit 0
