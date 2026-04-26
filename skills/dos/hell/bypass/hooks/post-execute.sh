#!/bin/bash
# HELL Bypass - Post-Execute Hook
# Cleanup e logging após cada task

set -e

EXIT_CODE="${1:-0}"
TASK_ID="${2:-unknown}"
TASK_TYPE="${3:-unknown}"
DURATION="${4:-unknown}"

C_RESET='\033[0m'
C_BLUE='\033[0;34m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_RED='\033[0;31m'

info() { echo -e "${C_BLUE}[POST-EXEC]${C_RESET} $1"; }
success() { echo -e "${C_GREEN}[POST-EXEC]${C_RESET} $1"; }
warn() { echo -e "${C_YELLOW}[POST-EXEC]${C_RESET} $1"; }
error() { echo -e "${C_RED}[POST-EXEC]${C_RESET} $1"; }

echo ""
echo "════════════════════════════════════════════════════════════════"
info "POST-EXECUTE HOOK"
info "Task: $TASK_ID | Exit: $EXIT_CODE | Duration: ${DURATION}s"
echo "════════════════════════════════════════════════════════════════"

# 1. Log completion
mkdir -p logs
{
  echo "[$(date -Iseconds)] POST-EXEC | Task: $TASK_ID | Exit: $EXIT_CODE | Duration: ${DURATION}s"
} >> logs/execution.log

# 2. Cleanup temp files
TEMP_FILES=$(find . -maxdepth 1 -name "*.tmp" -o -name "*.temp" -o -name "*~" 2>/dev/null | head -10)
if [ -n "$TEMP_FILES" ]; then
  info "Limpando arquivos temporários..."
  echo "$TEMP_FILES" | while read f; do
    rm -f "$f" 2>/dev/null && echo "  Removed: $f" || true
  done
fi

# 3. Check for uncommitted changes in docs
if [ -d "docs" ] && git rev-parse --git-dir &> /dev/null; then
  DOCS_CHANGES=$(git status --porcelain docs/ 2>/dev/null | wc -l)
  if [ "$DOCS_CHANGES" -gt 0 ]; then
    warn "⚠️  $DOCS_CHANGES alteração(ões) não commitada(s) em docs/"
  fi
fi

# 4. Update active context if exists
if [ -f "skills/dos/hell/bypass/memory/active-context.md" ]; then
  # Check if task completed successfully
  if [ "$EXIT_CODE" -eq 0 ]; then
    # Could update memory here
    info "Task completada com sucesso"
  else
    warn "Task falhou com código $EXIT_CODE"
  fi
fi

# 5. Report final status
echo ""
if [ "$EXIT_CODE" -eq 0 ]; then
  success "✓ Task $TASK_ID completada com sucesso (${DURATION}s)"
else
  error "✗ Task $TASK_ID falhou (código: $EXIT_CODE)"
fi

echo ""

exit 0
