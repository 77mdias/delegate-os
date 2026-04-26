#!/bin/bash
# HELL Bypass - Git Safe Operations
# Wrapper seguro para operações git

set -e

C_RESET='\033[0m'
C_BOLD='\033[1m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_RED='\033[0;31m'
C_BLUE='\033[0;34m'
C_CYAN='\033[0;36m'

info() { echo -e "${C_BLUE}[GIT-SAFE]${C_RESET} $1"; }
success() { echo -e "${C_GREEN}[GIT-SAFE]${C_RESET} $1"; }
warn() { echo -e "${C_YELLOW}[GIT-SAFE]${C_RESET} $1"; }
error() { echo -e "${C_RED}[ERROR]${C_RESET} $1"; }

# Dangerous commands that require confirmation
DANGEROUS_COMMANDS=(
  "push --force"
  "push -f"
  "force"
  "reset --hard"
  "reset --mixed"
  "rebase -i"
  "rebase --continue"
  "rebase --abort"
  "merge --no-ff"
  "branch -D"
  "branch -d"
  "checkout -f"
  "clean -fd"
  "restore --staged"
  "restore ."
  "rm -rf"
  "rm -r"
  "drop"
  "push :"
  "push --delete"
)

# Commands that need a clean working tree
CLEAN_TREE_COMMANDS=(
  "merge"
  "pull"
  "rebase"
  "switch"
)

# Check if command is dangerous
is_dangerous() {
  local cmd="$1"
  for dangerous in "${DANGEROUS_COMMANDS[@]}"; do
    if [[ "$cmd" == *"$dangerous"* ]]; then
      return 0
    fi
  done
  return 1
}

# Check if command needs clean tree
needs_clean_tree() {
  local cmd="$1"
  for need in "${CLEAN_TREE_COMMANDS[@]}"; do
    if [[ "$cmd" == *"$need"* ]]; then
      return 0
    fi
  done
  return 1
}

# Check working tree status
check_working_tree() {
  if [ ! -d ".git" ]; then
    error "Não é um repositório git"
    exit 1
  fi

  local status=$(git status --porcelain 2>/dev/null | wc -l)
  if [ "$status" -gt 0 ]; then
    return 1  # dirty
  fi
  return 0  # clean
}

# Pre-execution hook
pre_hook() {
  local cmd="$*"

  # Check for git directory
  if [ ! -d ".git" ]; then
    error "Não é um repositório git"
    exit 1
  fi

  # Log command
  echo ""
  info "Executing: git $cmd"
  info "Branch: $(git branch --show-current 2>/dev/null || echo 'detached')"
  info "Commit: $(git rev-parse --short HEAD 2>/dev/null || echo 'N/A')"

  # Check for dangerous commands
  if is_dangerous "$cmd"; then
    warn "⚠️  OPERAÇÃO POTENCIALMENTE PERIGOSA!"
    echo -e "  ${C_RED}$cmd${C_RESET}"
    echo ""
    echo "Este comando pode causar perda de dados irreversível."
    echo ""
    read -p "Tem certeza que deseja continuar? (digite 'yes-force': " confirm

    if [ "$confirm" != "yes-force" ]; then
      error "Operação cancelada pelo usuário"
      exit 1
    fi
    warn "Usuário confirmou operação perigosa"
  fi

  # Check for clean tree requirement
  if needs_clean_tree "$cmd"; then
    if ! check_working_tree; then
      warn "⚠️  Working tree tem alterações não commitadas"

      echo ""
      echo "Opções:"
      echo "  1) Stash alterações"
      echo "  2) Commit alterações"
      echo "  3) Abortar"
      echo ""
      read -p "Escolha (1/2/3): " choice

      case "$choice" in
        1)
          info "Stashing alterações..."
          git stash push -m "Auto-stash before git-safe operation: $cmd" 2>/dev/null || true
          success "Alterações stashadas"
          ;;
        2)
          info "Criando commit temporário..."
          git add -A
          read -p "Mensagem de commit: " msg
          git commit -m "$msg" 2>/dev/null || {
            error "Falha ao criar commit"
            exit 1
          }
          success "Commit criado"
          ;;
        *)
          error "Operação abortada"
          exit 1
          ;;
      esac
    fi
  fi

  # Create checkpoint before dangerous ops
  if is_dangerous "$cmd"; then
    if [ -f "../checkpoint.sh" ]; then
      info "Criando checkpoint de segurança..."
      ../checkpoint.sh create 2>/dev/null || true
    fi
  fi
}

# Post-execution hook
post_hook() {
  local exit_code=$1
  local cmd="$*"

  echo ""

  if [ "$exit_code" -eq 0 ]; then
    success "✓ git $cmd — SUCCESS"
  else
    error "✗ git $cmd — FAILED (exit code: $exit_code)"
  fi
}

# Main
if [ $# -eq 0 ]; then
  echo "HELL Bypass - Git Safe Operations"
  echo ""
  echo "Uso: git-safe.sh <comando-git> [args...]"
  echo ""
  echo "Exemplos:"
  echo "  git-safe.sh status"
  echo "  git-safe.sh add ."
  echo "  git-safe.sh commit -m 'message'"
  echo "  git-safe.sh push origin main"
  echo "  git-safe.sh push --force origin main  # Pedirá confirmação"
  echo ""
  echo "Comandos perigosos que requerem confirmação:"
  for d in "${DANGEROUS_COMMANDS[@]}"; do
    echo "  - $d"
  done
  exit 1
fi

# Run pre-hook
pre_hook "$@"

# Execute git command
set +e
git "$@"
exit_code=$?
set -e

# Run post-hook
post_hook $exit_code "$@"

exit $exit_code
