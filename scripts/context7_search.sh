#!/bin/bash
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# context7_search.sh — Context7 Documentation Search Integration
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check for API key
if [[ -z "$CONTEXT7_API_KEY" ]]; then
    # Try to load from config
    if [[ -f "$HOME/.delegado/config" ]]; then
        source "$HOME/.delegado/config"
    fi
fi

# Usage
usage() {
    cat <<EOF
${CYAN}context7_search.sh${NC} — Search Context7 documentation

${GREEN}USAGE:${NC}
    context7_search.sh <query> [--lang=<language>] [--limit=<n>]

${GREEN}OPTIONS:${NC}
    query          Search query (required)
    --lang         Programming language (flutter, react, python, etc)
    --limit        Max results (default: 5)
    --help         Show this help

${GREEN}EXAMPLES:${NC}
    context7_search.sh "flutter state management riverpod"
    context7_search.sh "react authentication best practices" --lang=react
    context7_search.sh "fastapi database async" --lang=python --limit=10

${GREEN}ENVIRONMENT:${NC}
    CONTEXT7_API_KEY    Your Context7 API key
EOF
    exit 1
}

# Parse arguments
QUERY=""
LANGUAGE=""
LIMIT=5

while [[ $# -gt 0 ]]; do
    case $1 in
        --lang=*)
            LANGUAGE="${1#*=}"
            shift
            ;;
        --limit=*)
            LIMIT="${1#*=}"
            shift
            ;;
        --help|-h)
            usage
            ;;
        -*)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
        *)
            QUERY="$1"
            shift
            ;;
    esac
done

if [[ -z "$QUERY" ]]; then
    echo -e "${RED}Error: Query is required${NC}"
    usage
fi

# Detect language if not provided
if [[ -z "$LANGUAGE" ]]; then
    case "$QUERY" in
        *flutter*|*dart*)
            LANGUAGE="flutter"
            ;;
        *react*|*nextjs*|*jsx*)
            LANGUAGE="react"
            ;;
        *python*|*fastapi*|*django*|*flask*)
            LANGUAGE="python"
            ;;
        *typescript*|*ts*)
            LANGUAGE="typescript"
            ;;
        *node*|*express*|*npm*)
            LANGUAGE="node"
            ;;
        *go*|*golang*)
            LANGUAGE="go"
            ;;
        *rust*)
            LANGUAGE="rust"
            ;;
        *java*|*spring*)
            LANGUAGE="java"
            ;;
        *kotlin*|*android*)
            LANGUAGE="kotlin"
            ;;
        *)
            LANGUAGE="general"
            ;;
    esac
fi

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}🔍 Context7 Search${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}Query:${NC} $QUERY"
echo -e "${YELLOW}Language:${NC} $LANGUAGE"
echo -e "${YELLOW}Limit:${NC} $LIMIT"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Build search URL
ENCODED_QUERY=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$QUERY'))")
URL="https://api.context7.io/v1/search?q=${ENCODED_QUERY}&lang=${LANGUAGE}&limit=${LIMIT}"

# Make request
if [[ -n "$CONTEXT7_API_KEY" ]]; then
    RESPONSE=$(curl -s -H "Authorization: Bearer $CONTEXT7_API_KEY" "$URL")
else
    echo -e "${YELLOW}⚠️  No Context7 API key — using mock response${NC}"
    echo -e "${YELLOW}   Set CONTEXT7_API_KEY in ~/.delegado/config for real results${NC}"
    echo ""
    
    # Mock response for demo
    cat <<MOCK
${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
${GREEN}📚 RESULTS (Demo Mode)${NC}
${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}

Based on your query about "${QUERY}", here are relevant resources:

1. ${CYAN}Official Documentation${NC}
   ${BLUE}https://docs.example.com/${QUERY// /-}${NC}
   Relevance: 95%

2. ${CYAN}Community Guide${NC}
   ${BLUE}https://guide.example.com/${QUERY// /-}${NC}
   Relevance: 87%

3. ${CYAN}Best Practices Article${NC}
   ${BLUE}https://blog.example.com/${QUERY// /-}-best-practices${NC}
   Relevance: 82%

4. ${CYAN}Stack Overflow Discussion${NC}
   ${BLUE}https://stackoverflow.com/questions/tagged/${QUERY// /+}${NC}
   Relevance: 78%

5. ${CYAN}Video Tutorial${NC}
   ${BLUE}https://youtube.com/results?search_query=${ENCODED_QUERY}${NC}
   Relevance: 75%

${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
${YELLOW}💡 To get real results, set CONTEXT7_API_KEY${NC}
${YELLOW}   Export: export CONTEXT7_API_KEY="your-key-here"${NC}
${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
MOCK
    exit 0
fi

# Parse and display real response
if command -v jq &> /dev/null; then
    echo "$RESPONSE" | jq -r '
        if .results then
            .results[] | 
            "- **\(.title)**\n  \(.url)\n  Relevance: \(.relevance // "N/A")%\n"
        else
            "No results found"
        end
    '
else
    # Fallback without jq
    echo "$RESPONSE"
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
