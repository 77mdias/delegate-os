---
name: especificacao
description: Workflow spec-driven (OpenSpec-inspired)
category: WORKFLOW
trigger: >
  /propose, /spec, /design, /tasks, /apply, /verify,
  /archive, criar feature, nova tarefa
priority: critical
when_to_use: >
  Quando for criar nova feature ou modificar existente.
  Este workflow garante que todos concordem no que será construído.
version: 1.0.0
depends_on: [ANALISE]
---

# Skill: ESPECIFICACAO

> *"Especifico antes de implementar. Contexto é contrato."*

## Workflow

```
proposal ──► specs ──► design ──► tasks ──► implement
    │           │          │          │
   why        what       how       steps
 + scope   changes    approach   to take
```

## Templates

Os templates estão em `templates/`:
- `templates/proposal/proposal.template.md` → `/propose`
- `templates/spec/spec.template.md` → `/specs`
- `templates/design/design.template.md` → `/design`
- `templates/tasks/*.template.md` → `/tasks`
- `templates/architecture/architecture.template.md` → ADR decisions

## Comandos

| Comando | Função |
|---------|--------|
| `/propose [nome]` | Criar proposal com contexto |
| `/specs` | Detalhar requisitos |
| `/design` | Definir abordagem técnica |
| `/tasks` | Gerar checklist de implementação |
| `/apply` | Implementar tasks |
| `/verify` | Verificar todos os checks |
| `/archive` | Arquivar change |

## Artefatos

### proposal.md
```markdown
# Proposal: [nome]

## Contexto
[Por que isso é necessário?]

## Problema
[O que estamos resolvendo?]

## Impacto
[O que acontece se não fizermos?]

## Escopo
### Dentro
- [x] Item...

### Fora
- [ ] Item...
```

### specs/**/*.md
```markdown
# Specs: [feature]

### Cenário 1: [nome]
- **Dado** [contexto]
- **Quando** [ação]
- **Então** [resultado]

### Critérios de Aceite
- [ ] Criterion 1
```

### design.md
```markdown
# Design: [feature]

### Arquitetura
[Decisões técnicas]

### Estrutura
[Files/dirs]
```

### tasks.md
```markdown
## Tasks: [feature]

### Bloco 1: Setup
- [ ] Task 1.1
```

## Validação

Antes de `/apply`:
- [ ] proposal.md existe
- [ ] specs/**/*.md existem
- [ ] design.md existe
- [ ] tasks.md tem checklist
