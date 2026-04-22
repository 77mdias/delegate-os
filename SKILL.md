---
name: delegado-os
description: AI Agent Operating System - Context engineering + BMAD/OpenSpec workflows
category: framework
trigger: >
  /delegado, /delegado-os, /os, agente, context engineering,
  /propose, /spec, /design, /tasks, /apply,
  /bmad, /analysis, /planning, /solutioning, /implementation,
  /memory, /learn, /feedback, /context, /workflow
when_to_use: >
  Para qualquer tarefa de desenvolvimento que precise de metodologia estruturada.
  Este skill ativa o sistema Delegado OS com workflows BMAD e OpenSpec.
version: 1.0.0
depends_on: []
---

# Delegado OS — AI Agent Operating System

> *"O contexto é poder. A memória é força. A execução é brutal."*

## Overview

Delegado OS é um sistema de meta-prompting para desenvolvimento de software assistido por IA, integrando:

- **BMAD Method**: 4 fases (Analysis → Planning → Solutioning → Implementation)
- **OpenSpec**: Workflow spec-driven (proposal → specs → design → tasks → implement)
- **GSD (Get Shit Done)**: Tarefas atômicas e workflows em fases
- **Memory**: Sistema de memória persistente que aprende preferências
- **Context Engine**: Engenharia de contexto com templates XML/Markdown

## Quick Start

```
/delegado              → Menu principal
/delegado bmad         → Ativar BMad Method (4 fases)
/delegado propose [x]  → Criar proposal OpenSpec
/delegado memory       → Ver memória aprendida
```

## Workflows

### BMAD (4 Fases)

| ID | Fase | Cor | Artefatos |
|----|------|-----|-----------|
| 1 | ANALYSIS | #FF6B6B | proposal.md |
| 2 | PLANNING | #4ECDC4 | prd.md, specs.md |
| 3 | SOLUTIONING | #45B7D1 | architecture.md, design.md |
| 4 | IMPLEMENTATION | #96CEB4 | tasks.md, código |

### OpenSpec (Spec-Driven)

```
proposal ──► specs ──► design ──► tasks ──► implement
    │           │          │          │
   why        what       how       steps
 + scope   changes    approach   to take
```

### GSD (Atomic)

```
BRIEFING ──── ANÁLISE ──── DECOMPOSIÇÃO ──── EXECUÇÃO ──── VALIDAÇÃO ──── ENTREGUE
```

## Comandos Completos

### SPEC-DRIVEN (OpenSpec)

| Comando | Função |
|---------|--------|
| `/delegado propose [nome]` | Criar change proposal |
| `/delegado specs` | Criar/editar specs |
| `/delegado design` | Criar/editar design |
| `/delegado tasks` | Gerar tasks da spec |
| `/delegado apply` | Executar tasks pendentes |
| `/delegado verify` | Verificar implementação |

### BMAD (4 Fases)

| Comando | Função |
|---------|--------|
| `/delegado bmad` | Ativar BMad Method |
| `/delegado bmad:1` ou `/delegado analysis` | Fase 1: Analysis |
| `/delegado bmad:2` ou `/delegado planning` | Fase 2: Planning |
| `/delegado bmad:3` ou `/delegado solutioning` | Fase 3: Solutioning |
| `/delegado bmad:4` ou `/delegado implementation` | Fase 4: Implementation |

### CONTEXTO & MEMÓRIA

| Comando | Função |
|---------|--------|
| `/delegado context` | Carregar contexto atual |
| `/delegado memory` | Ver memória atual |
| `/delegado memory:rules` | Ver regras aprendidas |
| `/delegado learn [regra]` | Ensinar nova regra |
| `/delegado feedback [texto]` | Registrar feedback |

## Sub-Skills (Kernel)

O sistema inclui sub-skills organizadas por domínio:

| Skill | Função |
|-------|--------|
| `ANALISE` | Análise profunda de código e requisitos |
| `EXECUCAO` | Execução de tarefas atômicas |
| `PLANEJAMENTO` | Decomposição e planejamento |
| `QUALIDADE` | Review, validação e质量的 |
| `SETUP` | Onboarding e detecção de projeto |
| `DEVELOPMENT` | Bugfix, feature-delivery, refactor, TDD |

## Artefatos

O sistema gera e mantém artefatos em `changes/`:

```
changes/[nome]/
├── proposal.md      # Proposal original
├── prd.md          # Product Requirements Document
├── specs/          # Especificações detalhadas
├── design.md       # Design técnico
├── architecture.md # Arquitetura
└── tasks.md        # Tarefas atômicas
```

## Memória

O sistema mantém memória persistente em `.delegado/memory/`:

- **regras.md** — Regras aprendidas do projeto
- **preferencias.md** — Preferências do usuário
- **feedback.md** — Feedback registrado
- **conventions.md** — Convenções extraídas

## CLI

For CLI access, run `delegado` in your terminal:

```bash
delegado          # Menu interativo
delegado --version  # Ver versão
```

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
