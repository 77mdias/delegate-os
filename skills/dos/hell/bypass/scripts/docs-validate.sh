#!/bin/bash
# HELL Bypass - Docs Validate Script
# Valida consistência de documentação

set -e

C_RESET='\033[0m'
C_BOLD='\033[1m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_RED='\033[0;31m'
C_BLUE='\033[0;34m'

ERRORS=0
WARNINGS=0

info() { echo -e "${C_BLUE}[VALIDATE]${C_RESET} $1"; }
success() { echo -e "${C_GREEN}[✓]${C_RESET} $1"; }
warn() { echo -e "${C_YELLOW}[⚠]${C_RESET} $1"; WARNINGS=$((WARNINGS+1)); }
error() { echo -e "${C_RED}[✗]${C_RESET} $1"; ERRORS=$((ERRORS+1)); }

echo ""
echo "════════════════════════════════════════════════════════════════"
echo -e "${C_BOLD}  📋 HELL Bypass - Validação de Documentação v2.0${C_RESET}"
echo "════════════════════════════════════════════════════════════════"
echo ""

# 1. Check required directories
info "Verificando estrutura de diretórios..."

REQUIRED_DIRS=(
  "docs"
  "docs/development"
  "skills"
)

for dir in "${REQUIRED_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    success "📁 $dir/ existe"
  else
    error "📁 $dir/ não existe — ESTRUTURA INCOMPLETA"
  fi
done

# 2. Check development structure
if [ -d "docs/development" ]; then
  info "Verificando docs/development..."

  for subdir in PHASES TASKS SPECS GAPS SPRINTS PROPOSALS; do
    if [ -d "docs/development/$subdir" ]; then
      success "📁 docs/development/$subdir/"
    else
      warn "📁 docs/development/$subdir/ não existe (pode ser necessário)"
    fi
  done
fi

# 3. Check README.md
echo ""
info "Verificando README principal..."

if [ -f "README.md" ]; then
  success "README.md existe"

  # Check for key sections
  grep -q "##" README.md && success "  ✓ Tem seções" || warn "  ✗ Sem seções detectadas"
else
  error "README.md não encontrado"
fi

# 4. Check CLAUDE.md
echo ""
info "Verificando CLAUDE.md..."

if [ -f "CLAUDE.md" ]; then
  success "CLAUDE.md existe"

  # Check for key instructions
  grep -q "commands\|Commands" CLAUDE.md && success "  ✓ Tem comandos" || warn "  ✗ Sem comandos"
  grep -q "structure\|Structure" CLAUDE.md && success "  ✓ Tem estrutura" || warn "  ✗ Sem estrutura"
else
  warn "CLAUDE.md não encontrado (recomendado para projetos)"
fi

# 5. Check skills structure
echo ""
info "Verificando estrutura de skills..."

SKILL_COUNT=$(find skills -name "SKILL.md" 2>/dev/null | wc -l)
if [ "$SKILL_COUNT" -gt 0 ]; then
  success "Skills encontradas: $SKILL_COUNT"
else
  error "Nenhuma skill encontrada"
fi

# 6. Check phase boards
echo ""
info "Verificando PHASE boards..."

if [ -d "docs/development/PHASES" ]; then
  PHASE_COUNT=$(find docs/development/PHASES -name "phase-board.md" 2>/dev/null | wc -l)
  if [ "$PHASE_COUNT" -gt 0 ]; then
    success "Phase boards encontrados: $PHASE_COUNT"

    # Check each phase board for frontmatter
    while IFS= read -r -d '' file; do
      dir=$(dirname "$file")

      # Check required files
      [ -f "$dir/phase-board.md" ] && success "  ✓ $dir/phase-board.md" || error "  ✗ $dir/phase-board.md missing"

    done < <(find docs/development/PHASES -name "phase-board.md" -print0 2>/dev/null)
  else
    warn "Nenhum phase board encontrado"
  fi
else
  warn "docs/development/PHASES/ não existe"
fi

# 7. Check for orphan docs (not referenced anywhere)
echo ""
info "Verificando documentos órfãos..."

ORPHANS=()

# Find all .md files
while IFS= read -r -d '' file; do
  rel_path="${file#./}"

  # Skip node_modules and git
  [[ "$rel_path" == *"node_modules"* ]] && continue
  [[ "$rel_path" == *".git"* ]] && continue
  [[ "$rel_path" == *"checkpoints"* ]] && continue

  # Check if file is referenced (simple check)
  if ! grep -rq "$(basename "$file")" . --include="*.md" 2>/dev/null; then
    # Unless it's a README or root level config
    basename "$(dirname "$file")" | grep -qE "^\." && continue
    [[ "$(basename "$file")" == "README.md" ]] && continue
    [[ "$(basename "$file")" == "CLAUDE.md" ]] && continue
    [[ "$(basename "$file")" == "CHANGELOG.md" ]] && continue

    # It's potentially orphaned if it has a specific naming pattern
    if [[ "$file" =~ (TASK|PHASE|GAP|FEATURE|SPEC)- ]]; then
      ORPHANS+=("$rel_path")
    fi
  fi
done < <(find . -name "*.md" -print0 2>/dev/null)

if [ ${#ORPHANS[@]} -gt 0 ]; then
  warn "Possíveis documentos órfãos encontrados: ${#ORPHANS[@]}"
  for orphan in "${ORPHANS[@]}"; do
    echo "    - $orphan"
  done
else
  success "Nenhum documento órfão detectado"
fi

# 8. Check links in docs
echo ""
info "Verificando links internos..."

BROKEN_LINKS=()

# Check for common link patterns and verify
if [ -d "docs" ]; then
  while IFS= read -r -d '' file; do
    # Check markdown links
    grep -oE '\[.*\]\(\./[^)]+\)' "$file" 2>/dev/null | while read link; do
      target=$(echo "$link" | sed 's/.*](\.\//\.\//' | sed 's/).*//')

      if [ ! -f "$target" ]; then
        BROKEN_LINKS+=("$file: $link")
      fi
    done
  done < <(find docs -name "*.md" -print0 2>/dev/null)
fi

if [ ${#BROKEN_LINKS[@]} -gt 0 ]; then
  warn "Links quebrados encontrados: ${#BROKEN_LINKS[@]}"
  for bl in "${BROKEN_LINKS[@]}"; do
    echo "    - $bl"
  done
else
  success "Todos os links verificados estão válidos"
fi

# 9. Check frontmatter consistency
echo ""
info "Verificando frontmatter..."

FRONTMATTER_ERRORS=()

while IFS= read -r -d '' file; do
  # Check if has frontmatter
  if head -1 "$file" | grep -q "^---"; then
    # Has frontmatter, check required fields
    if ! grep -q "^title:" "$file"; then
      FRONTMATTER_ERRORS+=("$file: missing title")
    fi
    if ! grep -q "^type:" "$file"; then
      FRONTMATTER_ERRORS+=("$file: missing type")
    fi
    if ! grep -q "^status:" "$file"; then
      FRONTMATTER_ERRORS+=("$file: missing status")
    fi
  fi
done < <(find docs/development -name "*.md" -print0 2>/dev/null)

if [ ${#FRONTMATTER_ERRORS[@]} -gt 0 ]; then
  warn "Problemas de frontmatter: ${#FRONTMATTER_ERRORS[@]}"
  for fe in "${FRONTMATTER_ERRORS[@]}"; do
    echo "    - $fe"
  done
else
  success "Frontmatter válido em todos os documentos"
fi

# 10. Check CHANGELOG
echo ""
info "Verificando CHANGELOG..."

if [ -f "docs/development/CHANGELOG.md" ]; then
  success "CHANGELOG.md existe"

  # Check format
  if grep -q "## \[Unreleased\]" "docs/development/CHANGELOG.md"; then
    success "  ✓ Tem seção [Unreleased]"
  else
    warn "  ✗ Sem seção [Unreleased]"
  fi
else
  warn "CHANGELOG.md não encontrado"
fi

# 11. Summary
echo ""
echo "════════════════════════════════════════════════════════════════"
echo -e "${C_BOLD}  📊 RESUMO DA VALIDAÇÃO${C_RESET}"
echo "════════════════════════════════════════════════════════════════"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo -e "  ${C_GREEN}✅ PERFEITO! Nenhum erro ou warning${C_RESET}"
elif [ $ERRORS -eq 0 ]; then
  echo -e "  ${C_YELLOW}⚠️  $WARNINGS warnings, 0 erros${C_RESET}"
elif [ $WARNINGS -eq 0 ]; then
  echo -e "  ${C_RED}✗ $ERRORS erros, 0 warnings${C_RESET}"
else
  echo -e "  ${C_RED}✗ $ERRORS erros${C_RESET}"
  echo -e "  ${C_YELLOW}⚠️  $WARNINGS warnings${C_RESET}"
fi

echo ""
echo "Próximos passos:"
echo "  1. Corrigir erros (se houver)"
echo "  2. Revisar warnings"
echo "  3. Atualizar documentos inconsistentes"
echo ""

# Exit with appropriate code
if [ $ERRORS -gt 0 ]; then
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  exit 2
else
  exit 0
fi
