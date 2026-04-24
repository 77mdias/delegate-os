# Delegado OS - Quick Start

## 1. Activate a Mode

```bash
./scripts/delegate.sh activate PROFESSOR
```

## 2. Use the Mode

The agent will automatically:
- Load the mode's SKILL.md
- Set up Obsidian vault folder
- Run pre-mode hooks
- Ready to assist with mode-specific tasks

## 3. Commands

```bash
# List all modes
./scripts/delegate.sh modes

# Activate a mode
./scripts/delegate.sh activate ARCHITECT

# Search docs with Context7
./scripts/delegate.sh search "python testing patterns"

# Sync content to Obsidian
./scripts/delegate.sh sync ./notes.md "My Notes"

# Run self-analysis
./scripts/auto_improve.sh all
```

## 4. Mode Selection

**Automatic:** Just describe what you need and the mode selector will detect:

```
"me ensina TDD" → PROFESSOR mode
"como estruturar esse projeto?" → ARCHITECT mode
"esse bug tá difícil" → DEBUGGER mode
"revisar segurança do login" → GUARDIAN mode
```

**Manual:** Use `/delegado` prefix:
```
/delegado professor "React hooks"
/delegado architect "microservices pattern"
/delegado debugger analyze
```

## 5. Environment Variables

```bash
export DELEGADO_ROOT=/path/to/delegate-os
export OBSIDIAN_VAULT=~/obsidian-vault
export CONTEXT7_API_KEY=your_api_key
```

---

*Auto-generated*
