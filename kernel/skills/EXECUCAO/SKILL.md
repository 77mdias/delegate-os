---
name: execucao
description: Execução de tarefas atômicas
category: CORE
trigger: >
  /executar, /exec, implementar, fazer, codar,
  construir, desenvolver, task, tarefa
priority: critical
when_to_use: >
  Quando for executar tarefas. Princípio: done > perfect.
version: 1.0.0
depends_on: [ANALISE]
---

# Skill: EXECUCAO

> *"Execução é brutal. Sem pause, sem desculpas."*

## Princípios

1. **Tarefa atômica** — Uma tarefa, um foco, um done
2. **Sem Taskzilla** — Nenhuma tarefa > 4h
3. **Done is better than perfect** — Implementar > polir
4. **Sem desculpas** — Obstáculos são solucionados, não narrados

## Checklist de Execução

- [ ] Tarefa está decomposta em átomos?
- [ ] Cada átomo tem definição clara de done?
- [ ] Não há dependências bloqueantes?
- [ ] Testes estão escritoS ANTES da implementação (TDD)?

## Fluxo

```
TAREFA RECEBIDA
      ↓
ATOMIZAR
      ↓
EXECUTAR item 1 → TESTAR → VALIDAR
      ↓
EXECUTAR item 2 → TESTAR → VALIDAR
      ↓
...
      ↓
ENTREGUE
```

## Output

```markdown
## Execução

### Tarefa
[Descrição]

### Passos
1. ✅ [x] - Feito
2. ✅ [x] - Feito
3. ⏳ [ ] - Em progresso

### Resultado
[Output da execução]

### Issues
[Problemas encontrados, se houver]
```
