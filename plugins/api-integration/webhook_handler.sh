#!/bin/bash
# Webhook Handler for Delegado OS
# Processes incoming webhooks from external services

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Default values
PROVIDER=""
EVENT=""
PAYLOAD_FILE=""
SIGNATURE=""
SECRET=""

# Usage
usage() {
    cat << EOF
${GREEN}Webhook Handler for Delegado OS${NC}

Usage: $0 --provider <provider> --event <event> [options]

Required:
  --provider      External service name (github, stripe, slack, etc.)
  --event         Event type to handle
  --payload_file  Path to JSON payload file

Options:
  --signature     Webhook signature for verification
  --secret        Secret for signature verification
  --help          Show this help message

Examples:
  $0 --provider github --event push --payload_file /tmp/webhook.json
  $0 --provider stripe --event payment_intent.succeeded --payload_file /tmp/event.json --signature \$STRIPE_SIGNATURE

EOF
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --provider)
            PROVIDER="$2"
            shift 2
            ;;
        --event)
            EVENT="$2"
            shift 2
            ;;
        --payload_file)
            PAYLOAD_FILE="$2"
            shift 2
            ;;
        --signature)
            SIGNATURE="$2"
            shift 2
            ;;
        --secret)
            SECRET="$2"
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

# Validate required arguments
if [[ -z "$PROVIDER" ]] || [[ -z "$EVENT" ]] || [[ -z "$PAYLOAD_FILE" ]]; then
    echo -e "${RED}Error: Missing required arguments${NC}"
    usage
fi

# Check payload file exists
if [[ ! -f "$PAYLOAD_FILE" ]]; then
    echo -e "${RED}Error: Payload file not found: $PAYLOAD_FILE${NC}"
    exit 1
fi

# Verify webhook signature
verify_signature() {
    local payload=$(cat "$PAYLOAD_FILE")
    local expected_signature
    
    case "$PROVIDER" in
        github)
            if [[ -n "$SECRET" ]]; then
                expected_signature=$(echo -n "$payload" | openssl dgst -sha256 -hmac "$SECRET" | cut -d' ' -f2)
                if [[ "sha256=$expected_signature" != "$SIGNATURE" ]]; then
                    echo -e "${RED}Error: Invalid GitHub webhook signature${NC}"
                    return 1
                fi
            fi
            ;;
        stripe)
            if [[ -n "$SECRET" ]]; then
                expected_signature=$(echo -n "$payload" | openssl dgst -sha256 -hmac "$SECRET" | cut -d' ' -f2)
                if [[ "sha256=$expected_signature" != "$SIGNATURE" ]]; then
                    echo -e "${RED}Error: Invalid Stripe webhook signature${NC}"
                    return 1
                fi
            fi
            ;;
        slack)
            # Slack uses a challenge verification
            if [[ "$EVENT" == "url_verification" ]]; then
                local challenge=$(echo "$payload" | jq -r '.challenge // empty')
                if [[ -n "$challenge" ]]; then
                    echo "{\"challenge\": \"$challenge\"}"
                    exit 0
                fi
            fi
            ;;
    esac
    return 0
}

# Process webhook based on provider and event
process_webhook() {
    local payload=$(cat "$PAYLOAD_FILE")
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    echo -e "${BLUE}[Webhook Handler]${NC} Processing $PROVIDER event: $EVENT"
    echo -e "${BLUE}[Webhook Handler]${NC} Timestamp: $timestamp"
    
    # Create events directory if it doesn't exist
    mkdir -p "$HOME/.delegado/events"
    local event_log="$HOME/.delegado/events/$(date +%Y%m%d_%H%M%S)_${PROVIDER}_${EVENT}.json"
    
    # Log the event
    echo "$payload" | jq --arg provider "$PROVIDER" \
                        --arg event "$EVENT" \
                        --arg timestamp "$timestamp" \
                        '{provider: $provider, event: $event, timestamp: $timestamp, payload: .}' > "$event_log"
    
    echo -e "${GREEN}[Webhook Handler]${NC} Event logged to: $event_log"
    
    # Route based on provider and event
    case "$PROVIDER" in
        github)
            handle_github_event "$payload"
            ;;
        stripe)
            handle_stripe_event "$payload"
            ;;
        slack)
            handle_slack_event "$payload"
            ;;
        *)
            echo -e "${YELLOW}[Webhook Handler]${NC} No specific handler for $PROVIDER, using generic processing"
            handle_generic_event "$payload"
            ;;
    esac
}

