#!/bin/bash
# HELL Bypass - Skill Invoke Script
# Helper para invocar skills manualmente

set -e

C_RESET='\033[0m'
C_BOLD='\033[1m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_RED='\033[0;31m'
C_BLUE='\033[0;34m'

info() { echo -e "${C_BLUE}[SKILL-INVOKE]${C_RESET} $1"; }
success() { echo -e "${C_GREEN}[✓]${C_RESET} $1"; }
error() { echo -e "${C_RED}[✗]${C_RESET} $1"; }

# Help
show_help() {
  cat << EOF
HELL Bypass - Skill Invoke v2.0

Uso: skill-invoke.sh <skill-name> [task-description]

Descrição:
  Invoca uma skill específica do sistema HELL.

Skills disponíveis:

  HELL CORE:
    dos-hell:phase_board   - Boards de fase
    dos-hell:spec          - Especificações
    dos-hell:tdd           - Test-driven development
    dos-hell:review        - Code review
    dos-hell:audit         - Auditoria
    dos-hell:refactor      - Refatoração
    dos-hell:debt          - Technical debt
    dos-hell:milestone     - Milestones
    dos-hell:brainstorm    - Brainstorming
    dos-hell:plan_phase    - Planejar phase
    dos-hell:execute_phase - Executar phase
    dos-hell:verify_phase  - Verificar phase

  SUPERPOWERS:
    superpowers:brainstorming          - Brainstorm
    superpowers:executing-plans        - Executar planos
    superpowers:test-driven-development - TDD
    superpowers:code-review           - Code review
    superpowers:writing-plans         - Escrever planos
    superpowers:verification-before-completion - Verificação

  GSD:
    gsd-plan-phase     - Planear phase
    gsd-execute-phase  - Executar phase
    gsd-verify-phase   - Verificar phase
    gsd-add-todo       - Adicionar todo
    gsd-add-phase      - Adicionar phase
    gsd-add-tests      - Adicionar tests

  DELEGADO:
    delegado-os        - Delegado OS

Exemplos:
  ./skill-invoke.sh dos-hell:phase_board
  ./skill-invoke.sh superpowers:brainstorming "Criar feature de chat"
  ./skill-invoke.sh gsd-plan-phase
EOF
}

# List available skills
list_skills() {
  echo ""
  echo -e "${C_BOLD}HELL CORE:${C_RESET}"
  for skill in phase_board spec tdd review audit refactor debt milestone brainstorm plan_phase execute_phase verify_phase; do
    if [ -f "skills/dos/hell/$skill/SKILL.md" ]; then
      desc=$(grep "^description:" "skills/dos/hell/$skill/SKILL.md" 2>/dev/null | cut -d: -f2- | sed 's/^[[:space:]]*//' | cut -c1-50)
      echo -e "  ${C_GREEN}dos-hell:$skill${C_RESET} — $desc"
    fi
  done

  echo ""
  echo -e "${C_BOLD}SUPERPOWERS:${C_RESET}"
  if [ -d "skills/superpowers" ]; then
    find skills/superpowers -name "SKILL.md" -type f 2>/dev/null | while read f; do
      name=$(basename $(dirname "$f"))
      desc=$(grep "^description:" "$f" 2>/dev/null | cut -d: -f2- | sed 's/^[[:space:]]*//' | cut -c1-50)
      echo -e "  ${C_GREEN}superpowers:$name${C_RESET} — $desc"
    done
  fi

  echo ""
  echo -e "${C_BOLD}GSD:${C_RESET}"
  if [ -d "skills" ]; then
    find skills -maxdepth 1 -type d -name "gsd*" 2>/dev/null | while read d; do
      name=$(basename "$d")
      if [ -f "$d/SKILL.md" ]; then
        desc=$(grep "^description:" "$d/SKILL.md" 2>/dev/null | cut -d: -f2- | sed 's/^[[:space:]]*//' | cut -c1-50)
        echo -e "  ${C_GREEN}$name${C_RESET} — $desc"
      fi
    done
  fi

  echo ""
}

# Find skill file
find_skill_file() {
  local skill_name="$1"

  # Handle prefixed names (dos-hell:skill, superpowers:skill, gsd:skill)
  case "$skill_name" in
    dos-hell:*)
      local name="${skill_name#dos-hhell:}"
      local name="${name#dos-hell:}"
      for dir in "skills/dos/hell/$name" "skills/dos/hell/$name/SKILL.md"; do
        if [ -f "$dir/SKILL.md" ]; then
          echo "$dir/SKILL.md"
          return 0
        fi
      done
      ;;
    superpowers:*)
      local name="${skill_name#superpowers:}"
      if [ -f "skills/superpowers/$name/SKILL.md" ]; then
        echo "skills/superpowers/$name/SKILL.md"
        return 0
      fi
      ;;
    gsd:*|gsd-*)
      local name="${skill_name#gsd:}"
      for dir in "skills/$name" "skills/$name/SKILL.md"; do
        if [ -f "$dir/SKILL.md" ]; then
          echo "$dir/SKILL.md"
          return 0
        fi
      done
      ;;
    *)
      # Try direct path
      if [ -f "$skill_name/SKILL.md" ]; then
        echo "$skill_name/SKILL.md"
        return 0
      fi
      ;;
  esac

  return 1
}

# Invoke skill via Claude Code
invoke_via_claude() {
  local skill_name="$1"
  local task="$2"

  info "Invocando skill: $skill_name"
  info "Task: ${task:-<nenhuma especificada>}"

  # Note: This script is for reference/finding skills
  # Actual invocation should be done via Claude Code's /command
  echo ""
  echo -e "${C_YELLOW}Para invocar esta skill no Claude Code, use:${C_RESET}"
  echo ""
  echo -e "  /${skill_name} ${task:-}"
  echo ""

  return 0
}

# Main
if [ $# -eq 0 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  show_help
  exit 0
fi

if [ "$1" == "list" ] || [ "$1" == "-l" ]; then
  list_skills
  exit 0
fi

SKILL_NAME="$1"
TASK="${2:-}"

# Find skill
SKILL_FILE=$(find_skill_file "$SKILL_NAME")

if [ -z "$SKILL_FILE" ]; then
  error "Skill não encontrada: $SKILL_NAME"
  echo ""
  echo "Skills disponíveis:"
  list_skills
  exit 1
fi

info "Skill file: $SKILL_FILE"

# Read skill info
if [ -f "$SKILL_FILE" ]; then
  echo ""
  echo -e "${C_BOLD}Skill: $SKILL_NAME${C_RESET}"

  if grep -q "^description:" "$SKILL_FILE"; then
    echo -e "Description: $(grep '^description:' "$SKILL_FILE" | cut -d: -f2- | sed 's/^[[:space:]]*//')"
  fi

  if grep -q "^argument-hint:" "$SKILL_FILE"; then
    echo -e "Arguments: $(grep '^argument-hint:' "$SKILL_FILE" | cut -d: -f2- | sed 's/^[[:space:]]*//')"
  fi
fi

# Invoke
invoke_via_claude "$SKILL_NAME" "$TASK"
