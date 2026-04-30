# 🎛️ MODE ORCHESTRATOR — Automatic Mode Selection System

> *"O modo certo, na hora certa, para o problema certo."*

---

## Overview

Mode Orchestrator é o cérebro que detecta automaticamente qual modo de agente deve ser ativado baseado no contexto da conversa.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      MODE ORCHESTRATOR FLOW                               │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  USER INPUT                                                              │
│      │                                                                   │
│      ▼                                                                   │
│  ┌─────────────────┐                                                    │
│  │ CONTEXT SCANNER │ ──► Extrai: Keywords, Stack, Intent, Complexity     │
│  └────────┬────────┘                                                    │
│           │                                                              │
│           ▼                                                              │
│  ┌─────────────────┐                                                    │
│  │ MODE MATCHER    │ ──► Score: [PROFESSOR: 0.8, ARCHITECT: 0.3...]    │
│  └────────┬────────┘                                                    │
│           │                                                              │
│           ▼                                                              │
│  ┌─────────────────┐                                                    │
│  │ MODE RESOLVER   │ ──► Se ambiguidade → Perguntar usuário            │
│  └────────┬────────┘     Se claro → Ativar modo                       │
│           │                                                              │
│           ▼                                                              │
│  ┌─────────────────┐                                                    │
│  │ MODE ACTIVATOR  │ ──► Carrega SKILL.md, contexto, executa           │
│  └─────────────────┘                                                    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Mode Matching Table

| Input Keywords | Primary Mode | Secondary Mode | Confidence |
|----------------|--------------|----------------|------------|
| ensinar, aprender, tutorial, como funciona | **PROFESSOR** | - | 0.95 |
| arquitetura, pattern, design, grasp, gof | **ARCHITECT** | - | 0.90 |
| bug, erro, falha, crash, não funciona | **DEBUGGER** | - | 0.95 |
| segurança, vulnerability, auth, inject | **GUARDIAN** | - | 0.90 |
| biblioteca, package, widget, comparar | **RESEARCHER** | - | 0.85 |
| carreira, crescer, senior, promoção | **MENTOR** | - | 0.90 |
| consultar, sugestão, melhor prática | **CONSULTANT** | - | 0.85 |
| explicar + código | **PROFESSOR** | DEBUGGER | 0.80 |
| pattern + performance | **ARCHITECT** | RESEARCHER | 0.75 |
| bug + segurança | **GUARDIAN** | DEBUGGER | 0.85 |

---

## Intent Detection Matrix

```yaml
INTENTS:
  LEARNING:
    keywords: ["ensinar", "aprender", "tutorial", "como", "explicar", "entender"]
    mode: PROFESSOR
    priority: 1

  DESIGNING:
    keywords: ["arquitetura", "design", "pattern", "estrutura", "sistema"]
    mode: ARCHITECT
    priority: 1

  DEBUGGING:
    keywords: ["bug", "erro", "falha", "crash", "problema", "não funciona", "debug"]
    mode: DEBUGGER
    priority: 1

  SECURING:
    keywords: ["segurança", "seguro", "vulnerabilidade", "auth", "proteger"]
    mode: GUARDIAN
    priority: 1

  RESEARCHING:
    keywords: ["biblioteca", "package", "melhor", "comparar", "alternativa"]
    mode: RESEARCHER
    priority: 1

  MENTORING:
    keywords: ["carreira", "sênior", "junior", "crescer", "promoção", "entrevista"]
    mode: MENTOR
    priority: 1

  ADVISING:
    keywords: ["consultar", "opinião", "sugestão", "decisão", "prós contras"]
    mode: CONSULTANT
    priority: 1
```

---

## Stack Detection

```yaml
STACKS:
  flutter:
    patterns: ["flutter", "dart", "widget", "riverpod", "bloc", "stateful"]
    related_modes: [PROFESSOR, DEBUGGER, ARCHITECT]

  react:
    patterns: ["react", "jsx", "hooks", "redux", "next", "component"]
    related_modes: [PROFESSOR, DEBUGGER, ARCHITECT]

  nodejs:
    patterns: ["node", "express", "npm", "javascript", "typescript"]
    related_modes: [ARCHITECT, DEBUGGER]

  python:
    patterns: ["python", "django", "fastapi", "flask"]
    related_modes: [ARCHITECT, RESEARCHER]

  devops:
    patterns: ["docker", "kubernetes", "ci/cd", "jenkins", "github actions"]
    related_modes: [GUARDIAN, ARCHITECT]

  database:
    patterns: ["sql", "postgres", "mysql", "mongodb", "redis"]
    related_modes: [ARCHITECT, DEBUGGER]
```

