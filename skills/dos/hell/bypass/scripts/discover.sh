#!/bin/bash
# HELL Bypass - Discover Script
# Descobre e lista todos os recursos disponíveis no ambiente

set -e

C_RESET='\033[0m'
C_BOLD='\033[1m'
C_GREEN='\033[0;32m'
C_BLUE='\033[0;34m'
C_YELLOW='\033[1;33m'
C_RED='\033[0;31m'

echo -e "${C_BOLD}${C_BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  🤖 HELL Bypass - Sistema de Descoberta v2.0                 ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${C_RESET}"

# 1. SKILLS
echo -e "\n${C_BOLD}📚 SKILLS ENCONTRADAS${C_RESET}"
echo "────────────────────────────────────────────────────────────────"

if [ -d "skills" ]; then
  SKILL_COUNT=0
  while IFS= read -r -d '' file; do
    SKILL_COUNT=$((SKILL_COUNT + 1))
    dir=$(dirname "$file")
    name=$(grep "^name:" "$file" 2>/dev/null | head -1 | cut -d: -f2- | sed 's/^[[:space:]]*//' | tr -d ' ')
    description=$(grep "^description:" "$file" 2>/dev/null | head -1 | cut -d: -f2- | sed 's/^[[:space:]]*//' | cut -c1-60)

    # Categorize
    if [[ "$dir" == *"dos/hell"* ]]; then
      icon="🔥"
    elif [[ "$dir" == *"superpowers"* ]]; then
      icon="⚡"
    elif [[ "$dir" == *"gsd"* ]] || [[ "$dir" == *"gsd-"* ]]; then
      icon="🚀"
    elif [[ "$dir" == *"delegado"* ]]; then
      icon="🎯"
    else
      icon="📦"
    fi

    printf "  %s ${C_GREEN}%-40s${C_RESET} %s\n" "$icon" "$name" "$description"
  done < <(find skills -name "SKILL.md" -print0 2>/dev/null)

  echo ""
  echo -e "  ${C_YELLOW}Total: $SKILL_COUNT skills${C_RESET}"
else
  echo -e "  ${C_RED}✗ Diretório skills/ não encontrado${C_RESET}"
fi

# 2. TEMPLATES
echo -e "\n${C_BOLD}📋 TEMPLATES${C_RESET}"
echo "────────────────────────────────────────────────────────────────"

TEMPLATE_COUNT=0
while IFS= read -r -d '' file; do
  TEMPLATE_COUNT=$((TEMPLATE_COUNT + 1))
  rel_path="${file#./}"
  icon="📄"
  case "$file" in
    *phase-board*) icon="📊" ;;
    *sprint*) icon="🏃" ;;
    *task*) icon="✅" ;;
    *spec*) icon="📐" ;;
    *roadmap*) icon="🗺️" ;;
    *gap*) icon="⚠️" ;;
    *feature*) icon="💡" ;;
    *hell-spec*) icon="🔥" ;;
    *prd*) icon="📋" ;;
    *changelog*) icon="📝" ;;
  esac
  printf "  %s %s\n" "$icon" "$rel_path"
done < <(find . -path "./node_modules" -prune -o -path "./.git" -prune -o -name "*.template.md" -print0 2>/dev/null)

echo ""
echo -e "  ${C_YELLOW}Total: $TEMPLATE_COUNT templates${C_RESET}"

# 3. SCRIPTS
echo -e "\n${C_BOLD}🔧 SCRIPTS AUXILIARES${C_RESET}"
echo "────────────────────────────────────────────────────────────────"

if [ -d "scripts" ]; then
  while IFS= read -r file; do
    if [ -x "$file" ]; then
      icon="⚡"
    else
      icon="📜"
    fi
    printf "  %s %s\n" "$icon" "$file"
  done < <(find scripts -type f \( -name "*.sh" -o -name "*.js" -o -name "*.ts" \) 2>/dev/null)
fi

if [ -d "skills/dos/hell/bypass/scripts" ]; then
  while IFS= read -r file; do
    icon="🤖"
    printf "  %s %s\n" "$icon" "$file"
  done < <(find skills/dos/hell/bypass/scripts -type f 2>/dev/null)
fi

# 4. MCPs (via verificação)
echo -e "\n${C_BOLD}🔌 MCPS DETECTADOS${C_RESET}"
echo "────────────────────────────────────────────────────────────────"

