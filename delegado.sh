#!/usr/bin/env bash
#===============================================================================
# Agent OS - Delegado das Trevas
# CLI Principal
#===============================================================================

set -e

VERSION="1.0.0"

# Resolve symlinks to find actual script location
resolve_dir() {
  local source="${BASH_SOURCE[0]}"
  while [[ -L "$source" ]]; do
    local dir="$(cd -P "$(dirname "$source")" && pwd)"
    source="$(readlink "$source")"
    [[ "$source" != /* ]] && source="$dir/$source"
  done
  cd "$(dirname "$source")/.." && pwd
}

CORES="\033[0m"
BRANCO="\033[1;37m"
CYAN="\033[0;36m"
VERDE="\033[0;32m"
AMARELO="\033[0;33m"
VERMELHO="\033[0;31m"
MAGENTA="\033[0;35m"
AZUL="\033[0;34m"

# Use resolve_dir to find actual package location (handles symlinks from npm)
DIRETORIO="$(resolve_dir)"
cd "$DIRETORIO"

logo() {
  cat << 'EOF'

   █████████
  ███░░░░░░░░███
 ███░░██████░░░░░███    AGENT OS
 ██░░██      ██░░░░░██
 ██░░██      ██░░░░░██   DELEGADO DAS TREVAS
 ██░░██      ██░░░░░██   Dark Analyst System
 ███░░██░░░░██░░░░░██
  ███░░░█████░░░░░███
    ██████████████

   "O contexto é poder. A memória é força."

EOF
}

show_version() {
  echo "delegado-os $VERSION"
  exit 0
}

# Handle --version flag
for arg in "$@"; do
  case "$arg" in
    --version|-v) show_version ;;
  esac
done

menu() {
  echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${COR}"
  echo -e "${BRANCO}                    DELEGADO DAS TREVAS${COR}"
  echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${COR}"
  echo ""
  echo -e "  ${CYAN}[1]${COR} 🚀 Setup              - Configurar projeto"
  echo -e "  ${CYAN}[2]${COR} 🔍 Detectar          - Detectar stack"
  echo -e "  ${CYAN}[3]${COR} ❓ Perguntar         - Modo Q&A"
  echo -e "  ${CYAN}[4]${COR} 📝 Aprender          - Ensinar preferência"
  echo -e "  ${CYAN}[5]${COR} 🧠 Memória           - Ver memória"
  echo -e "  ${CYAN}[6]${COR} 📊 Status           - Status do agente"
  echo -e "  ${CYAN}[7]${COR} 💬 Feedback          - Dar feedback"
  echo -e "  ${CYAN}[8]${COR} ⚙️  Config          - Configurações"
  echo -e "  ${CYAN}[9]${COR} 🎯 Executar          - Executar tarefa"
  echo -e "  ${CYAN}[0]${COR} ❌ Sair"
  echo ""
}

detectar_stack() {
  echo -e "\n${MAGENTA}🔍 DETECTANDO STACK...${COR}\n"

  if [[ -f "package.json" ]]; then
    echo -e "  ${VERDE}✓${COR} Node.js/TypeScript detectado"
    grep -q "next" package.json && echo -e "  ${VERDE}✓${COR} Framework: Next.js"
    grep -q "react" package.json && echo -e "  ${VERDE}✓${COR} React"
    grep -q "prisma" package.json && echo -e "  ${VERDE}✓${COR} Prisma ORM"
  fi

  if [[ -f "requirements.txt" ]]; then
    echo -e "  ${VERDE}✓${COR} Python detectado"
    grep -q "django" requirements.txt && echo -e "  ${VERDE}✓${COR} Django"
    grep -q "fastapi" requirements.txt && echo -e "  ${VERDE}✓${COR} FastAPI"
  fi

  if [[ -f "Cargo.toml" ]]; then
    echo -e "  ${VERDE}✓${COR} Rust detectado"
  fi

  if [[ -f "go.mod" ]]; then
    echo -e "  ${VERDE}✓${COR} Go detectado"
  fi

  echo ""
}

perguntar_modo() {
  echo -e "\n${MAGENTA}❓ MODO PERGUNTAS${COR}"
  echo -e "${CYAN}Digite sua pergunta ou 'sair' para voltar${COR}\n"

  while true; do
    echo -n -e "${MAGENTA}❓ ${COR}"
    read -r pergunta

    [[ "$pergunta" == "sair" ]] && break

    if [[ -n "$pergunta" ]]; then
      echo -e "\n${VERDE}→${COR} \"$pergunta\""
      echo -e "${AMARELO}   Processando contexto...${COR}\n"
    fi
  done
}

aprender() {
  echo -e "\n${MAGENTA}📝 APRENDIZADO${COR}"
  echo -e "${CYAN}O que devo aprender?${COR}\n"
  read -r preference

  if [[ -n "$preference" ]]; then
    mkdir -p memoria
    echo "- **$preference** ($(date +%Y-%m-%d))" >> memoria/regras.md
    echo -e "\n${VERDE}✓${COR} Aprendido e registrado"
  fi
}

mostrar_memoria() {
  echo -e "\n${MAGENTA}🧠 MEMÓRIA DO DELEGADO${COR}\n"

  if [[ -d "memoria" ]] && [[ -n "$(ls -A memoria/)" ]]; then
    for arquivo in memoria/*.md; do
      [[ -f "$arquivo" ]] || continue
      echo -e "${CYAN}--- $(basename $arquivo) ---${COR}"
      cat "$arquivo"
      echo ""
    done
  else
    echo -e "${AMARELO}⚠ Nenhuma memória encontrada. Execute setup primeiro.${COR}"
  fi
}

feedback() {
  echo -e "\n${MAGENTA}💬 FEEDBACK${COR}"
  echo -e "${CYAN}Deixe seu feedback:${COR}\n"
  read -r fb

  if [[ -n "$fb" ]]; then
    mkdir -p memoria
    echo "- **$fb** ($(date +%Y-%m-%d))" >> memoria/feedback.md
    echo -e "\n${VERDE}✓${COR} Feedback registrado. Obrigado."
  fi
}

status_agente() {
  echo -e "\n${MAGENTA}📊 STATUS DO DELEGADO${COR}\n"

  if [[ -d "memoria" ]]; then
    total=$(ls memoria/*.md 2>/dev/null | wc -l)
    echo -e "  ${VERDE}✓${COR} Memória: ${total} arquivos"
  else
    echo -e "  ${AMARELO}⚠${COR} Memória: Não configurada"
  fi

  if [[ -f "memoria/projeto.md" ]]; then
    echo -e "  ${VERDE}✓${COR} Projeto: Configurado"
  else
    echo -e "  ${AMARELO}⚠${COR} Projeto: Não configurado"
  fi

  echo ""
}

setup_inicial() {
  echo -e "\n${MAGENTA}🚀 SETUP DO DELEGADO${COR}\n"

  echo -e "${CYAN}Nome do projeto:${COR}"
  read -r nome_projeto

  echo -e "\n${CYAN}Linguagem principal:${COR}"
  echo "  [1] TypeScript/JavaScript"
  echo "  [2] Python"
  echo "  [3] Rust"
  echo "  [4] Go"
  echo "  [5] Outro"
  read -rn1 linguagem
  echo ""

  echo -e "${CYAN}TDD (Test-Driven Development)? (s/n)${COR}"
  read -r tdd

  echo -e "${CYAN}Tamanho máximo de PR (linhas)?${COR}"
  read -r pr_size

  mkdir -p memoria

  cat > memoria/projeto.md << EOF
# Projeto

- **Nome**: $nome_projeto
- **Linguagem**: $linguagem
- **TDD**: $tdd
- **PR Size**: $pr_size
- **Setup Date**: $(date +%Y-%m-%d)
EOF

  cat > memoria/regras.md << EOF
# Regras Aprendidas

## Preferências do Usuário
EOF

  cat > memoria/preferencias.md << EOF
# Preferências

## Workflow
EOF

  echo -e "\n${VERDE}✓${COR} Setup completo! Memória criada."
  echo -e "${VERDE}✓${COR} Delegado pronto para operar.\n"
}

# Main loop
while true; do
  logo
  menu
  echo -n -e "${MAGENTA}> ${COR}"
  read -rn1 escolha
  echo ""

  case $escolha in
    1) setup_inicial ;;
    2) detectar_stack ;;
    3) perguntar_modo ;;
    4) aprender ;;
    5) mostrar_memoria ;;
    6) status_agente ;;
    7) feedback ;;
    8) echo -e "${AMARELO}Configurações em desenvolvimento...${COR}" ;;
    9) echo -e "${AMARELO}Execução de tarefas em desenvolvimento...${COR}" ;;
    0) echo -e "\n${VERDE}Até logo. O Delegado sempre lembra.${COR}\n"; exit 0 ;;
    *) echo -e "${VERMELHO}Opção inválida${COR}" ;;
  esac

  echo ""
done
