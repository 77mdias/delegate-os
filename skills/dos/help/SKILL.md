---
name: dos-help
description: "Show Delegado OS command reference and usage guide"
allowed-tools:
  - Read
---

<objective>
Display the complete Delegado OS (DOS) command reference with all available commands and their descriptions.
</objective>

<context>
# DELEGADO OS — Command Reference

"O contexto é poder. A memória é força. A execução é brutal."

## Workflows

### BMAD (4 Fases)
| Fase | Cor | Artefatos |
|------|-----|-----------|
| ANALYSIS | #FF6B6B | proposal.md |
| PLANNING | #4ECDC4 | prd.md, specs.md |
| SOLUTIONING | #45B7D1 | architecture.md |
| IMPLEMENTATION | #96CEB4 | tasks.md, código |

### OpenSpec (Spec-Driven)
proposal → specs → design → tasks → implement

### GSD (Atomic)
BRIEFING → ANÁLISE → DECOMPOSIÇÃO → EXECUÇÃO → VALIDAÇÃO → ENTREGUE

## Comandos Disponíveis

| Comando | Descrição |
|---------|-----------|
| /dos | Ativar menu principal do DOS |
| /dos-help | Mostrar esta ajuda |
| /dos-bmad | Ativar BMAD Method (4 fases) |
| /dos-bmad:1 | Fase 1: ANALYSIS |
| /dos-bmad:2 | Fase 2: PLANNING |
| /dos-bmad:3 | Fase 3: SOLUTIONING |
| /dos-bmad:4 | Fase 4: IMPLEMENTATION |
| /dos-propose | Criar change proposal |
| /dos-specs | Criar/editar especificações |
| /dos-design | Criar design técnico |
| /dos-tasks | Gerar tarefas atômicas |
| /dos-apply | Executar tarefas pendentes |
| /dos-verify | Verificar implementação |
| /dos-context | Carregar contexto atual |
| /dos-memory | Ver memória do sistema |
| /dos-memory:rules | Ver regras aprendidas |
| /dos-learn | Ensinar nova regra |
| /dos-feedback | Registrar feedback |

## Sub-Skills (Kernel)

| Skill | Descrição |
|-------|-----------|
| ANALISE | Análise profunda de código |
| EXECUCAO | Execução de tarefas atômicas |
| PLANEJAMENTO | Decomposição e planejamento |
| QUALIDADE | Review e validação |
| SETUP | Onboarding e detecção |
| DEVELOPMENT | Bugfix, feature, refactor, TDD |

## Quick Start

1. `/dos-propose [nome]` — Criar proposal
2. `/dos-specs` — Definir especificações
3. `/dos-design` — Criar design
4. `/dos-tasks` — Gerar tarefas
5. `/dos-apply` — Executar

## Workflows

### BMAD Method
/dos-bmad → guide through 4 phases

### OpenSpec
/dos-propose → /dos-specs → /dos-design → /dos-tasks → /dos-apply → /dos-verify

## Memória

O sistema mantém memória persistente em `.delegado/memory/`:
- regras.md — Regras aprendidas
- preferencias.md — Preferências
- feedback.md — Feedback registrado
- conventions.md — Convenções extraídas

## Artefatos

O sistema gera artefatos em `changes/[nome]/`:
- proposal.md, prd.md, specs/, design.md, architecture.md, tasks.md
</context>

<process>
Output this complete command reference as a formatted guide. Display all commands in a readable table format with descriptions.
</process>
