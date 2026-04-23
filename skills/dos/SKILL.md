---
name: dos
description: "Delegado OS — Context engineering + BMAD/OpenSpec workflows | /dos-help, /dos-bmad, /dos-propose, /dos-specs, /dos-design, /dos-tasks, /dos-apply, /dos-verify"
argument-hint: "[help|bmad|propose|specs|design|tasks|apply|verify|context|memory|learn|feedback]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
Delegado OS — AI Agent Operating System

"O contexto é poder. A memória é força. A execução é brutal."

Sistema de meta-prompting para desenvolvimento de software assistido por IA com workflows BMAD e OpenSpec.
</objective>

<context>
## Commands

| Command | Description |
|---------|-------------|
| /dos-help | Show this help |
| /dos-bmad | BMAD 4-phase method |
| /dos-propose | Create change proposal |
| /dos-specs | Create specifications |
| /dos-design | Create technical design |
| /dos-tasks | Generate atomic tasks |
| /dos-apply | Execute pending tasks |
| /dos-verify | Verify implementation |
| /dos-context | Load project context |
| /dos-memory | Show memory |
| /dos-learn | Teach new rule |
| /dos-feedback | Register feedback |

## Workflows

### BMAD (4 Fases)
| Fase | Cor | Artefatos |
|------|-----|-----------|
| ANALYSIS | #FF6B6B | proposal.md |
| PLANNING | #4ECDC4 | prd.md, specs.md |
| SOLUTIONING | #45B7D1 | architecture.md |
| IMPLEMENTATION | #96CEB4 | tasks.md |

### OpenSpec
proposal → specs → design → tasks → implement
</context>

<process>
Route to appropriate sub-skill based on argument:
- help → /dos-help
- bmad → /dos-bmad
- propose → /dos-propose
- specs → /dos-specs
- design → /dos-design
- tasks → /dos-tasks
- apply → /dos-apply
- verify → /dos-verify
- context → /dos-context
- memory → /dos-memory
- learn → /dos-learn
- feedback → /dos-feedback

Or display this help if no argument.
</process>
