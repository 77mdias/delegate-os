---
name: bmad-solutioning
description: Fase 3 - Solutioning
category: BMAD_PHASE
trigger: /solutioning, /bmad-3, /architecture, /design
priority: critical
when_to_use: >
  Quando PRD e specs estiverem prontos.
  Cria arquitetura e design técnico.
version: 1.0.0
depends_on: [PLANNING]
---

# BMAD Phase 3: SOLUTIONING

> *"Design antes de destruir. Arquitetura é destino."*

## Artefatos

### architecture.md
```markdown
## Architecture: [feature]

### Overview
[Arquitetura de alto nível]

### Components
| Component | Responsibility | API |

### Data Model
[Schema/entities]

### ADR (Architecture Decisions)
1. **[DECISION]** [Título]
   - Context: [situação]
   - Decision: [escolha]
   - Consequences: [impacto]
```

### design.md
```markdown
## Design: [feature]

### Technical Approach
[Como vamos implementar]

### File Structure
```
src/
```

### Integration Points
- [Service A] - [contrato]
```

## Checklist

- [ ] Architecture decisions documentadas (ADR)
- [ ] Component structure defined
- [ ] Integration patterns specified
- [ ] Data model finalized
- [ ] Design review approved

## Output

```markdown
## Solutioning Complete

### Architecture
✅ [status]

### ADRs
[n] decisões documentadas

### Design
✅ [status]

### Readiness
[READY/NOT_READY] para Implementation
```
