# 🪝 DELEGADO OS — HOOKS SYSTEM
## Automated Execution Hooks

> *"Hooks permitem que Delegado OS aja proativamente, sem esperar ser perguntado."*

---

## Hook Categories

```
┌────────────────────────────────────────────────────────────────┐
│                         HOOKS SYSTEM                             │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PRE-HOOKS (antes de qualquer ação)                            │
│  ├── pre_execute: Validar contexto antes de executar           │
│  ├── pre_commit: Verificar git antes de commitar               │
│  ├── pre_deploy: Validar antes de deploy                       │
│  └── pre_mode_switch: Validar antes de trocar modo             │
│                                                                 │
│  POST-HOOKS (após ações)                                       │
│  ├── post_execute: Registrar resultado de execução             │
│  ├── post_commit: Sincronizar com Obsidian                     │
│  ├── post_deploy: Verificar saúde após deploy                  │
│  ├── post_mode_complete: Sugerir próximo modo                   │
│  └── post_learn: Atualizar memória                             │
│                                                                 │
│  EVENT-HOOKS (triggers específicos)                            │
│  ├── on_error: Auto-debug quando erro detectado                 │
│  ├── on_context_gap: Perguntar contexto faltante               │
│  ├── on_pattern_detected: Sugerir pattern applicable           │
│  ├── on_debt_discovered: Registrar debt                        │
│  └── on_milestone: Celebrar e documentar                      │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

---

## PRE-HOOKS

### pre_execute Hook

```bash
#!/bin/bash
# pre_execute: Validates context before any execution

validate_context() {
    local task="$1"
    
    # Check if we have enough context
    if [[ -z "$task" ]]; then
        echo "⚠️  [HOOK] Tarefa vazia - pulando"
        return 1
    fi
    
    # Check for ambiguous requirements
    local ambiguous_words=("talvez" "sei lá" "não sei" "acho")
    for word in "${ambiguous_words[@]}"; do
        if [[ "$task" == *"$word"* ]]; then
            echo "⚠️  [HOOK] Requisitos ambíguos detectados: '$word'"
            echo "💡  [HOOK] Suggestion: Detalhe mais o que precisa"
            return 1
        fi
    done
    
    # Check git status if modifying code
    if [[ "$task" == *"implementar"* || "$task" == *"criar"* ]]; then
        git_status=$(git status --porcelain 2>/dev/null)
        if [[ -n "$git_status" ]]; then
            echo "📝  [HOOK] Working tree dirty - considere commitar primeiro"
        fi
    fi
    
    echo "✅  [HOOK] Contexto válido"
    return 0
}
```

### pre_commit Hook

```bash
#!/bin/bash
# pre_commit: Validates code before git commit

pre_commit_check() {
    # Run linter
    if command -v ruff &> /dev/null; then
        echo "🔍  [HOOK] Running linter..."
        ruff check . 2>&1 || {
            echo "❌  [HOOK] Linter failed - corrija antes de commitar"
            return 1
        }
    fi
    
    # Run tests (if exists)
    if [ -f "pytest.ini" ] || [ -d "tests" ]; then
        echo "🧪  [HOOK] Running tests..."
        pytest --tb=short -q 2>&1 || {
            echo "❌  [HOOK] Tests failed - corrija antes de commitar"
            return 1
        }
    fi
    
    # Check for sensitive data
    if grep -r "password\s*=" --include="*.py" . 2>/dev/null | grep -v ".env" | grep -v "#"; then
        echo "🔐  [HOOK] Possible hardcoded password detected!"
        return 1
    fi
    
    echo "✅  [HOOK] Pre-commit check passed"
    return 0
}
```

---

## POST-HOOKS

### post_execute Hook

```bash
#!/bin/bash
# post_execute: Records execution result

post_execute() {
    local status="$1"  # success|failure
    local duration="$2"
    local command="$3"
    
    log_entry=$(cat <<EOF
## Execution Log — $(date '+%Y-%m-%d %H:%M:%S')

| Field | Value |
|-------|-------|
| Status | $status |
| Duration | ${duration}s |
| Command | $command |

EOF
)
    
    # Append to log
    echo "$log_entry" >> "vault/90-LOGS/executions/$(date '+%Y-%m').md"
    
    if [[ "$status" == "failure" ]]; then
        echo "🔴  [HOOK] Execution failed after ${duration}s"
        echo "💡  [HOOK] Suggestion: /delegado debugger analyze last error"
    else
        echo "🟢  [HOOK] Execution completed in ${duration}s"
    fi
}
```

### post_learn Hook

```bash
#!/bin/bash
# post_learn: Updates memory when new rules are taught

post_learn() {
    local rule="$1"
    local context="$2"
    local file="memory/rules/$(date '+%Y-%m-%d')-$(echo "$rule" | slugify).md"
    
    mkdir -p "$(dirname "$file")"
    
    cat > "$file" <<EOF
# Learned Rule: $rule

## Date Learned
$(date '+%Y-%m-%d %H:%M:%S')

## Context
$context

## Rule
$rule

## Source
[How this was learned]

## Verified
- [ ] Not yet verified
- [ ] Verified working
EOF
    
    echo "🧠  [HOOK] Rule learned and saved to: $file"
    
    # Update index
    echo "- [[$file|$rule]]" >> "memory/rules/INDEX.md"
}
```

---

## EVENT-HOOKS

### on_error Hook

```bash
#!/bin/bash
# on_error: Automatically triggers debugger when errors detected

