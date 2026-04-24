#!/bin/bash
#===============================================================================
# DELEGADO OS — Main Control Script
#===============================================================================
#
# Usage:
#   delegado.sh [command] [options]
#
# Examples:
#   ./delegado.sh menu                    # Interactive menu
#   ./delegado.sh setup                  # Initial setup
#   ./delegado.sh detectar               # Detect project stack
#   ./delegado.sh hell:spec [module]     # Run HELL spec phase
#   ./delegado.sh hell:tdd [module]      # Run HELL TDD cycle
#   ./delegado.sh hell:milestone M-TEST  # Run milestone gate
#   ./delegado.sh sync --obsidian        # Sync to Obsidian vault
#   ./delegado.sh memory --show          # Show memory contents
#   ./delegado.sh spawn [agent-type]     # Spawn sub-agent
#
#===============================================================================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

# Paths
DELEGADO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$DELEGADO_DIR")"
KERNEL_DIR="$PROJECT_ROOT/kernel"
SKILLS_DIR="$KERNEL_DIR/skills"
MEMORY_DIR="$PROJECT_ROOT/memory"
OBSIDIAN_VAULT="${OBSIDIAN_VAULT:-}"

# Version
VERSION="2.0.0"

#-------------------------------------------------------------------------------
# Helpers
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
    echo -e "${CYAN}[INFO]${NC} $1"
}

section() {
    echo ""
    echo -e "${MAGENTA}${BOLD}═══ $1 ═══${NC}"
}

#-------------------------------------------------------------------------------
# Check dependencies
#-------------------------------------------------------------------------------

