---
name: bmad-planning
description: Fase 2 - Planning (required)
category: BMAD_PHASE
trigger: /planning, /bmad-2, /prd, requirements
priority: critical
when_to_use: >
  Quando for iniciar planejamento de feature.
  Esta fase é OBRIGATÓRIA antes de solutioning.
version: 1.0.0
depends_on: [ANALYSIS]
---

# BMAD Phase 2: PLANNING

> *"Planejo como estrategista. Requirements são lei."*

## Artefatos

### prd.md (12 passos)
1. Initialize context
2. Understand product vision
3. Articulate product direction
4. Summarize key points
5. Define success metrics
6. Map user journeys
7. Define domain model
8. Identify innovation opportunities
9. Classify project type
10. Scope MVP
11. Detail functional requirements
12. Detail non-functional requirements

### specs.md
```markdown
## Specs: [feature]

### User Story 1
Como [usuário]
Quero [funcionalidade]
Para [benefício]

### Critérios de Aceite
- [ ] Dado [contexto] quando [ação] então [resultado]
```

## Checklist

- [ ] PRD completo com 12 seções
- [ ] User stories mapeadas
- [ ] Domain model definido
- [ ] MVP scoped
- [ ] NFRs documentados

## Output

```markdown
## Planning Complete

### PRD
✅ [status]

### Specs  
### [n] user stories
### [m] critérios de aceite

### Readiness
[READY/NOT_READY] para Solutioning
```
