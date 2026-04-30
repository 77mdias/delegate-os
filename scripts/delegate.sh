#!/bin/bash
#===============================================================================
# Delegado OS - Main Orchestration Script
# Controls agent modes, hooks, and context management
#===============================================================================

set -e

DELEGADO_ROOT="${DELEGADO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
VAULT_PATH="${OBSIDIAN_VAULT:-$HOME/obsidian-vault}"
CONTEXT_FILE="$DELEGADO_ROOT/.delegado/context"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

#-------------------------------------------------------------------------------
# Utility Functions
#-------------------------------------------------------------------------------

log() {
    echo -e "${GREEN}[DELEGADO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

ensure_context() {
    mkdir -p "$DELEGADO_ROOT/.delegado"
    if [ ! -f "$CONTEXT_FILE" ]; then
        cat > "$CONTEXT_FILE" << 'EOF'
{
  "current_mode": null,
  "session_id": null,
  "last_update": null,
  "active_hooks": [],
  "vars": {}
}
EOF
    fi
}

#-------------------------------------------------------------------------------
# Mode Management
#-------------------------------------------------------------------------------

MODES=("PROFESSOR" "ARCHITECT" "DEBUGGER" "GUARDIAN" "RESEARCHER" "MENTOR" "CONSULTANT")

show_modes() {
    echo ""
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                    DELEGADO OS - AGENT MODES                │"
    echo "├──────────────┬───────────────┬──────────────────────────────┤"
    printf "│ %-12s │ %-13s │ %-28s │\n" "MODE" "TRIGGER" "PURPOSE"
    echo "├──────────────┼───────────────┼──────────────────────────────┤"
    printf "│ %-12s │ %-13s │ %-28s │\n" "PROFESSOR" "ensinar" "Teaching & docs"
    printf "│ %-12s │ %-13s │ %-28s │\n" "ARCHITECT" "pattern" "System design"
    printf "│ %-12s │ %-13s │ %-28s │\n" "DEBUGGER" "bug" "Debug & analysis"
    printf "│ %-12s │ %-13s │ %-28s │\n" "GUARDIAN" "segurança" "Security audits"
    printf "│ %-12s │ %-13s │ %-28s │\n" "RESEARCHER" "comparar" "Tech research"
    printf "│ %-12s │ %-13s │ %-28s │\n" "MENTOR" "carreira" "Career growth"
    printf "│ %-12s │ %-13s │ %-28s │\n" "CONSULTANT" "sugerir" "Strategy & advice"
    echo "└──────────────┴───────────────┴──────────────────────────────┘"
    echo ""
}

activate_mode() {
    local mode="$1"
    ensure_context
    
    if [[ ! " ${MODES[*]} " =~ " ${mode} " ]]; then
        error "Unknown mode: $mode"
        echo "Available modes: ${MODES[*]}"
        return 1
    fi
    
    # Update context
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local session_id=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 16 | head -n 1)
    
    cat > "$CONTEXT_FILE" << EOF
{
  "current_mode": "$mode",
  "session_id": "$session_id",
  "last_update": "$timestamp",
  "active_hooks": ["pre_$mode", "post_$mode"],
  "vars": {}
}
EOF
    
    log "Activated mode: $mode (session: $session_id)"
    
    # Run pre-mode hook
    run_hook "pre_$mode"
    
    # Load mode skill
    local skill_file="$DELEGADO_ROOT/subagents/$mode/SKILL.md"
    if [ -f "$skill_file" ]; then
        info "Loading skill: $skill_file"
    fi
    
    # Create obsidian folder
    local vault_folder="$VAULT_PATH/$(get_vault_folder $mode)"
    mkdir -p "$vault_folder"
    
    echo "$mode" > "$DELEGADO_ROOT/.delegado/current_mode"
}

get_vault_folder() {
    case "$1" in
        PROFESSOR) echo "10-EDUCATION" ;;
        ARCHITECT) echo "20-ARCHITECTURE" ;;
        DEBUGGER) echo "30-BUGS" ;;
        GUARDIAN) echo "40-SECURITY" ;;
        RESEARCHER) echo "50-RESEARCH" ;;
        MENTOR) echo "60-CAREER" ;;
        CONSULTANT) echo "70-CONSULTING" ;;
        *) echo "00-GENERAL" ;;
    esac
}

deactivate_mode() {
    ensure_context
    local current=$(cat "$DELEGADO_ROOT/.delegado/current_mode" 2>/dev/null || echo "")
    
    if [ -n "$current" ]; then
        run_hook "post_$current"
        log "Deactivated mode: $current"
    fi
    
    rm -f "$DELEGADO_ROOT/.delegado/current_mode"
    cat > "$CONTEXT_FILE" << 'EOF'
{
  "current_mode": null,
  "session_id": null,
  "last_update": null,
  "active_hooks": [],
  "vars": {}
}
EOF
}

#-------------------------------------------------------------------------------
# Hooks System
#-------------------------------------------------------------------------------

run_hook() {
    local hook_name="$1"
    local hooks_dir="$DELEGADO_ROOT/scripts/hooks.d"
    
    if [ -d "$hooks_dir" ]; then
        local hook_file="$hooks_dir/${hook_name}.sh"
        if [ -f "$hook_file" ]; then
            info "Running hook: $hook_name"
            source "$hook_file"
        fi
    fi
}

#-------------------------------------------------------------------------------
# Context7 Integration
#-------------------------------------------------------------------------------

