---
name: dos-bmad
description: "BMAD Method — 4-phase development (Analysis → Planning → Solutioning → Implementation)"
argument-hint: "[1|2|3|4|status]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
Execute the BMAD (Brainstorm → Analysis → Method → Deploy) 4-phase development method.

Four phases with progressive context building:
1. ANALYSIS (optional) — Research and proposal
2. PLANNING (required) — PRD and specifications
3. SOLUTIONING — Architecture and design
4. IMPLEMENTATION — Tasks and code
</objective>

<context>
## BMAD 4 Fases

| ID | Fase | Cor | Opcional | Artefatos |
|----|------|-----|----------|-----------|
| 1 | ANALYSIS | #FF6B6B | Sim | proposal.md |
| 2 | PLANNING | #4ECDC4 | Não | prd.md, specs.md |
| 3 | SOLUTIONING | #45B7D1 | - | architecture.md, design.md |
| 4 | IMPLEMENTATION | #96CEB4 | - | tasks.md, código |

## Fluxo
```
┌─────────┐    ┌─────────┐    ┌────────────┐    ┌──────────────┐
│ ANALYSIS│───►│ PLANNING│───►│ SOLUTIONING│───►│IMPLEMENTATION│
└─────────┘    └─────────┘    └────────────┘    └──────────────┘
     │               │               │                  │
     ▼               ▼               ▼                  ▼
  proposta       PRD/specs       arquitetura         tasks/código
```

## Princípios

1. Contexto progressivo — cada fase informa a próxima
2. Artefatos como contratos — não implementar sem spec
3. Decisões documentadas — ADR para escolhas técnicas
4. Validação contínua — testar a cada bloco
</context>

<process>
Guide through BMAD 4-phase method:

Phase 1 (/dos-bmad:1 ou /dos-analysis):
- Research and gather evidence
- Create proposal.md with context and scope

Phase 2 (/dos-bmad:2 ou /dos-planning):
- Create prd.md with requirements
- Define specs.md with detailed specifications

Phase 3 (/dos-bmad:3 ou /dos-solutioning):
- Design architecture.md
- Create design.md with technical approach

Phase 4 (/dos-bmad:4 ou /dos-implementation):
- Generate atomic tasks.md
- Execute implementation with continuous validation

Use argument hint to jump to specific phase: /dos-bmad 1|2|3|4|status
</process>
