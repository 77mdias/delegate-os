#!/bin/bash
# HELL Bypass - Checkpoint Script
# Cria checkpoint de estado para rollback

set -e

C_RESET='\033[0m'
C_BOLD='\033[1m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_RED='\033[0;31m'
C_BLUE='\033[0;34m'

CHECKPOINT_DIR=".claude/checkpoints"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
HOSTNAME=$(hostname)

# Colors for output
info() { echo -e "${C_BLUE}[CHECKPOINT]${C_RESET} $1"; }
success() { echo -e "${C_GREEN}[CHECKPOINT]${C_RESET} $1"; }
warn() { echo -e "${C_YELLOW}[CHECKPOINT]${C_RESET} $1"; }
error() { echo -e "${C_RED}[ERROR]${C_RESET} $1"; }

# Help
show_help() {
  echo "HELL Bypass - Checkpoint Script v2.0"
  echo ""
  echo "Uso: checkpoint.sh [comando]"
  echo ""
  echo "Comandos:"
  echo "  create    Cria novo checkpoint (padrão)"
  echo "  list      Lista checkpoints existentes"
  echo "  restore   Restaura checkpoint mais recente"
  echo "  diff      Mostra diff desde último checkpoint"
  echo "  prune     Remove checkpoints antigos (>7 dias)"
  echo "  help      Mostra esta ajuda"
  echo ""
  echo "Exemplos:"
  echo "  ./checkpoint.sh create"
  echo "  ./checkpoint.sh restore"
  echo "  ./checkpoint.sh diff"
}

# Create checkpoint
create_checkpoint() {
  info "Criando checkpoint: $TIMESTAMP"

  mkdir -p "$CHECKPOINT_DIR"

  # Git state
  if [ -d ".git" ]; then
    git rev-parse HEAD > "$CHECKPOINT_DIR/git-head_$TIMESTAMP.txt" 2>/dev/null || echo "no-git" > "$CHECKPOINT_DIR/git-head_$TIMESTAMP.txt"
    git status --porcelain > "$CHECKPOINT_DIR/git-status_$TIMESTAMP.txt" 2>/dev/null || true
    git stash list > "$CHECKPOINT_DIR/git-stash_$TIMESTAMP.txt" 2>/dev/null || true

    # Branch info
    git branch -v > "$CHECKPOINT_DIR/git-branches_$TIMESTAMP.txt" 2>/dev/null || true

    success "✓ Git state salvo"
  fi

  # File state snapshot
  {
    echo "=== FILE SNAPSHOT ==="
    echo "Generated: $(date)"
    find . -type f \
      -not -path "./node_modules/*" \
      -not -path "./.git/*" \
      -not -path "./dist/*" \
      -not -path "./.next/*" \
      -not -path "./build/*" \
      -not -path "*.lock" \
      -not -path "*.log" \
      -not -path "./.claude/checkpoints/*" \
      -name "*.md" -o -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" -o -name "*.json" -o -name "*.yaml" -o -name "*.yml" -o -name "*.sh"
  } | while IFS= read -r line; do
    if [[ "$line" == *"find"* ]] || [[ "$line" == *"==="* ]] || [[ "$line" == *"Generated"* ]]; then
      echo "$line"
    else
      if [ -f "$line" ]; then
        echo "$line"
      fi
    fi
  done > "$CHECKPOINT_DIR/files_$TIMESTAMP.txt" || true

  # Count files
  FILE_COUNT=$(wc -l < "$CHECKPOINT_DIR/files_$TIMESTAMP.txt" 2>/dev/null || echo "0")
  success "✓ $FILE_COUNT arquivos mapeados"

  # Package state
  if [ -f "package.json" ]; then
    cp package.json "$CHECKPOINT_DIR/package_$TIMESTAMP.json" 2>/dev/null || true
    success "✓ package.json salvo"
  fi

  # Config files
  for config in CLAUDE.md config.yaml SYSTEM.md META-PROMPTING.md; do
    if [ -f "$config" ]; then
      cp "$config" "$CHECKPOINT_DIR/${config}_$TIMESTAMP" 2>/dev/null || true
    fi
  done
  success "✓ Config files salvos"

  # Environment info
  {
    echo "=== ENVIRONMENT ==="
    echo "Timestamp: $TIMESTAMP"
    echo "Hostname: $HOSTNAME"
    echo "User: $(whoami)"
    echo "OS: $(uname -s)"
    echo "Node: $(node --version 2>/dev/null || echo 'N/A')"
    echo "Git branch: $(git branch --show-current 2>/dev/null || echo 'N/A')"
    echo "Git commit: $(git rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
  } > "$CHECKPOINT_DIR/env_$TIMESTAMP.txt"

  # Checksum para verificar integridade
  if [ -f "$CHECKPOINT_DIR/files_$TIMESTAMP.txt" ]; then
    md5sum "$CHECKPOINT_DIR/files_$TIMESTAMP.txt" > "$CHECKPOINT_DIR/checksum_$TIMESTAMP.txt" 2>/dev/null || true
  fi

  # Manifest
  {
    echo "=== MANIFEST ==="
    echo "checkpoint_id: $TIMESTAMP"
    echo "created: $(date -Iseconds)"
    echo "hostname: $HOSTNAME"
    echo "git_head: $(cat "$CHECKPOINT_DIR/git-head_$TIMESTAMP.txt" 2>/dev/null || echo 'N/A')"
    echo "files_count: $FILE_COUNT"
    echo "git_status_lines: $(wc -l < "$CHECKPOINT_DIR/git-status_$TIMESTAMP.txt" 2>/dev/null || echo '0')"
  } > "$CHECKPOINT_DIR/manifest_$TIMESTAMP.txt"

  success "✓ Checkpoint $TIMESTAMP criado com sucesso!"

  # List checkpoints after creation
  echo ""
  info "Checkpoints existentes:"
  list_checkpoints
}

# List checkpoints
list_checkpoints() {
  if [ ! -d "$CHECKPOINT_DIR" ] || [ -z "$(ls -A "$CHECKPOINT_DIR" 2>/dev/null)" ]; then
    warn "Nenhum checkpoint encontrado"
    return
  fi

  echo ""
  printf "  ${C_BOLD}%-20s %-10s %s${C_RESET}\n" "CHECKPOINT_ID" "TIPO" "DESCRIÇÃO"
  echo "  ----------------------------------------------------------------"

  # Most recent first
  for dir in "$CHECKPOINT_DIR"/*.txt; do
    [ -f "$dir" ] || continue
    basename "$dir" | grep -oE "^[^_]+" | sort -u | while read prefix; do
      checkpoint_id=$(ls "$dir" 2>/dev/null | grep "^${prefix}_" | head -1 | sed 's/.*_\([0-9]*\)_.*/\1/' | sort -rn | head -1)
      if [ -n "$checkpoint_id" ]; then
        manifest="$CHECKPOINT_DIR/manifest_${checkpoint_id}.txt"
        if [ -f "$manifest" ]; then
          files_count=$(grep "files_count:" "$manifest" | cut -d: -f2 | tr -d ' ')
          git_status_lines=$(grep "git_status_lines:" "$manifest" | cut -d: -f2 | tr -d ' ')
          created=$(grep "created:" "$manifest" | cut -d: -f2- | tr -d ' ' | cut -c1-19)

          if [ "$git_status_lines" -gt 0 ] 2>/dev/null; then
            status="${YELLOW}⚠️ 有改动${C_RESET}"
          else
            status="${GREEN}✓ clean${C_RESET}"
          fi

          printf "  ${C_GREEN}%-20s${C_RESET} %-10s %s (files: %s)\n" "$checkpoint_id" "$created" "$status" "$files_count"
        fi
      fi
    done
  done | sort -r | head -10
}

# Diff since last checkpoint
diff_checkpoint() {
  if [ ! -d "$CHECKPOINT_DIR" ]; then
    error "Nenhum checkpoint encontrado"
    return 1
  fi

  # Find most recent checkpoint
  latest=$(ls -t "$CHECKPOINT_DIR"/git-status_*.txt 2>/dev/null | head -1)
  if [ -z "$latest" ]; then
    error "Nenhum checkpoint encontrado"
    return 1
  fi

  checkpoint_id=$(echo "$latest" | sed 's/.*git-status_\([0-9]*\).*/\1/')

  info "Diff desde checkpoint $checkpoint_id"
  echo ""

  # Compare git status
  echo -e "${C_BOLD}Git Status Changes:${C_RESET}"
  cat "$CHECKPOINT_DIR/git-status_$checkpoint_id.txt" 2>/dev/null || echo "N/A"

  echo ""
  echo -e "${C_BOLD}Files Changed:${C_RESET}"
  if [ -f "$CHECKPOINT_DIR/files_$checkpoint_id.txt" ]; then
    # This is a simplified diff - shows files tracked then vs now
    echo "Checkpoint $checkpoint_id tinha $(wc -l < "$CHECKPOINT_DIR/files_$checkpoint_id.txt") arquivos"
    echo ""
    echo "Files currently tracked by git:"
    git ls-files 2>/dev/null | head -20
  fi
}

# Restore checkpoint
restore_checkpoint() {
  if [ ! -d "$CHECKPOINT_DIR" ] || [ -z "$(ls -A "$CHECKPOINT_DIR" 2>/dev/null)" ]; then
    error "Nenhum checkpoint encontrado"
    return 1
  fi

  # Find most recent
  latest=$(ls -t "$CHECKPOINT_DIR"/manifest_*.txt 2>/dev/null | head -1)
  if [ -z "$latest" ]; then
    error "Nenhum checkpoint encontrado"
    return 1
  fi

  checkpoint_id=$(basename "$latest" | sed 's/manifest_\([0-9]*\)\.txt/\1/')

  warn "Restore checkpoint: $checkpoint_id"
  warn "Isso irá restaurar arquivos para o estado do checkpoint."
  echo ""
  read -p "Continuar? (yes/no): " confirm

  if [ "$confirm" != "yes" ]; then
    info "Restore cancelado"
    return 0
  fi

  # Restore git state
  if [ -f "$CHECKPOINT_DIR/git-head_$checkpoint_id.txt" ]; then
    git_head=$(cat "$CHECKPOINT_DIR/git-head_$checkpoint_id.txt")
    info "Restaurando git para: $git_head"
    git reset --hard "$git_head" 2>/dev/null || error "Git restore failed"
  fi

  success "✓ Restore concluído"
}

# Prune old checkpoints
prune_checkpoints() {
  if [ ! -d "$CHECKPOINT_DIR" ]; then
    warn "Nenhum checkpoint para limpar"
    return
  fi

  info "Removendo checkpoints com mais de 7 dias..."

  find "$CHECKPOINT_DIR" -type f -mtime +7 -delete 2>/dev/null || true
  find "$CHECKPOINT_DIR" -type d -empty -delete 2>/dev/null || true

  success "Limpeza concluída"
}

# Main
COMMAND=${1:-create}

case "$COMMAND" in
  create|c)
    create_checkpoint
    ;;
  list|l)
    list_checkpoints
    ;;
  diff|d)
    diff_checkpoint
    ;;
  restore|r)
    restore_checkpoint
    ;;
  prune|p)
    prune_checkpoints
    ;;
  help|h|--help|-h)
    show_help
    ;;
  *)
    error "Comando desconhecido: $COMMAND"
    show_help
    exit 1
    ;;
esac
