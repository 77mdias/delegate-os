#!/usr/bin/env bash
#===============================================================================
# Delegado OS - Plugin Installer
# Instala o Delegado OS como skill em agentes CLI
#===============================================================================

set -e

INSTALL_DIR="${HOME}/.delegado-os"
AGENT_TYPE="${1:-claude}"  # claude, codex, cursor

echo "🎯 Delegado OS Installer"
echo "========================"

# Detect agent and install accordingly
case "$AGENT_TYPE" in
  claude)
    SKILL_DIR="${HOME}/.claude/skills/delegado"
    echo "📦 Instalando para Claude Code..."
    mkdir -p "$SKILL_DIR"
    cp -r "$(dirname "$0")/../skills/delegado" "$SKILL_DIR/"
    echo "✅ Skill instalada em: $SKILL_DIR"
    echo ""
    echo "Para usar: /delegado ou /agent-os"
    ;;
    
  codex)
    SKILL_DIR="${HOME}/.codex/skills/delegado"
    echo "📦 Instalando para Codex..."
    mkdir -p "$SKILL_DIR"
    cp -r "$(dirname "$0")/../skills/delegado" "$SKILL_DIR/"
    echo "✅ Skill instalada em: $SKILL_DIR"
    ;;
    
  cursor)
    echo "📦 Instalando para Cursor..."
    # Cursor uses .cursor/skills
    ;;
    
  *)
    echo "❌ Agente não suportado: $AGENT_TYPE"
    echo "支持的: claude, codex, cursor"
    exit 1
    ;;
esac

echo ""
echo "✨ Delegado OS pronto para uso!"
