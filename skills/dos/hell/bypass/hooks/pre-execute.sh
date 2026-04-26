#!/bin/bash
# HELL Bypass - Pre-Execute Hook
# Validações antes de cada task

set -e

TASK_ID="${1:-unknown}"
TASK_TYPE="${2:-unknown}"
TASK_DESC="${3:-no description}"

C_RESET='\033[0m'
C_BLUE='\033[0;34m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_RED='\033[0;31m'

info() { echo -e "${C_BLUE}[PRE-EXEC]${C_RESET} $1"; }
warn() { echo -e "${C_YELLOW}[PRE-EXEC]${C_RESET} $1"; }
error() { echo -e "${C_RED}[PRE-EXEC]${C_RESET} $1"; }

echo ""
echo "════════════════════════════════════════════════════════════════"
info "PRE-EXECUTE HOOK"
info "Task: $TASK_ID | Type: $TASK_TYPE"
echo "════════════════════════════════════════════════════════════════"

# 1. Validate git exists
if ! command -v git &> /dev/null; then
  error "git não encontrado no PATH"
  exit 1
fi

if [ ! -d ".git" ]; then
  warn "Não é um repositório git"
fi

# 2. Validate disk space
DISK_USAGE=$(df . | awk 'NR==2 {print $5+0}')
if [ "$DISK_USAGE" -gt 90 ]; then
  warn "⚠️  Uso de disco alto: ${DISK_USAGE}%"
  warn "Considere limpar antes de continuar"
fi

# 3. Validate memory (for large operations)
if command -v free &> /dev/null; then
  AVAILABLE_MEM=$(free -m 2>/dev/null | awk 'NR==2 {print $7}')
  if [ "${AVAILABLE_MEM:-0}" -lt 500 ]; then
    warn "⚠️  Memória disponível baixa: ${AVAILABLE_MEM}MB"
  fi
fi

# 4. Check for lock files (indicating running processes)
LOCK_FILES=$(find . -name "*.lock" -not -path "./node_modules/*" -not -path "./.git/*" 2>/dev/null | head -5)
if [ -n "$LOCK_FILES" ]; then
  warn "Lock files encontrados:"
  echo "$LOCK_FILES" | while read f; do
    echo "  - $f"
  done
fi

# 5. Validate tools for task type
case "$TASK_TYPE" in
  code|impl|implement)
    if ! command -v node &> /dev/null; then
      warn "Node.js não encontrado - algumas validações podem falhar"
    fi
    ;;
  test|e2e)
    if ! command -v npm &> /dev/null; then
      error "npm não encontrado - necessário para tests"
      exit 1
    fi
    ;;
  git|commit|branch)
    if ! git rev-parse --git-dir &> /dev/null; then
      error "Não está em um repositório git"
      exit 1
    fi
    ;;
esac

# 6. Validate CLAUDE.md exists for project context
if [ -f "CLAUDE.md" ]; then
  info "CLAUDE.md encontrado - contexto do projeto disponível"
fi

# 7. Log execution start
mkdir -p logs
echo "[$(date -Iseconds)] PRE-EXEC | Task: $TASK_ID | Type: $TASK_TYPE" >> logs/execution.log

info "✓ Pre-execute validation complete"
echo ""

exit 0
