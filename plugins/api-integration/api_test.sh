#!/bin/bash
# API Testing Tool for Delegado OS
# Tests API endpoints with various configurations

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Default values
ENDPOINT=""
METHOD="GET"
EXPECTED_STATUS="200"
BODY=""
HEADERS="{}"
TIMEOUT="30"
VERBOSE=false

# Usage
usage() {
    cat << EOF
${GREEN}API Testing Tool for Delegado OS${NC}

Usage: $0 --endpoint <url> [options]

Required:
  --endpoint         API URL to test

Options:
  --method           HTTP method (GET, POST, PUT, DELETE, PATCH) [default: GET]
  --expected_status  Expected HTTP status code [default: 200]
  --body             Request body for POST/PUT/PATCH
  --headers          JSON headers object
  --timeout          Request timeout in seconds [default: 30]
  --verbose          Enable verbose output
  --help             Show this help message

Examples:
  $0 --endpoint https://api.example.com/health
  $0 --endpoint https://api.example.com/users --method POST --body '{"name":"test"}'
  $0 --endpoint https://api.example.com/users --headers '{"Authorization":"Bearer token"}'

EOF
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --endpoint)
            ENDPOINT="$2"
            shift 2
            ;;
        --method)
            METHOD="$2"
            shift 2
            ;;
        --expected_status)
            EXPECTED_STATUS="$2"
            shift 2
            ;;
        --body)
            BODY="$2"
            shift 2
            ;;
        --headers)
            HEADERS="$2"
            shift 2
            ;;
        --timeout)
            TIMEOUT="$2"
            shift 2
            ;;
        --verbose)
            VERBOSE=true
            shift
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
if [[ -z "$ENDPOINT" ]]; then
    echo -e "${RED}Error: --endpoint is required${NC}"
    usage
fi

# Build curl command
build_curl_command() {
    local cmd="curl -s -w '\n%{http_code}' -X $METHOD"
    
    # Add timeout
    cmd="$cmd --max-time $TIMEOUT"
    
    # Add headers
    if [[ "$HEADERS" != "{}" ]] && [[ -n "$HEADERS" ]]; then
        # Parse JSON headers and add each one
        local header_keys=$(echo "$HEADERS" | jq -r 'keys[]')
        for key in $header_keys; do
            local value=$(echo "$HEADERS" | jq -r ".[\"$key\"]")
            cmd="$cmd -H '$key: $value'"
        done
    fi
    
    # Add Content-Type for methods with body
    if [[ -n "$BODY" ]]; then
        cmd="$cmd -H 'Content-Type: application/json'"
        cmd="$cmd -d '$BODY'"
    fi
    
    # Add endpoint
    cmd="$cmd '$ENDPOINT'"
    
    echo "$cmd"
}

# Run the test
run_test() {
    local start_time=$(date +%s%3N)
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}   Delegado OS API Testing Tool${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    echo -e "${CYAN}[Test]${NC} Endpoint: $ENDPOINT"
    echo -e "${CYAN}[Test]${NC} Method: $METHOD"
    echo -e "${CYAN}[Test]${NC} Expected Status: $EXPECTED_STATUS"
    echo -e "${CYAN}[Test]${NC} Timeout: ${TIMEOUT}s"
    echo ""
    
    # Build curl command
    local curl_cmd=$(build_curl_command)
    
    if [[ "$VERBOSE" == true ]]; then
        echo -e "${YELLOW}[Verbose]${NC} Curl command:"
        echo "$curl_cmd"
        echo ""
    fi
    
    # Execute request
    echo -e "${YELLOW}[Test]${NC} Sending request..."
    
    # Capture response
    local response
    local http_code
    
    if [[ -n "$BODY" ]]; then
        # Parse headers JSON
        local header_args=()
        local header_keys=$(echo "$HEADERS" | jq -r 'keys[]' 2>/dev/null || echo "")
        for key in $header_keys; do
            local value=$(echo "$HEADERS" | jq -r ".[\"$key\"]" 2>/dev/null || echo "")
            if [[ -n "$value" ]]; then
                header_args+=("-H" "$key: $value")
            fi
        done
        
        response=$(curl -s -X "$METHOD" \
            "${header_args[@]}" \
            -H "Content-Type: application/json" \
            -d "$BODY" \
            --max-time "$TIMEOUT" \
            -w "\n%{http_code}" \
            "$ENDPOINT" 2>&1) || true
    else
        # Parse headers JSON
        local header_args=()
        local header_keys=$(echo "$HEADERS" | jq -r 'keys[]' 2>/dev/null || echo "")
        for key in $header_keys; do
            local value=$(echo "$HEADERS" | jq -r ".[\"$key\"]" 2>/dev/null || echo "")
            if [[ -n "$value" ]]; then
                header_args+=("-H" "$key: $value")
            fi
        done
        
        response=$(curl -s -X "$METHOD" \
            "${header_args[@]}" \
            --max-time "$TIMEOUT" \
            -w "\n%{http_code}" \
            "$ENDPOINT" 2>&1) || true
    fi
    
    # Parse response and status code
    local http_code=$(echo "$response" | tail -n1)
    local body=$(echo "$response" | sed '$d')
    
    local end_time=$(date +%s%3N)
    local duration=$((end_time - start_time))
    
    echo ""
    echo -e "${CYAN}[Result]${NC} HTTP Status: $http_code"
    echo -e "${CYAN}[Result]${NC} Response Time: ${duration}ms"
    echo ""
    
    # Pretty print JSON response if applicable
    if [[ -n "$body" ]]; then
        echo -e "${CYAN}[Response Body]${NC}"
        echo "$body" | jq '.' 2>/dev/null || echo "$body"
    fi
    
    echo ""
    
    # Validate response
    if [[ "$http_code" == "$EXPECTED_STATUS" ]]; then
        echo -e "${GREEN}✓ TEST PASSED${NC}"
        echo -e "${GREEN}  Expected: $EXPECTED_STATUS${NC}"
        echo -e "${GREEN}  Actual:   $http_code${NC}"
        
        # Log successful test
        mkdir -p "$HOME/.delegado/api_tests"
        local test_log="$HOME/.delegado/api_tests/$(date +%Y%m%d_%H%M%S)_test.json"
        echo '{}' | jq --arg endpoint "$ENDPOINT" \
                      --arg method "$METHOD" \
                      --arg status "$http_code" \
                      --arg expected "$EXPECTED_STATUS" \
                      --arg duration "${duration}ms" \
                      --arg body "$body" \
                      '{endpoint: $endpoint, method: $method, status: $status, expected: $expected, duration: $duration, passed: ($status == $expected), body: ($body | fromjson? // $body)}' > "$test_log"
        
        exit 0
    else
        echo -e "${RED}✗ TEST FAILED${NC}"
        echo -e "${RED}  Expected: $EXPECTED_STATUS${NC}"
        echo -e "${RED}  Actual:   $http_code${NC}"
        
        # Log failed test
        mkdir -p "$HOME/.delegado/api_tests"
        local test_log="$HOME/.delegado/api_tests/$(date +%Y%m%d_%H%M%S)_test.json"
        echo '{}' | jq --arg endpoint "$ENDPOINT" \
                      --arg method "$METHOD" \
                      --arg status "$http_code" \
                      --arg expected "$EXPECTED_STATUS" \
                      --arg duration "${duration}ms" \
                      '{endpoint: $endpoint, method: $method, status: $status, expected: $expected, duration: $duration, passed: false}' > "$test_log"
        
        exit 1
    fi
}

# Main execution
main() {
    run_test
}

main "$@"