on_error() {
    local error_output="$1"
    local error_type="$2"
    
    echo "🐛  [HOOK] Error detected — triggering DEBUGGER"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "$error_output"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Categorize error
    case "$error_output" in
        *"SyntaxError"*|*"IndentationError"*)
            echo "📋  [HOOK] Type: Syntax error — likely quick fix"
            ;;
        *"ImportError"*|*"ModuleNotFoundError"*)
            echo "📋  [HOOK] Type: Missing dependency"
            ;;
        *"Exception"*|*"Error"*)
            echo "📋  [HOOK] Type: Runtime exception — needs analysis"
            ;;
        *)
            echo "📋  [HOOK] Type: Unknown — manual inspection needed"
            ;;
    esac
    
    # Auto-suggestions
    echo ""
    echo "💡  [HOOK] Suggestions:"
    echo "    /delegado debugger analyze"
    echo "    /delegado guardian security_check"
}
```

### on_pattern_detected Hook

```bash
#!/bin/bash
# on_pattern_detected: Suggests patterns when code smells detected

on_pattern_detected() {
    local smell="$1"
    local file="$2"
    local line="$3"
    
    echo "🔍  [HOOK] Pattern smell detected in $file:$line"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Map smell to pattern
    case "$smell" in
        *"long method"*)
            echo "💡  Suggestion: Extract Method (GoF)"
            echo "   OR split into classes using Single Responsibility"
            ;;
        *"cyclomatic complexity"*)
            echo "💡  Suggestion: Strategy or State pattern (GoF)"
            ;;
        *"shotgun surgery"*)
            echo "💡  Suggestion: Move Method or Class"
            ;;
        *"data class"*)
            echo "💡  Suggestion: Replace Data with Command or Strategy"
            ;;
        *"message chain"*)
            echo "💡  Suggestion: Hide Delegate (GoF)"
            ;;
        *"god class"*)
            echo "💡  Suggestion: Facade + decompose (GoF)"
            ;;
        *"primitive obsession"*)
            echo "💡  Suggestion: Replace Data Value with Object (GRASP)"
            ;;
        *)
            echo "💡  Suggestion: Review with /delegado architect review"
            ;;
    esac
    
    echo ""
    echo "💾  [HOOK] Logged to: vault/30-BUGS/smells/$(date '+%Y-%m-%d').md"
}
```

### on_milestone Hook

```bash
#!/bin/bash
# on_milestone: Celebrates and documents milestones

on_milestone() {
    local milestone="$1"
    local metrics="$2"
    
    echo "🎉  ═══════════════════════════════════════════════"
    echo "🎉  ═                                              ║"
    echo "🎉  ║  🎊 MILESTONE ACHIEVED: $milestone          ║"
    echo "🎉  ║                                              ║"
    echo "🎉  ═══════════════════════════════════════════════"
    
    # Log to achievements
    cat >> "vault/90-LOGS/achievements/$(date '+%Y').md" <<EOF

## 🎯 Milestone: $milestone

**Date:** $(date '+%Y-%m-%d %H:%M:%S')
**Metrics:** $metrics

### What this means
[Description of achievement]

### What's next
[Next milestone to aim for]

EOF
    
    echo "📝  [HOOK] Documented in vault/90-LOGS/achievements/"
    echo "🚀  [HOOK] Ready for next challenge!"
}
```

---

## HOOK CONFIGURATION

```yaml
# hooks.yaml
hooks:
  enabled: true
  
  pre_execute:
    enabled: true
    validate_context: true
    check_git_status: true
    
  pre_commit:
    enabled: true
    run_linter: true
    run_tests: true
    check_secrets: true
    
  post_execute:
    enabled: true
    log_to_obsidian: true
    
  post_learn:
    enabled: true
    update_index: true
    
  on_error:
    enabled: true
    auto_debugger: true
    
  on_pattern_detected:
    enabled: true
    suggest_pattern: true
    
  on_milestone:
    enabled: true
    celebrate: true
    document: true
```

---

## Custom Hooks Template

```bash
#!/bin/bash
# custom_hook_TEMPLATE.sh
# Use this template to create your own hooks

# Hook name must match filename
HOOK_NAME="custom_hook"

execute_custom_hook() {
    local trigger_event="$1"
    local payload="$2"
    
    echo "🪝  [HOOK:$HOOK_NAME] Triggered by: $trigger_event"
    
    # Your custom logic here
    case "$trigger_event" in
        "on_code_change")
            handle_code_change "$payload"
            ;;
        "on_api_call")
            handle_api_call "$payload"
            ;;
        *)
            echo "⚠️  [HOOK:$HOOK_NAME] Unknown trigger: $trigger_event"
            ;;
    esac
}
```

---

## Installation

```bash
# Install hooks in your project
./delegado.sh hooks install

# List available hooks
./delegado.sh hooks list

# Enable/disable specific hook
./delegado.sh hooks enable pre_commit
./delegado.sh hooks disable on_error

# Run hook manually
./delegado.sh hooks run on_milestone "Feature X completed" "tests: 100%, coverage: 85%"
```

---

*Hooks: Making Delegado OS work while you sleep.*