# Verificar Context7
if [ -d "node_modules/@context7" ] || grep -q "context7" package.json 2>/dev/null; then
  echo -e "  ✅ ${C_GREEN}Context7${C_RESET} — Docs de libraries/frameworks"
fi

# Verificar Playwright
if grep -q "playwright" package.json 2>/dev/null; then
  echo -e "  ✅ ${C_GREEN}Playwright${C_RESET} — Browser automation"
fi

# Verificar MCPs do projeto
if [ -f ".mcp.json" ] || [ -f "mcp.json" ]; then
  echo -e "  ✅ ${C_GREEN}MCP config encontrado${C_RESET}"
fi

# Plugins Claude
if [ -d ".claude/plugins" ]; then
  echo -e "  ✅ ${C_GREEN}Claude plugins${C_RESET}"
fi

# 5. ESTRUTURA DO PROJETO
echo -e "\n${C_BOLD}📁 ESTRUTURA DO PROJETO${C_RESET}"
echo "────────────────────────────────────────────────────────────────"

echo -e "  ${C_BOLD}Raiz:${C_RESET}"
ls -la | grep -E "^d|\.md$|\.yaml$|\.json$" | head -15 | while read line; do
  echo "    $line"
done

# Docs
if [ -d "docs" ]; then
  echo -e "\n  ${C_BOLD}docs/:${C_RESET}"
  find docs -maxdepth 2 -type d 2>/dev/null | head -10 | while read dir; do
    echo "    📁 $dir"
  done
fi

# Git info
echo -e "\n${C_BOLD}🔀 GIT${C_RESET}"
echo "────────────────────────────────────────────────────────────────"
if [ -d ".git" ]; then
  branch=$(git branch --show-current 2>/dev/null || echo "unknown")
  status=$(git status --porcelain 2>/dev/null | wc -l)
  ahead=$(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null || echo "0 0")

  echo -e "  Branch: ${C_GREEN}$branch${C_RESET}"
  echo -e "  Alterações: $status arquivo(s)"
  echo -e "  Commits ahead/behind: $ahead"
else
  echo -e "  ${C_RED}✗ Não é um repositório git${C_RESET}"
fi

# 6. AMBIENTE
echo -e "\n${C_BOLD}🖥️  AMBIENTE${C_RESET}"
echo "────────────────────────────────────────────────────────────────"

echo -e "  OS: $(uname -s) $(uname -m)"
echo -e "  Node: $(node --version 2>/dev/null || echo 'não encontrado')"
echo -e "  NPM: $(npm --version 2>/dev/null || echo 'não encontrado')"
echo -e "  Git: $(git --version 2>/dev/null | cut -d' ' -f3)"
echo -e "  Shell: $SHELL"

# 7. HELL SPECIFIC
echo -e "\n${C_BOLD}🔥 HELL METHOD${C_RESET}"
echo "────────────────────────────────────────────────────────────────"

if [ -f "META-PROMPTING.md" ]; then
  echo -e "  ✅ ${C_GREEN}META-PROMPTING.md${C_RESET} — Intelligence layer"
fi

if [ -f "CLAUDE.md" ]; then
  echo -e "  ✅ ${C_GREEN}CLAUDE.md${C_RESET} — Project instructions"
fi

if [ -f "SYSTEM.md" ]; then
  echo -e "  ✅ ${C_GREEN}SYSTEM.md${C_RESET} — System prompt"
fi

if [ -d "kernel" ]; then
  echo -e "  ✅ ${C_GREEN}kernel/${C_RESET} — Kernel skills"
  ls kernel/*/ 2>/dev/null | head -5 | while read d; do echo "    📁 $d"; done
fi

# 8. MEMORY
echo -e "\n${C_BOLD}🧠 MEMORY${C_RESET}"
echo "────────────────────────────────────────────────────────────────"

if [ -d "memory" ]; then
  echo -e "  ✅ ${C_GREEN}memory/${C_RESET}"
  ls memory/*.* 2>/dev/null | head -5 | while read f; do
    echo "    📄 $(basename $f)"
  done
fi

if [ -d ".claude/projects" ]; then
  echo -e "  ✅ ${C_GREEN}.claude/projects memory${C_RESET}"
fi

if [ -d "Obsidian" ]; then
  echo -e "  ✅ ${C_GREEN}Obsidian vault${C_RESET}"
fi

echo -e "\n${C_BOLD}════════════════════════════════════════════════════════════════${C_RESET}"
echo -e "${C_GREEN}✅ Descoberta concluída!${C_RESET}"
echo ""
