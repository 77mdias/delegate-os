---
name: delegado
description: Sistema operacional de agentes - Context engineering + Workflows (BMAD + OpenSpec)
category: framework
trigger: >
  /delegado, /agent-os, /os, agente, context engineering,
  /propose, /spec, /design, /tasks, /apply,
  /bmad, /analysis, /planning, /solutioning, /implementation,
  /memory, /learn, /feedback, /context, /workflow
when_to_use: >
  Quando precisar de metodologia estruturada para desenvolvimento.
  Este skill ativa o sistema Delegado OS com workflows BMAD e OpenSpec.
version: 1.0.0
---

# Skill: DELEGADO OS

> *"O contexto é poder. A memória é força. A execução é brutal."*

## Overview

Delegado OS é um sistema de meta-prompting que integra:
- **BMAD Method**: 4 fases (Analysis → Planning → Solutioning → Implementation)
- **OpenSpec**: Workflow spec-driven (proposal → specs → design → tasks)
- **GSD**: Tarefas atômicas e workflows em fases

## Como Ativar

```
/delegado           → Menu principal
/delegado propose X → Criar proposal OpenSpec
/delegado bmad      → Ativar BMad Method
```

## Workflows

### OpenSpec (Spec-Driven)
```
proposal ──► specs ──► design ──► tasks ──► implement
```

### BMAD (4 Fases)
| Fase | Cor | Artefatos |
|------|-----|-----------|
| ANALYSIS | #FF6B6B | proposal.md |
| PLANNING | #4ECDC4 | prd.md, specs.md |
| SOLUTIONING | #45B7D1 | architecture.md, design.md |
| IMPLEMENTATION | #96CEB4 | tasks.md |

---

## Comandos Completos

### SPEC-DRIVEN (OpenSpec)

| Comando | Função |
|---------|--------|
| `/delegado propose [nome]` | Criar change proposal |
| `/delegado specs` | Criar/editar specs |
| `/delegado spec:add [nome]` | Adicionar spec |
| `/delegado design` | Criar/editar design |
| `/delegado tasks` | Gerar tasks da spec |
| `/delegado task:add [desc]` | Adicionar task |
| `/delegado task:toggle [id]` | Marcar task completa |
| `/delegado apply` | Executar tasks pendentes |
| `/delegado verify` | Verificar implementação |
| `/delegado archive` | Arquivar change |
| `/delegado diff` | Mostrar changes pendentes |

### BMAD (4 Fases)

| Comando | Função |
|---------|--------|
| `/delegado bmad` | Ativar BMad Method |
| `/delegado bmad:1` ou `/delegado analysis` | Fase 1: Analysis |
| `/delegado bmad:2` ou `/delegado planning` | Fase 2: Planning |
| `/delegado bmad:3` ou `/delegado solutioning` | Fase 3: Solutioning |
| `/delegado bmad:4` ou `/delegado implementation` | Fase 4: Implementation |
| `/delegado bmad:status` | Ver status de todas as fases |
| `/delegado bmad:reset` | Resetar workflow |

### CONTEXTO

| Comando | Função |
|---------|--------|
| `/delegado context` | Carregar contexto atual |
| `/delegado context:save [nome]` | Salvar contexto |
| `/delegado context:load [nome]` | Carregar contexto salvo |
| `/delegado context:export` | Exportar como XML |
| `/delegado briefing [texto]` | Gerar briefing XML |

### MEMÓRIA

| Comando | Função |
|---------|--------|
| `/delegado memory` | Ver memória atual |
| `/delegado memory:rules` | Ver regras aprendidas |
| `/delegado memory:conventions` | Ver convenções do projeto |
| `/delegado learn [regra]` | Ensinar nova regra |
| `/delegado forget [regra]` | Remover regra |
| `/delegado preferences` | Ver preferências do usuário |
| `/delegado preferences:set [chave] [valor]` | Definir preferência |

### FEEDBACK

| Comando | Função |
|---------|--------|
| `/delegado feedback [texto]` | Registrar feedback |
| `/delegado feedback:list` | Listar feedbacks |
| `/delegado feedback:learn` | Aprender com feedbacks |

### WORKFLOW

| Comando | Função |
|---------|--------|
| `/delegado workflow` | Mostrar workflows disponíveis |
| `/delegado workflow:set [nome]` | Definir workflow ativo |
| `/delegado workflow:status` | Status do workflow atual |
| `/delegado workflow:reset` | Resetar workflow |

### ANALISE

| Comando | Função |
|---------|--------|
| `/delegado analyze` | Analisar código/contexto |
| `/delegado analyze:stack` | Detectar stack do projeto |
| `/delegado analyze:conventions` | Extrair convenções |
| `/delegado analyze:risks` | Identificar riscos |
| `/delegado analyze:deps` | Mapear dependências |

### QUALIDADE

| Comando | Função |
|---------|--------|
| `/delegado review` | Code review |
| `/delegado validate` | Validar artefatos |
| `/delegado check` | Checklist de qualidade |

### MENU

| Comando | Função |
|---------|--------|
| `/delegado help` | Mostrar ajuda |
| `/delegado menu` | Abrir menu interativo |
| `/delegado status` | Status geral |

---

## Ativação Rápida

Quando ativado, o Delegado OS:
1. Carrega contexto do projeto
2. Detecta stack e convenções
3. Apresenta workflow adequado
4. Executa com validação contínua

## Workflow Padrão (Spec-Driven)

```
1. /delegado propose [nome]
   → Cria changes/[nome]/proposal.md

2. /delegado specs
   → Cria specs/*.md

3. /delegado design
   → Cria design.md

4. /delegado tasks
   → Gera tasks.md

5. /delegado apply
   → Executa tasks

6. /delegado verify
   → Valida resultado

7. /delegado archive
   → Arquiva change
```

## Memória

O sistema mantém memória persistente em:
- `.delegado/memory/` — Regras aprendidas
- `.delegado/changes/` — Changes propostos
- `.delegado/config.yaml` — Configuração

## Output Format

```markdown
## Delegado OS — [Workflow]

### Phase: [current]
### Status: [in_progress/complete]

### Artefatos
- ✅ proposal.md
- ⏳ specs.md

### Próximo
→ Executar `/delegado specs` para continuar
```

## BMAD Phase Output

```markdown
## BMAD — Phase [N]: [NAME]

### Status
- ✅ Analysis: [done/pending]
- ✅ Planning: [done/pending]
- ✅ Solutioning: [done/pending]
- ✅ Implementation: [done/pending]

### Artefatos
- [x] proposal.md
- [ ] prd.md
- [ ] architecture.md

### Progresso
████████░░ 75%
```