check_deps() {
    local missing=()
    
    command -v git >/dev/null 2>&1 || missing+=(git)
    command -v node >/dev/null 2>&1 || missing+=(node)
    
    if [ ${#missing[@]} -ne 0 ]; then
        error "Missing dependencies: ${missing[*]}"
        exit 1
    fi
}

#-------------------------------------------------------------------------------
# Menu
#-------------------------------------------------------------------------------

show_menu() {
    section "DELEGADO OS v$VERSION — Main Menu"
    
    echo "  ${CYAN}HELL Method${NC}"
    echo "    hell:spec      → HELL Specification (GRASP domain model)"
    echo "    hell:tdd       → HELL TDD cycle (Red/Green/Refactor)"
    echo "    hell:refactor  → HELL Refactor (GoF patterns)"
    echo "    hell:evolve    → HELL Evolution (CI/CD + debt)"
    echo "    hell:audit     → HELL Audit (GRASP/SOLID compliance)"
    echo "    hell:review    → HELL Review (health score)"
    echo "    hell:milestone → Milestone gate checkpoint"
    echo "    hell:status    → HELL dashboard (all phases)"
    echo ""
    echo "  ${CYAN}Workflows${NC}"
    echo "    bmad          → BMAD 4-phase method"
    echo "    bmad:1        → ANALYSIS"
    echo "    bmad:2        → PLANNING"
    echo "    bmad:3        → SOLUTIONING"
    echo "    bmad:4        → IMPLEMENTATION"
    echo ""
    echo "  ${CYAN}Context & Memory${NC}"
    echo "    context       → Load/show context"
    echo "    memory        → Show memory"
    echo "    learn [rule]  → Teach new rule"
    echo "    feedback [t]  → Register feedback"
    echo ""
    echo "  ${CYAN}Obsidian${NC}"
    echo "    obsidian:init → Initialize vault structure"
    echo "    obsidian:sync → Sync context to vault"
    echo "    obsidian:new  → Create new note"
    echo ""
    echo "  ${CYAN}Agent${NC}"
    echo "    spawn [type]  → Spawn sub-agent"
    echo "    agents        → List available agents"
    echo "    status        → Agent status"
    echo ""
    echo "  ${CYAN}System${NC}"
    echo "    setup         → Initial setup"
    echo "    detectar      → Detect project stack"
    echo "    hooks:install → Install git hooks"
    echo "    hooks:uninstall → Remove git hooks"
    echo ""
    echo "  ${YELLOW}Usage: ./delegado.sh <command> [options]${NC}"
}

#-------------------------------------------------------------------------------
# HELL Commands
#-------------------------------------------------------------------------------

hell_spec() {
    local module="${1:-}"
    section "HELL SPEC — Specification Phase"
    
    if [ -z "$module" ]; then
        read -rp "Module name: " module
    fi
    
    log "Running HELL Specification for: $module"
    
    # Load HELL CORE ENGINE
    if [ -f "$KERNEL_DIR/hell/HELL-CORE-ENGINE.md" ]; then
        info "HELL CORE ENGINE loaded"
    fi
    
    # Create spec directory
    mkdir -p "$PROJECT_ROOT/specs/$module"
    
    # Load spec template
    if [ -f "$PROJECT_ROOT/templates/hell/hell-spec.template.md" ]; then
        cp "$PROJECT_ROOT/templates/hell/hell-spec.template.md" \
           "$PROJECT_ROOT/specs/$module/hell-spec-$module.md"
        log "Spec template created: specs/$module/hell-spec-$module.md"
    fi
    
    # Show HELL LOGIC GATE
    echo ""
    info "HELL LOGIC GATE — Execute before any code:"
    echo "  ① INFORMATION EXPERT — Who has the data?"
    echo "  ② PURE FABRICATION — Need artificial abstraction?"
    echo "  ③ PROTECTED VARIATIONS — What can change?"
    echo "  ④ INDIRECTION — Who mediates communication?"
    echo "  ⑤ POLYMORPHISM — Complex conditional?"
    echo ""
    
    # Prompt for GRASP analysis
    echo -e "${CYAN}GRASP Analysis Required:${NC}"
    echo "  - Information Expert: Who owns the data?"
    echo "  - Creator: What creates this entity?"
    echo "  - Controller: Where is business logic?"
    echo "  - Low Coupling: Dependencies?"
    echo "  - High Cohesion: Single responsibility?"
    echo ""
    
    log "HELL SPEC phase initiated. Edit specs/$module/hell-spec-$module.md"
}

hell_tdd() {
    local module="${1:-}"
    section "HELL TDD — Red/Green/Refactor Cycle"
    
    if [ -z "$module" ]; then
        read -rp "Module name: " module
    fi
    
    log "Running HELL TDD cycle for: $module"
    
    # Check if spec exists
    if [ ! -f "$PROJECT_ROOT/specs/$module/hell-spec-$module.md" ]; then
        warn "Spec not found. Run 'delegado.sh hell:spec $module' first"
        read -rp "Continue anyway? [y/N] " confirm
        if [ "$confirm" != "y" ]; then
            exit 0
        fi
    fi
    
    # Create TDD directory
    mkdir -p "$PROJECT_ROOT/tdd/$module"
    
    # TDD cycle
    echo ""
    info "TDD CYCLE: RED → GREEN → REFACTOR"
    echo ""
    echo -e "${RED}  🔴 RED — Write failing test${NC}"
    echo -e "${GREEN}  🟢 GREEN — Minimum code to pass${NC}"
    echo -e "${BLUE}  🔵 REFACTOR — Apply pattern, keep green${NC}"
    echo ""
    
    # Commit convention
    echo "  Commit format:"
    echo "    test: RED — [test_name]"
    echo "    feat: GREEN — [feature]"
    echo "    refactor: [pattern] — [justification]"
    echo ""
    
    log "TDD cycle initiated. Work in tdd/$module/"
}

hell_refactor() {
    local module="${1:-}"
    section "HELL REFACTOR — GoF Pattern Application"
    
    if [ -z "$module" ]; then
        read -rp "Module name: " module
    fi
    
    log "Running HELL Refactor for: $module"
    
    echo ""
    info "SMELL → PATTERN MAP:"
    echo "  Conditional Complexity    → Strategy / State"
    echo "  Constructor Overload     → Builder"
    echo "  God Class                → Facade + Decomposition"
    echo "  Tight Coupling           → Observer / Mediator"
    echo "  Duplicated Creation      → Factory Method"
    echo "  Feature Envy             → Move Method (Expert)"
    echo ""
    
    echo "  Safety rules:"
    echo "    1. Refactor ONE pattern at a time"
    echo "    2. Run ALL tests between each refactor"
    echo "    3. If test breaks → REVERT"
    echo "    4. Commit: refactor(GoF): [pattern] — [module]"
    echo ""
    
    log "Refactor initiated. Run /delegado hell:audit for smell detection."
}

hell_evolve() {
    local module="${1:-}"
    section "HELL EVOLVE — CI/CD + Tech Debt"
    
    log "Running HELL Evolution phase"
    
    echo ""
    info "EVOLUTION CHECKLIST:"
    echo "  □ CI/CD pipeline (lint → format → test → build → deploy)"
    echo "  □ Tech debt cataloged in memory/hell-tech-debt.md"
    echo "  □ Documentation synchronized"
    echo "  □ Monitoring and feedback loop"
    echo ""
    
    info "GATE M-SHIP criteria:"
    echo "  □ Pipeline green"
    echo "  □ Zero critical vulnerabilities"
    echo "  □ Debt catalogued"
    echo "  □ Docs 100% synced"
    echo ""
}

hell_audit() {
    local module="${1:-}"
    section "HELL AUDIT — GRASP/SOLID Compliance"
    
    log "Running HELL Audit"
    
    echo ""
    info "AUDIT CHECKLIST per class:"
    echo ""
    echo "  GRASP:"
    echo "    □ Information Expert — operates on OWN data?"
    echo "    □ Creator — creates entities it contains/uses?"
    echo "    □ Controller — no business logic in presentation?"
    echo "    □ Low Coupling — ≤3 deps from same level?"
    echo "    □ High Cohesion — ≤200 LOC or justified?"
    echo "    □ Polymorphism — no switch/if >3 branches?"
    echo "    □ Pure Fabrication — technical concerns separated?"
    echo "    □ Indirection — mediators where needed?"
    echo "    □ Protected Variations — interfaces for unstable points?"
    echo ""
    echo "  SOLID:"
    echo "    □ SRP — one reason to change?"
    echo "    □ OCP — open for extension, closed for modification?"
    echo "    □ LSP — subtypes substitute supertypes?"
    echo "    □ ISP — no forced dependency on unused methods?"
    echo "    □ DIP — depends on abstractions, not concretes?"
    echo ""
}

hell_milestone() {
    local type="${1:-}"
    section "HELL MILESTONE — Gate Checkpoint"
    
    if [ -z "$type" ]; then
        echo "Available gates: M-SPEC, M-TEST, M-QUALITY, M-SHIP, M-REVIEW"
        read -rp "Gate type: " type
    fi
    
    log "Running milestone gate: $type"
    
    echo ""
    info "VERDICT:"
    echo "  ✅ PASSED    — Score ≥90% + zero critical"
    echo "  ⚠️ CONDITIONAL — Score ≥70% + zero critical"
    echo "  ❌ BLOCKED   — Score <70% or critical failure"
    echo ""
}

hell_status() {
    section "HELL STATUS — Dashboard"
    
    echo ""
    echo "  Phase     | Gate      | Status"
    echo "  ----------|---------- |----------"
    echo "  SPEC      | M-SPEC    | ⬜ PENDING"
    echo "  TDD       | M-TEST    | ⬜ PENDING"
    echo "  REFACTOR  | M-QUALITY | ⬜ PENDING"
    echo "  EVOLVE   | M-SHIP    | ⬜ PENDING"
    echo "  REVIEW   | M-REVIEW  | ⬜ PENDING"
    echo ""
}

#-------------------------------------------------------------------------------
# Obsidian Commands
#-------------------------------------------------------------------------------

obsidian_init() {
    section "OBSIDIAN VAULT — Initialize"
    
    if [ -z "$OBSIDIAN_VAULT" ]; then
        read -rp "Obsidian vault path: " OBSIDIAN_VAULT
        export OBSIDIAN_VAULT
    fi
    
    log "Initializing vault at: $OBSIDIAN_VAULT"
    
    # Create structure
    mkdir -p "$OBSIDIAN_VAULT"/{00-INBOX,01-PROJECTS,02-PATTERNS/{GRASP,GoF},03-DASHBOARDS,04-TEMPLATES,05-ARCHIVE,06-REPOSITORIES}
    
    # Create agent registry
    cat > "$OBSIDIAN_VAULT/04-AGENTS/agent-registry.md" << 'EOF'
---
title: "Agent Registry"
type: agent-registry
agents: []
last_updated: 
---

# Agent Registry

## Active Agents

```dataview
TABLE agent_id, type, hell_phase_specialty, status
FROM "04-AGENTS"
WHERE type = "super-agent" OR type = "specialist"
SORT status DESC
```

## Agent Capabilities

| Agent | Runtime | HELL Phase Specialty | Status |
|-------|---------|---------------------|--------|
EOF
    
    # Create HELL dashboard
    cat > "$OBSIDIAN_VAULT/03-DASHBOARDS/HELL-Overview.md" << 'EOF'
---
title: "HELL Overview Dashboard"
type: hell-dashboard
last_updated: 
---

# HELL Overview

## Active Notes

```dataview
TABLE HELL_Phase, HELL_Gate, Patterns_GoF
FROM #hell
WHERE Status = "🔥 ACTIVE"
SORT Updated DESC
```

## Passed Gates

```dataview
TABLE Module, HELL_Phase, Coverage
FROM #hell
WHERE Status = "✅ DONE"
SORT Updated DESC
```

## Blocked Items

```dataview
LIST
FROM #hell
WHERE Status = "❌ BLOCKED"
```
EOF
    
    log "Vault initialized with structure:"
    echo "  00-INBOX/"
    echo "  01-PROJECTS/"
    echo "  02-PATTERNS/{GRASP,GoF}/"
    echo "  03-DASHBOARDS/"
    echo "  04-TEMPLATES/"
    echo "  05-ARCHIVE/"
    echo "  06-REPOSITORIES/"
}

obsidian_sync() {
    section "OBSIDIAN SYNC"
    
    if [ -z "$OBSIDIAN_VAULT" ]; then
        warn "OBSIDIAN_VAULT not set. Run: export OBSIDIAN_VAULT=/path/to/vault"
        return 1
    fi
    
    log "Syncing to: $OBSIDIAN_VAULT"
    
    # Sync specs
    if [ -d "$PROJECT_ROOT/specs" ]; then
        rsync -av "$PROJECT_ROOT/specs/" "$OBSIDIAN_VAULT/01-PROJECTS/" 2>/dev/null || \
            warn "Failed to sync specs"
    fi
    
    # Sync memory
    if [ -d "$PROJECT_ROOT/memory" ]; then
        rsync -av "$PROJECT_ROOT/memory/" "$OBSIDIAN_VAULT/05-ARCHIVE/" 2>/dev/null || \
            warn "Failed to sync memory"
    fi
    
    log "Sync complete"
}

#-------------------------------------------------------------------------------
# Git Hooks
#-------------------------------------------------------------------------------

hooks_install() {
    section "GIT HOOKS — Install"
    
    local hooks_dir="$PROJECT_ROOT/.git/hooks"
    local template_dir="$PROJECT_ROOT/scripts/git-hooks"
    
    # Create pre-commit
    cat > "$hooks_dir/pre-commit" << 'HOOK'
#!/bin/bash
# DELEGADO pre-commit hook

echo "[DELEGADO] Running pre-commit checks..."

# Run format check
if [ -f "package.json" ]; then
    if command -v npm >/dev/null 2>&1; then
        npm run lint --silent 2>/dev/null && echo "[DELEGADO] Lint passed" || {
            echo "[DELEGADO] Lint failed. Fix errors before committing."
            exit 1
        }
    fi
fi

# Run tests if exists
if [ -f "package.json" ]; then
    if npm run test --silent 2>/dev/null; then
        echo "[DELEGADO] Tests passed"
    else
        echo "[DELEGADO] Tests failed. Commit anyway? (Ctrl+C to abort)"
        read -t 5 && echo "[DELEGADO] Proceeding without tests..." || true
    fi
fi

echo "[DELEGADO] Pre-commit checks complete"
HOOK
    
    chmod +x "$hooks_dir/pre-commit"
    
    # Create commit-msg
    cat > "$hooks_dir/commit-msg" << 'HOOK'
#!/bin/bash
# DELEGADO commit-msg hook — validates HELL commit format

COMMIT_MSG=$(cat "$1")
PATTERN="^(feat|fix|docs|style|refactor|test|chore|test|perf|ci|build|revert)(\(.+\))?: .+"

if ! echo "$COMMIT_MSG" | grep -qE "$PATTERN"; then
    echo "[DELEGADO] Invalid commit format."
    echo "Expected: type(scope): message"
    echo "Types: feat, fix, docs, style, refactor, test, chore, perf, ci, build, revert"
    echo ""
    echo "HELL commit types:"
    echo "  test: RED — [test_name]     # TDD Red phase"
    echo "  feat: GREEN — [feature]    # TDD Green phase"
    echo "  refactor: [pattern] — [j]  # TDD Refactor or GoF refactor"
    exit 1
fi

echo "[DELEGADO] Commit format validated"
HOOK
    
    chmod +x "$hooks_dir/commit-msg"
    
    # Create pre-push
    cat > "$hooks_dir/pre-push" << 'HOOK'
#!/bin/bash
# DELEGADO pre-push hook

echo "[DELEGADO] Running pre-push checks..."

# Run full test suite
if [ -f "package.json" ]; then
    if command -v npm >/dev/null 2>&1; then
        echo "[DELEGADO] Running test suite..."
        npm test --silent 2>/dev/null || {
            echo "[DELEGADO] Tests failed. Push aborted."
            exit 1
        }
        echo "[DELEGADO] All tests passed"
    fi
fi

# Check for uncommitted HELL files
if [ -d "specs" ] || [ -d "tdd" ]; then
    if git diff --quiet; then
        echo "[DELEGADO] No uncommitted changes"
    else
        echo "[DELEGADO] Warning: Uncommitted specs/TDD files exist"
    fi
fi

echo "[DELEGADO] Pre-push checks complete"
HOOK
    
    chmod +x "$hooks_dir/pre-push"
    
    log "Git hooks installed:"
    echo "  pre-commit   — Lint + tests"
    echo "  commit-msg  — Format validation"
    echo "  pre-push    — Full test suite"
}

hooks_uninstall() {
    section "GIT HOOKS — Uninstall"
    rm -f "$PROJECT_ROOT/.git/hooks/pre-commit"
    rm -f "$PROJECT_ROOT/.git/hooks/commit-msg"
    rm -f "$PROJECT_ROOT/.git/hooks/pre-push"
    log "Git hooks removed"
}

#-------------------------------------------------------------------------------
# Setup
#-------------------------------------------------------------------------------

setup() {
    section "DELEGADO OS — Initial Setup"
    
    check_deps
    
    log "Setting up Delegado OS..."
    
    # Create memory directory
    mkdir -p "$MEMORY_DIR"
    
    # Create default memory files
    cat > "$MEMORY_DIR/PROJETO.md" << 'EOF'
# Projeto

## Stack
- **Linguagem**: 
- **Framework**: 
- **ORM**: 
- **Database**: 
- **Testing**: 

## Estrutura

## Setup Date
EOF

    cat > "$MEMORY_DIR/CONVENIOS.md" << 'EOF'
# Convenções Aprendidas

## Naming
| Tipo | Pattern | Exemplo |
|------|---------|---------|

## Imports

## Código
EOF

    cat > "$MEMORY_DIR/REGRAS.md" << 'EOF'
# Regras Aprendidas

## Preferências
| Regra | Valor | Data |
|-------|-------|------|

## Correções
| Situação | Antes | Depois | Data |
|----------|-------|--------|------|
EOF

    cat > "$MEMORY_DIR/FEEDBACK.md" << 'EOF'
# Feedback

## Entradas
| Feedback | Data | Ação |
|----------|------|------|

## Histórico
EOF
    
    # Install git hooks
    hooks_install
    
    # Check for Obsidian vault
    if [ -n "$OBSIDIAN_VAULT" ]; then
        read -rp "Initialize Obsidian vault at $OBSIDIAN_VAULT? [y/N] " confirm
        if [ "$confirm" = "y" ]; then
            obsidian_init
        fi
    fi
    
    log "Setup complete!"
}

#-------------------------------------------------------------------------------
# Detect project stack
#-------------------------------------------------------------------------------

detectar() {
    section "DETECTAR — Stack Detection"
    
    log "Detecting project stack..."
    
    echo ""
    
    # Language
    if [ -f "package.json" ]; then
        info "Language: Node.js/JavaScript/TypeScript"
        if grep -q '"typescript"' package.json 2>/dev/null; then
            echo "  → TypeScript detected"
        fi
    fi
    
    if [ -f "go.mod" ]; then
        info "Language: Go"
    fi
    
    if [ -f "Cargo.toml" ]; then
        info "Language: Rust"
    fi
    
    if [ -f "requirements.txt" ] || [ -f "setup.py" ]; then
        info "Language: Python"
    fi
    
    # Framework
    if [ -f "package.json" ]; then
        if grep -q '"next"' package.json 2>/dev/null; then
            echo "  → Framework: Next.js"
        fi
        if grep -q '"react"' package.json 2>/dev/null; then
            echo "  → Framework: React"
        fi
        if grep -q '"vue"' package.json 2>/dev/null; then
            echo "  → Framework: Vue"
        fi
    fi
    
    # Test framework
    if [ -f "package.json" ]; then
        if grep -q '"jest"' package.json 2>/dev/null; then
            echo "  → Test: Jest"
        fi
        if grep -q '"vitest"' package.json 2>/dev/null; then
            echo "  → Test: Vitest"
        fi
    fi
    
    # Git
    if [ -d ".git" ]; then
        info "Git: Repository initialized"
    else
        warn "Git: Not a repository"
    fi
    
    echo ""
    
    # Conventions
    if [ -f ".eslintrc" ] || [ -f "eslint.config" ]; then
        info "Linter: ESLint configured"
    fi
    
    if [ -f ".prettierrc" ] || [ -f "prettier.config" ]; then
        info "Formatter: Prettier configured"
    fi
    
    log "Detection complete"
}

#-------------------------------------------------------------------------------
# Spawn sub-agent
#-------------------------------------------------------------------------------

spawn() {
    local agent_type="${1:-}"
    
    if [ -z "$agent_type" ]; then
        echo "Available agents:"
        echo "  analyst    — HELL SPEC specialist"
        echo "  coder      — HELL TDD specialist"
        echo "  review     — HELL REFACTOR/REVIEW specialist"
        echo "  devops     — HELL EVOLVE specialist"
        return
    fi
    
    section "SPAWN — $agent_type agent"
    
    case "$agent_type" in
        analyst)
            info "Spawning: Analyst Agent (SPEC specialist)"
            ;;
        coder)
            info "Spawning: Coder Agent (TDD specialist)"
            ;;
        review)
            info "Spawning: Review Agent (REFACTOR/REVIEW specialist)"
            ;;
        devops)
            info "Spawning: DevOps Agent (EVOLVE specialist)"
            ;;
        *)
            error "Unknown agent type: $agent_type"
            return 1
            ;;
    esac
    
    log "Sub-agent spawning requires runtime support (sessions_spawn)"
    info "For OpenClaw: Use sessions_spawn tool directly"
}

