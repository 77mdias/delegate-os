#!/bin/bash
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# mode_selector.sh — Automatic Mode Selection
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

MODES=("PROFESSOR" "ARCHITECT" "DEBUGGER" "GUARDIAN" "RESEARCHER" "MENTOR" "CONSULTANT")

show_modes() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}🎛️  AVAILABLE MODES${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    for mode in "${MODES[@]}"; do
        echo -e "  ${GREEN}►${NC} ${mode}"
    done
    echo ""
}

detect_mode() {
    local input="$1"
    local input_lower=$(echo "$input" | tr '[:upper:]' '[:lower:]')
    
    # PROFESSOR detection
    if echo "$input_lower" | grep -qE "(ensinar|aprender|tutorial|como funciona|explicar|documentar|estudo|conceito|fundamentos)"; then
        echo "PROFESSOR"
        return
    fi
    
    # ARCHITECT detection
    if echo "$input_lower" | grep -qE "(arquitetura|pattern|design|grasp|gof|estrutura|escalabilidade|sistema|design)"; then
        echo "ARCHITECT"
        return
    fi
    
    # DEBUGGER detection
    if echo "$input_lower" | grep -qE "(bug|erro|falha|crash|não funciona|debug|exception|stack trace|problema)"; then
        echo "DEBUGGER"
        return
    fi
    
    # GUARDIAN detection
    if echo "$input_lower" | grep -qE "(segurança|vulnerabilidade|security|auth|permission|inject|xss|csrf|oauth|jwt|https|owasp)"; then
        echo "GUARDIAN"
        return
    fi
    
    # RESEARCHER detection
    if echo "$input_lower" | grep -qE "(biblioteca|library|package|widget|component|sdk|framework|comparar|qual usar|alternativa)"; then
        echo "RESEARCHER"
        return
    fi
    
    # MENTOR detection
    if echo "$input_lower" | grep -qE "(carreira|crescer|sênior|junior|promoção|entrevista|skills|roadmap|como chegar)"; then
        echo "MENTOR"
        return
    fi
    
    # CONSULTANT detection
    if echo "$input_lower" | grep -qE "(consultar|opinião|sugestão|melhor prática|revisar|validar|decisão|prós e contras)"; then
        echo "CONSULTANT"
        return
    fi
    
    echo "UNKNOWN"
}

usage() {
    cat <<EOF
${CYAN}mode_selector.sh${NC} — Automatic Mode Selection

${GREEN}USAGE:${NC}
    mode_selector.sh <input> [--list-modes]
    echo "input text" | mode_selector.sh

${GREEN}OPTIONS:${NC}
    --list-modes     Show all available modes
    --help           Show this help

${GREEN}EXAMPLES:${NC}
    mode_selector.sh "Me ensina TDD"
    mode_selector.sh "bug no login"
    mode_selector.sh --list-modes
    echo "melhor biblioteca react" | mode_selector.sh
EOF
}

if [[ "$1" == "--list-modes" ]]; then
    show_modes
    exit 0
fi

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    usage
    exit 0
fi

# Read from stdin if available
INPUT=""
if [[ -t 0 ]]; then
    # No stdin, use argument
    INPUT="$1"
else
    # Read from stdin
    INPUT=$(cat)
fi

if [[ -z "$INPUT" ]]; then
    echo -e "${RED}Error: No input provided${NC}"
    usage
    exit 1
fi

MODE=$(detect_mode "$INPUT")

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}🎯 MODE DETECTION RESULT${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}Input:${NC} $INPUT"
echo -e "  ${GREEN}Detected Mode:${NC} $MODE"
echo ""

case "$MODE" in
    PROFESSOR)
        echo -e "  ${BLUE}📚 Professor Mode Activated${NC}"
        echo -e "  ${BLUE}   Use: /delegado professor [topic]${NC}"
        ;;
    ARCHITECT)
        echo -e "  ${BLUE}🏛️  Architect Mode Activated${NC}"
        echo -e "  ${BLUE}   Use: /delegado architect [module]${NC}"
        ;;
    DEBUGGER)
        echo -e "  ${BLUE}🐛 Debugger Mode Activated${NC}"
        echo -e "  ${BLUE}   Use: /delegado debugger analyze [issue]${NC}"
        ;;
    GUARDIAN)
        echo -e "  ${BLUE}🛡️  Guardian Mode Activated${NC}"
        echo -e "  ${BLUE}   Use: /delegado guardian audit [scope]${NC}"
        ;;
    RESEARCHER)
        echo -e "  ${BLUE}📡 Researcher Mode Activated${NC}"
        echo -e "  ${BLUE}   Use: /delegado researcher compare [A vs B]${NC}"
        ;;
    MENTOR)
        echo -e "  ${BLUE}🌱 Mentor Mode Activated${NC}"
        echo -e "  ${BLUE}   Use: /delegado mentor path [goal]${NC}"
        ;;
    CONSULTANT)
        echo -e "  ${BLUE}💼 Consultant Mode Activated${NC}"
        echo -e "  ${BLUE}   Use: /delegado consultant advise [situation]${NC}"
        ;;
    *)
        echo -e "  ${YELLOW}⚠️  No specific mode detected${NC}"
        echo -e "  ${YELLOW}   Use: /delegado to see all commands${NC}"
        ;;
esac

echo ""
