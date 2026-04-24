#!/bin/bash
# AI Integration Plugin - on_llm_request hook
# Called before each LLM API request

PROVIDER="${PROVIDER:-openai}"
MODEL="${MODEL:-gpt-4o}"
PROMPT_LENGTH="${PROMPT_LENGTH:-0}"

# Log the request
LOG_FILE="${DELEGADO_LOG_DIR:-~/.delegado/logs}/ai-requests.log"
mkdir -p "$(dirname "$LOG_FILE")"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] REQUEST | provider=$PROVIDER | model=$MODEL | prompt_chars=$PROMPT_LENGTH" >> "$LOG_FILE"

# Emit event for monitoring
if command -v delegado &>/dev/null; then
    delegado emit llm-request --provider "$PROVIDER" --model "$MODEL" --prompt-length "$PROMPT_LENGTH" 2>/dev/null || true
fi

# Provider-specific setup
case "$PROVIDER" in
    openai)
        # Check API key
        if [ -z "${OPENAI_API_KEY:-}" ]; then
            echo "WARNING: OPENAI_API_KEY not set" >&2
        fi
        ;;
    anthropic)
        if [ -z "${ANTHROPIC_API_KEY:-}" ]; then
            echo "WARNING: ANTHROPIC_API_KEY not set" >&2
        fi
        ;;
    ollama)
        # Verify Ollama is running
        if ! curl -s http://localhost:11434/api/tags &>/dev/null; then
            echo "WARNING: Ollama server not running at localhost:11434" >&2
        fi
        ;;
    lmstudio)
        # Verify LM Studio is running
        if ! curl -s http://localhost:1234/v1/models &>/dev/null; then
            echo "WARNING: LM Studio server not running at localhost:1234" >&2
        fi
        ;;
esac

exit 0
