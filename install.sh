#!/usr/bin/env bash
#===============================================================================
# Delegado OS - Auto Installer
# Instala o Delegado OS como skill em agentes CLI (Claude, Codex, Cursor)
#===============================================================================

set -e

VERSION="1.0.0"
DELEGADO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SOURCE="${DELEGADO_DIR}/skills/delegado"

# Cores
VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AMARELO='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

log() { echo -e "${VERDE}✓${RESET} $1"; }
warn() { echo -e "${AMARELO}⚠${RESET} $1"; }
error() { echo -e "${VERMELHO}✗${RESET} $1"; }
info() { echo -e "${CYAN}ℹ${RESET} $1"; }

# Banner
banner() {
  cat << 'EOF'

   █████████
  ███░░░░░░░░███
 ███░░██████░░░░░███    DELEGADO OS
 ██░░██      ██░░░░░██    Auto Installer v1.0.0
 ██░░██      ██░░░░░██   
 ██░░██      ██░░░░░██   "O contexto é poder."
  ███░░░█████░░░░░███
    ██████████████

EOF
}

# Verificar dependências
check_deps() {
  info "Verificando dependências..."
  
  if [[ ! -d "$SKILL_SOURCE" ]]; then
    error "Skill não encontrado em: $SKILL_SOURCE"
    exit 1
  fi
  
  log "Dependências verificadas"
}

# Detectar agente
detect_agent() {
  if command -v claude &> /dev/null; then
    echo "claude"
  elif command -v codex &> /dev/null; then
    echo "codex"
  elif command -v cursor &> /dev/null; then
    echo "cursor"
  else
    echo "unknown"
  fi
}

# Instalar para Claude Code
install_claude() {
  local SKILL_DIR="${HOME}/.claude/skills/delegado"
  
  info "Instalando para Claude Code..."
  
  mkdir -p "${HOME}/.claude/skills"
  
  if [[ -d "$SKILL_DIR" ]]; then
    warn "Skill já existe. Sobrescrevendo..."
    rm -rf "$SKILL_DIR"
  fi
  
  cp -r "$SKILL_SOURCE" "$SKILL_DIR"
  
  log "Instalado em: $SKILL_DIR"
  echo ""
  echo "Para usar: /delegado ou /agent-os"
}

# Instalar para Codex
install_codex() {
  local SKILL_DIR="${HOME}/.codex/skills/delegado"
  
  info "Instalando para Codex..."
  
  mkdir -p "${HOME}/.codex/skills"
  cp -r "$SKILL_SOURCE" "$SKILL_DIR"
  
  log "Instalado em: $SKILL_DIR"
}

# Instalar para Cursor
install_cursor() {
  local SKILL_DIR="${HOME}/.cursor/skills/delegado"
  
  info "Instalando para Cursor..."
  
  mkdir -p "${HOME}/.cursor/skills"
  cp -r "$SKILL_SOURCE" "$SKILL_DIR"
  
  log "Instalado em: $SKILL_DIR"
}

# Instalar para todos
install_all() {
  info "Instalando para todos os agentes..."
  
  if command -v claude &> /dev/null; then
    install_claude
    echo ""
  fi
  
  if command -v codex &> /dev/null; then
    install_codex
    echo ""
  fi
  
  if command -v cursor &> /dev/null; then
    install_cursor
    echo ""
  fi
  
  if [[ ! -d "${HOME}/.claude/skills/delegado" ]]; then
    warn "Nenhum agente detectado. Instalação manual:"
    echo "  cp -r $SKILL_SOURCE ~/.claude/skills/"
  fi
}

# Desinstalar
uninstall() {
  info "Desinstalando Delegado OS..."
  
  rm -rf "${HOME}/.claude/skills/delegado" 2>/dev/null || true
  rm -rf "${HOME}/.codex/skills/delegado" 2>/dev/null || true
  rm -rf "${HOME}/.cursor/skills/delegado" 2>/dev/null || true
  
  log "Desinstalação completa"
}

# Status
status() {
  echo ""
  info "Status da instalação:"
  echo ""
  
  local count=0
  
  if [[ -d "${HOME}/.claude/skills/delegado" ]]; then
    echo -e "  ${VERDE}✓${RESET} Claude Code"
    count=$((count + 1))
  fi
  
  if [[ -d "${HOME}/.codex/skills/delegado" ]]; then
    echo -e "  ${VERDE}✓${RESET} Codex"
    count=$((count + 1))
  fi
  
  if [[ -d "${HOME}/.cursor/skills/delegado" ]]; then
    echo -e "  ${VERDE}✓${RESET} Cursor"
    count=$((count + 1))
  fi
  
  if [[ $count -eq 0 ]]; then
    echo -e "  ${AMARELO}⚠${RESET} Nenhum agente instalado"
  fi
  
  echo ""
  info "Skill source: $SKILL_SOURCE"
}

# Help
help() {
  cat << 'EOF'

Uso: ./install.sh [comando]

Comandos:
  claude     Instalar apenas para Claude Code
  codex      Instalar apenas para Codex
  cursor     Instalar apenas para Cursor
  all        Instalar para todos os agentes detectados (padrão)
  uninstall  Desinstalar de todos os agentes
  status     Verificar status da instalação
  help       Mostrar esta ajuda

Exemplos:
  ./install.sh              # Instalar para todos
  ./install.sh claude       # Instalar apenas para Claude
  ./install.sh uninstall    # Desinstalar

EOF
}

# Main
main() {
  banner
  
  local cmd="${1:-all}"
  
  case "$cmd" in
    claude)
      check_deps
      install_claude
      ;;
    codex)
      check_deps
      install_codex
      ;;
    cursor)
      check_deps
      install_cursor
      ;;
    all)
      check_deps
      install_all
      ;;
    uninstall)
      uninstall
      ;;
    status)
      status
      ;;
    help|--help|-h)
      help
      ;;
    *)
      error "Comando desconhecido: $cmd"
      echo ""
      help
      exit 1
      ;;
  esac
  
  echo ""
  log "Delegado OS pronto!"
}

main "$@"