search_docs() {
    local query="$1"
    local lang="${2:-}"
    
    if [ -z "$CONTEXT7_API_KEY" ]; then
        warn "CONTEXT7_API_KEY not set. Using fallback search."
        fallback_search "$query"
        return
    fi
    
    log "Searching docs for: $query"
    
    local payload=$(cat << EOF
{
  "query": "$query",
  "language": "${lang:-en}"
}
EOF
)
    
    curl -s -X POST "https://api.context7.io/v1/search" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $CONTEXT7_API_KEY" \
        -d "$payload" | jq -r '.results[] | "- [" + .title + "](" + .url + ")"' 2>/dev/null || {
            warn "Context7 search failed, trying fallback..."
            fallback_search "$query"
        }
}

fallback_search() {
    local query="$1"
    echo "Fallback search results for: $query"
    echo "- Documentation search requires CONTEXT7_API_KEY"
    echo "- Set it with: export CONTEXT7_API_KEY=your_key"
}

#-------------------------------------------------------------------------------
# Obsidian Sync
#-------------------------------------------------------------------------------

sync_to_obsidian() {
    local content="$1"
    local title="$2"
    local folder="${3:-}"
    
    ensure_context
    local mode=$(cat "$DELEGADO_ROOT/.delegado/current_mode" 2>/dev/null || echo "GENERAL")
    local vault_folder="${folder:-$VAULT_PATH/$(get_vault_folder $mode)}"
    
    mkdir -p "$vault_folder"
    
    local filename="$vault_folder/$(date +%Y%m%d)-${title// /-}.md"
    
    cat > "$filename" << EOF
---
type: delegado
mode: $mode
date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
---

$content
EOF
    
    log "Synced to Obsidian: $filename"
    echo "$filename"
}

#-------------------------------------------------------------------------------
# Main Command
#-------------------------------------------------------------------------------

show_help() {
    cat << 'EOF'
Delegado OS - Meta-Prompting Agent System

USAGE:
    delegado <command> [options]

COMMANDS:
    modes                    List all available agent modes
    activate <mode>          Activate an agent mode
    deactivate              Deactivate current mode
    search <query>           Search documentation (Context7)
    sync <file>              Sync content to Obsidian
    status                  Show current context
    hooks list              List available hooks
    hooks run <name>        Run a specific hook
    session new             Start new session
    session show           Show current session
    vars get <key>          Get variable
    vars set <key> <value>  Set variable

MODES:
    PROFESSOR    Teaching and documentation
    ARCHITECT    System design and patterns
    DEBUGGER     Bug analysis and debugging
    GUARDIAN     Security audits and protection
    RESEARCHER   Technology research and comparison
    MENTOR       Career development and growth
    CONSULTANT   Strategic advice and decisions

EXAMPLES:
    delegado modes
    delegado activate PROFESSOR
    delegado search "flutter state management"
    delegado sync ./notes.md "Flutter Patterns"
    delegado status

ENVIRONMENT:
    DELEGADO_ROOT      Set Delegado OS root path
    OBSIDIAN_VAULT     Set Obsidian vault path
    CONTEXT7_API_KEY   Context7 API key for doc search

EOF
}

#-------------------------------------------------------------------------------
# Main Entry Point
#-------------------------------------------------------------------------------

main() {
    local command="${1:-}"
    
    case "$command" in
        modes)
            show_modes
            ;;
        activate)
            activate_mode "$2"
            ;;
        deactivate)
            deactivate_mode
            ;;
        search)
            search_docs "$2" "$3"
            ;;
        sync)
            sync_to_obsidian "$(cat "$2")" "$3" "$4"
            ;;
        status)
            ensure_context
            cat "$CONTEXT_FILE"
            ;;
        hooks)
            shift
            handle_hooks "$@"
            ;;
        session)
            shift
            handle_session "$@"
            ;;
        vars)
            shift
            handle_vars "$@"
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            if [ -n "$command" ]; then
                error "Unknown command: $command"
            fi
            show_help
            ;;
    esac
}

handle_hooks() {
    local action="${1:-}"
    case "$action" in
        list)
            ls -1 "$DELEGADO_ROOT/scripts/hooks.d/" 2>/dev/null || echo "No hooks defined"
            ;;
        run)
            run_hook "$2"
            ;;
        *)
            echo "Usage: delegado hooks [list|run <name>]"
            ;;
    esac
}

handle_session() {
    ensure_context
    case "${1:-}" in
        new)
            rm -f "$DELEGADO_ROOT/.delegado/session_history"
            log "Started new session"
            ;;
        show)
            cat "$DELEGADO_ROOT/.delegado/context"
            ;;
        *)
            echo "Usage: delegado session [new|show]"
            ;;
    esac
}

handle_vars() {
    ensure_context
    case "${1:-}" in
        get)
            jq -r ".vars.${2} // empty" "$CONTEXT_FILE"
            ;;
        set)
            local key="$2"
            local value="$3"
            local current=$(cat "$CONTEXT_FILE")
            echo "$current" | jq --arg k "$key" --arg v "$value" '.vars[$k] = $v' > "$CONTEXT_FILE.tmp"
            mv "$CONTEXT_FILE.tmp" "$CONTEXT_FILE"
            log "Set $key = $value"
            ;;
        *)
            echo "Usage: delegado vars [get <key>|set <key> <value>]"
            ;;
    esac
}

# Run main
main "$@"