#-------------------------------------------------------------------------------
# Main
#-------------------------------------------------------------------------------

main() {
    local command="${1:-}"
    local arg="${2:-}"
    
    check_deps
    
    case "$command" in
        menu|"")
            show_menu
            ;;
        setup)
            setup
            ;;
        detectar)
            detectar
            ;;
        hell:spec)
            hell_spec "$arg"
            ;;
        hell:tdd)
            hell_tdd "$arg"
            ;;
        hell:refactor)
            hell_refactor "$arg"
            ;;
        hell:evolve)
            hell_evolve "$arg"
            ;;
        hell:audit)
            hell_audit "$arg"
            ;;
        hell:review)
            warn "Use /delegado hell:review in agent context"
            ;;
        hell:milestone)
            hell_milestone "$arg"
            ;;
        hell:status)
            hell_status
            ;;
        obsidian:init)
            obsidian_init
            ;;
        obsidian:sync)
            obsidian_sync
            ;;
        hooks:install)
            hooks_install
            ;;
        hooks:uninstall)
            hooks_uninstall
            ;;
        spawn)
            spawn "$arg"
            ;;
        agents)
            info "Super-Agents: Noir (OpenClaw), Hermes (Meta-Orchestrator)"
            info "CLI-Agents: Claude Code, Codex"
            ;;
        status)
            info "Agent: Active"
            info "HELL Phase: Unknown (context required)"
            ;;
        *)
            error "Unknown command: $command"
            echo ""
            show_menu
            exit 1
            ;;
    esac
}

main "$@"
