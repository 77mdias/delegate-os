---
name: planejamento
description: Decomposição e planejamento
category: CORE
trigger: >
  /planejar, /plano, decompor, roadmap, tasks,
  planejamento, próximo passo, como fazer
priority: high
when_to_use: >
  Quando precisar planejar implementação ou decompor tarefas.
version: 1.0.0
depends_on: [ANALISE]
---

# Skill: PLANEJAMENTO

> *"Planejo como um estrategista. Decomponho como um cirurgião."*

## Decomposição

### Regras de Ouro
- **Nenhuma tarefa > 4h** — Se maior, decomponha
- **Nenhuma tarefa com mais de 3 dependências** — Se mais, simplifique
- ** atomic = pode ser entregue em uma sessão**

### Tamanho Ideal
```
micro   → 15-30 min   (trivial, já sei como fazer)
small   → 1-2h        (preciso pensar um pouco)
medium  → 2-4h        (preciso investigar/converter)
large   → fragmentar em small + medium
```

## Output

```markdown
## Plano de Execução

### Tarefa: [nome]
### Complexidade: [micro/small/medium/large]
### Estimativa: [tempo total]

## Tarefas Atômicas

### 1. [Tarefa] (micro/small)
   - Depende de: [nada ou tarefa X]
   - Done quando: [critério]
   
### 2. [Tarefa] (small)
   - Depende de: [tarefa 1]
   - Done quando: [critério]

## Riscos
- [x] [Risco] → Mitigação

## Execução Sugerida
[Ordem recomendada]
```
