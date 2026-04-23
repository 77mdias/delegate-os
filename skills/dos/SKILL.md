---
name: dos
description: "Delegado OS — Context engineering + BMAD/OpenSpec/HELL workflows | /dos-help, /dos-bmad, /dos-hell, /dos-propose, /dos-specs, /dos-design, /dos-tasks, /dos-apply, /dos-verify"
argument-hint: "[help|bmad|hell|propose|specs|design|tasks|apply|verify|context|memory|learn|feedback]"
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

Sistema de meta-prompting para desenvolvimento de software assistido por IA com workflows BMAD, OpenSpec e HELL Method.
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

### 💀 HELL Method

| Command | Description |
|---------|-------------|
| /dos-hell | Show HELL help |
| /dos-hell:spec | HELL Specification — requirements + domain model |
| /dos-hell:tdd | TDD Cycle — Red/Green/Refactor |
| /dos-hell:refactor | GoF/GRASP refactor with smell detection |
| /dos-hell:evolve | CI/CD + tech debt tracking |
| /dos-hell:review | Deep review, feature suggestions, new specs |
| /dos-hell:audit | GRASP/GoF compliance audit |
| /dos-hell:milestone | Milestone gate — workflow checkpoint |
| /dos-hell:debt | Tech debt backlog management |
| /dos-hell:status | HELL cycle status dashboard |

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

### HELL Method (4 Fases + Gates)
```
SPEC ──► [M-SPEC] ──► TDD ──► [M-TEST] ──► REFACTOR ──► [M-QUALITY] ──► EVOLVE ──► [M-SHIP]
                                                                                        │
                                                                                    REVIEW
                                                                                        │
                                                                                   [M-REVIEW]
```
</context>

<process>
Route to appropriate sub-skill based on argument:
- help → /dos-help
- bmad → /dos-bmad
- hell → /dos-hell (HELL Method)
- hell:spec → /dos-hell:spec
- hell:tdd → /dos-hell:tdd
- hell:refactor → /dos-hell:refactor
- hell:evolve → /dos-hell:evolve
- hell:review → /dos-hell:review
- hell:audit → /dos-hell:audit
- hell:milestone → /dos-hell:milestone
- hell:debt → /dos-hell:debt
- hell:status → /dos-hell:status
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