# GitHub event handler
handle_github_event() {
    local payload="$1"
    echo -e "${GREEN}[GitHub]${NC} Processing GitHub event: $EVENT"
    
    case "$EVENT" in
        push)
            local branch=$(echo "$payload" | jq -r '.ref // "unknown"')
            local commits=$(echo "$payload" | jq -r '.commits | length')
            echo -e "${GREEN}[GitHub Push]${NC} Branch: $branch, Commits: $commits"
            ;;
        pull_request)
            local action=$(echo "$payload" | jq -r '.action // "unknown"')
            local pr_number=$(echo "$payload" | jq -r '.pull_request.number // 0')
            echo -e "${GREEN}[GitHub PR]${NC} Action: $action, PR #$pr_number"
            ;;
        issues)
            local action=$(echo "$payload" | jq -r '.action // "unknown"')
            local issue_title=$(echo "$payload" | jq -r '.issue.title // "unknown"')
            echo -e "${GREEN}[GitHub Issue]${NC} Action: $action, Title: $issue_title"
            ;;
        *)
            echo -e "${YELLOW}[GitHub]${NC} Unhandled event type: $EVENT"
            ;;
    esac
}

# Stripe event handler
handle_stripe_event() {
    local payload="$1"
    echo -e "${GREEN}[Stripe]${NC} Processing Stripe event: $EVENT"
    
    case "$EVENT" in
        payment_intent.succeeded)
            local amount=$(echo "$payload" | jq -r '.data.object.amount // 0')
            local currency=$(echo "$payload" | jq -r '.data.object.currency // "usd"')
            echo -e "${GREEN}[Stripe Payment]${NC} Amount: $((amount/100)) $currency"
            ;;
        customer.created)
            local customer_id=$(echo "$payload" | jq -r '.data.object.id // "unknown"')
            echo -e "${GREEN}[Stripe Customer]${NC} Created: $customer_id"
            ;;
        subscription.created)
            local sub_id=$(echo "$payload" | jq -r '.data.object.id // "unknown"')
            echo -e "${GREEN}[Stripe Subscription]${NC} Created: $sub_id"
            ;;
        *)
            echo -e "${YELLOW}[Stripe]${NC} Unhandled event type: $EVENT"
            ;;
    esac
}

# Slack event handler
handle_slack_event() {
    local payload="$1"
    echo -e "${GREEN}[Slack]${NC} Processing Slack event: $EVENT"
    
    case "$EVENT" in
        message)
            local channel=$(echo "$payload" | jq -r '.event.channel // "unknown"')
            local user=$(echo "$payload" | jq -r '.event.user // "unknown"')
            local text=$(echo "$payload" | jq -r '.event.text // ""')
            echo -e "${GREEN}[Slack Message]${NC} Channel: $channel, User: $user, Text: $text"
            ;;
        reaction_added)
            local item=$(echo "$payload" | jq -r '.event.item.channel // "unknown"')
            local reaction=$(echo "$payload" | jq -r '.event.reaction // "unknown"')
            echo -e "${GREEN}[Slack Reaction]${NC} Channel: $item, Reaction: :$reaction:"
            ;;
        *)
            echo -e "${YELLOW}[Slack]${NC} Unhandled event type: $EVENT"
            ;;
    esac
}

# Generic event handler
handle_generic_event() {
    local payload="$1"
    echo -e "${YELLOW}[Generic]${NC} Processing generic webhook"
    echo "$payload" | jq '.'
}

# Main execution
main() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}   Delegado OS Webhook Handler${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    # Verify signature if provided
    if [[ -n "$SIGNATURE" ]] && [[ -n "$SECRET" ]]; then
        echo -e "${YELLOW}[Webhook Handler]${NC} Verifying webhook signature..."
        if ! verify_signature; then
            exit 2
        fi
        echo -e "${GREEN}[Webhook Handler]${NC} Signature verified"
        echo ""
    fi
    
    # Process the webhook
    process_webhook
    
    echo ""
    echo -e "${GREEN}Webhook handling complete!${NC}"
}

main "$@"
