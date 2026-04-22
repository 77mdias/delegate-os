---
name: bmad
description: BMad Method - 4 fases de desenvolvimento
category: WORKFLOW
trigger: >
  /bmad, /analysis, /planning, /solutioning, /implementation,
  fases, workflow, methodology
priority: high
when_to_use: >
  Para qualquer tarefa que precise de metodologia estruturada.
  BMad Method garante contexto progressivo através de 4 fases.
version: 1.0.0
depends_on: []
---

# Skill: BMad Method

> *"Quatro fases. Contexto progressivo. Agentes sempre sabem o que construir."*

## 4 Fases

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

## Sub-skills

- **BMAD/ANALYSIS** - Brainstorm e pesquisa
- **BMAD/PLANNING** - PRD e requirements  
- **BMAD/SOLUTIONING** - Arquitetura e design
- **BMAD/IMPLEMENTATION** - Execução e validação

## Princípios

1. **Contexto progressivo** - Cada fase informa a próxima
2. **Artefatos como contratos** - Não implementar sem spec
3. **Decisões documentadas** - ADR para escolhas técnicas
4. **Validação contínua** - Testar a cada bloco
