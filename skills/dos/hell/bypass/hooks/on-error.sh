#!/bin/bash
# HELL Bypass - On-Error Hook
# Captura erros e propõe recovery

set -e

ERROR_MSG="${1:-Unknown error}"
TASK_ID="${2:-unknown}"
COMMAND="${3:-unknown}"
STACK_TRACE="${4:-}"

C_RESET='\033[0m'
C_BOLD='\033[1m'
C_BLUE='\033[0;34m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_RED='\033[0;31m'

error() { echo -e "${C_RED}[ERROR-HOOK]${C_RESET} $1"; }
warn() { echo -e "${C_YELLOW}[ERROR-HOOK]${C_RESET} $1"; }
info() { echo -e "${C_BLUE}[ERROR-HOOK]${C_RESET} $1"; }

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  ${C_RED}⚠️  ON-ERROR HOOK - ERRO CAPTURADO${C_RESET}                         ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# 1. Log error
error "Mensagem: $ERROR_MSG"
error "Task: $TASK_ID"
error "Comando: $COMMAND"
echo ""

if [ -n "$STACK_TRACE" ]; then
  echo -e "${C_BOLD}Stack Trace:${C_RESET}"
  echo "$STACK_TRACE" | head -20
  echo ""
fi

# 2. Create error log
mkdir -p logs
ERROR_LOG="logs/error-$(date +%Y%m%d_%H%M%S).log"

{
  echo "=== HELL Bypass Error Log ==="
  echo "Timestamp: $(date -Iseconds)"
  echo "Task: $TASK_ID"
  echo "Command: $COMMAND"
  echo "Error: $ERROR_MSG"
  echo ""
  echo "Stack Trace:"
  echo "$STACK_TRACE"
  echo ""
  echo "Git Status:"
  git status 2>/dev/null || echo "N/A"
  echo ""
  echo "Recent Changes:"
  git diff --stat 2>/dev/null | head -20 || echo "N/A"
} > "$ERROR_LOG"

error "Erro logged to: $ERROR_LOG"

# 3. Check for checkpoint
CHECKPOINT_DIR=".claude/checkpoints"
if [ -d "$CHECKPOINT_DIR" ]; then
  LATEST=$(ls -t "$CHECKPOINT_DIR"/manifest_*.txt 2>/dev/null | head -1)
  if [ -n "$LATEST" ]; then
    CHECKPOINT_ID=$(basename "$LATEST" | sed 's/manifest_\([0-9]*\)\.txt/\1/')
    warn "Checkpoint disponível: $CHECKPOINT_ID"
  fi
fi

# 4. Recovery options
echo ""
echo -e "${C_BOLD}═══ RECOVERY OPTIONS ═══${C_RESET}"
echo ""
echo "  1) ${C_GREEN}Retry${C_RESET}    - Tentar comando novamente"
echo "  2) ${C_YELLOW}Skip${C_RESET}     - Pular esta task e continuar"
echo "  3) ${C_BLUE}Rollback${C_RESET}  - Restaurar último checkpoint"
echo "  4) ${C_RED}Abort${C_RESET}     - Abortar operação"
echo ""

# Auto-determine best recovery based on error type
case "$ERROR_MSG" in
  *"not found"*)
    warn "Tipo de erro: Command/dependency not found"
    warn "Sugestão: Instalar dependência ou verificar PATH"
    ;;
  *"permission denied"*)
    warn "Tipo de erro: Permission denied"
    warn "Sugestão: Verificar permissões de arquivo"
    ;;
  *"merge conflict"*)
    warn "Tipo de erro: Git merge conflict"
    warn "Sugestão: Resolver conflitos manualmente"
    ;;
  *"timeout"*)
    warn "Tipo de erro: Operation timeout"
    warn "Sugestão: Tentar novamente com mais tempo"
    ;;
  *"no such file"*)
    warn "Tipo de erro: File/directory not found"
    warn "Sugestão: Verificar caminho ou criar recurso"
    ;;
  *)
    info "Tipo de erro: Unknown/generic"
    ;;
esac

echo ""
info "Aguardando seleção do usuário..."

# Note: In actual Claude Code execution, this would be interactive
# For now, we just report the error and let the agent decide

exit 1