---

## Complexity Scoring

```python
def calculate_complexity(input_text: str) -> str:
    """
    Score: 1-10
    Low (1-3): Simple question, single mode
    Medium (4-6): Multi-part, may need secondary mode
    High (7-10): Complex, may need mode switching
    """
    
    complexity_indicators = {
        # Increases complexity
        "arquitetura": +2,
        "sistema": +2,
        "performance": +1,
        "escalabilidade": +2,
        "segurança": +2,
        "pattern": +1,
        "múltiplos": +1,
        "vários": +1,
        "comparar": +1,
        
        # Decreases complexity
        "básico": -2,
        "simples": -2,
        "como": -1,
        "exemplo": -1,
        "o que é": -1,
    }
    
    score = 5  # Baseline
    for indicator, delta in complexity_indicators.items():
        if indicator in input_text.lower():
            score += delta
    
    return max(1, min(10, score))
```

---

## Mode Switching Protocol

### When to Switch Modes

| Condition | Action |
|-----------|--------|
| User introduces new topic with different mode | Switch to new mode, offer to log context |
| Task reveals hidden complexity | Suggest secondary mode |
| Mode reports completion | Offer next logical mode |
| User explicitly requests mode | Switch immediately |

### Mode Handoff Template

```markdown
## 🔄 Mode Handoff

**From:** [PROFESSOR]
**To:** [ARCHITECT]
**Reason:** [User now wants to implement what they learned]

### Context Preserved
- [Context item 1]
- [Context item 2]

### User Intent
[What user wants to do next]

### Suggested Next Actions
1. [Action 1]
2. [Action 2]
```

---

## Auto-Detection Examples

### Example 1: "Me ensina TDD"
```
Input: "Me ensina TDD"

Analysis:
  - Intent: LEARNING
  - Keywords: [ensinar, tdd]
  - Stack: null
  - Complexity: 3 (básico)

Decision:
  - Primary Mode: PROFESSOR
  - Confidence: 0.95
  - Action: Load PROFESSOR skill, teach TDD

Response:
  "📚 Entendido! Vou te ensinar TDD. Qual seu nível atual?"
```

### Example 2: "Tenho um bug no login e acho que pode ser de segurança"
```
Input: "bug no login e pode ser segurança"

Analysis:
  - Intent: DEBUGGING + SECURING
  - Keywords: [bug, login, segurança]
  - Stack: null
  - Complexity: 5

Decision:
  - Primary Mode: GUARDIAN (higher priority for security)
  - Secondary Mode: DEBUGGER
  - Confidence: 0.85
  - Action: Load GUARDIAN, analyze security + debug

Response:
  "🛡️ Analisando: bug no login com possível ângulo de segurança."
```

### Example 3: "Qual a melhor biblioteca de state management pro Flutter?"
```
Input: "melhor biblioteca state management flutter"

Analysis:
  - Intent: RESEARCHING
  - Keywords: [melhor, biblioteca, flutter]
  - Stack: flutter
  - Complexity: 4

Decision:
  - Primary Mode: RESEARCHER
  - Secondary Mode: ARCHITECT (for pattern advice)
  - Confidence: 0.85
  - Action: Load RESEARCHER, compare options, use Context7

Response:
  "📡 Pesquisando as melhores opções de state management para Flutter..."
```

---

## Obsidian Integration

Mode Orchestrator logs all mode switches:

```markdown
# 📊 Mode Orchestrator Log

## Session: [DATE]

| Time | Mode | Trigger | Context |
|------|------|---------|---------|
| 10:00 | PROFESSOR | "ensinar tdd" | Level: beginner |
| 10:15 | ARCHITECT | "implementar" | Module: auth |
| 10:45 | DEBUGGER | "bug na api" | Severity: medium |
```

Path: `vault/90-LOGS/mode-orchestrator/[DATE].md`

---

## Commands

| Command | Action |
|---------|--------|
| `/delegado modes` | Show all available modes |
| `/delegado mode [name]` | Force specific mode |
| `/delegado mode auto` | Enable auto-detection |
| `/delegado mode log` | Show recent mode switches |
| `/delegado mode analyze` | Analyze current input |

---

## Extensibility

Add new mode:

```yaml
1. Create: subagents/[NEW_MODE]/SKILL.md
2. Add to MODE_MATCHING_TABLE
3. Add to INTENT_DETECTION
4. Create vault path
5. Update this file
```

---

*Mode Orchestrator: Right mode, right time, right problem.*
