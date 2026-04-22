---
name: bmad-implementation
description: Fase 4 - Implementation
category: BMAD_PHASE
trigger: /implementation, /bmad-4, /implement, /build
priority: critical
when_to_use: >
  Quando arquitetura e design estiverem prontos.
  Execução atomic com validação contínua.
version: 1.0.0
depends_on: [SOLUTIONING]
---

# BMAD Phase 4: IMPLEMENTATION

> *"Execução é brutal. Done > Perfect."*

## Tarefas Atômicas

### Regra de Ouro
- Nenhuma tarefa > 4h
- atomic = executável em uma sessão

### Blocos de Trabalho

```markdown
## Tasks: [feature]

### Bloco 1: Setup
- [ ] Task 1.1
- [ ] Task 1.2

### Bloco 2: Core
- [ ] Task 2.1

### Bloco 3: Integration
- [ ] Task 3.1
```

## Validação

Após cada bloco:
- [ ] Tests passando
- [ ] Lint passando
- [ ] Type-check passando
- [ ] Build succeeds

## Output

```markdown
## Implementation Complete

### Tasks Executadas
- [x] 1.1 - Feito
- [x] 1.2 - Feito

### Validation
- ✅ Tests
- ✅ Lint
- ✅ Type-check
- ✅ Build

### Artefatos Gerados
- [files]
```
