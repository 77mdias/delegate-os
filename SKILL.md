---
name: delegado
description: "AI Agent OS — Context engineering + BMAD/OpenSpec workflows | /delegado [bmad|propose|specs|design|tasks|apply|verify|context|memory|learn|feedback]"
argument-hint: "[bmad|propose|specs|design|tasks|apply|verify|context|memory|learn|feedback]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
Delegado OS — AI Agent Operating System

"O contexto é poder. A memória é força. A execução é brutal."

Sistema de meta-prompting para desenvolvimento de software assistido por IA.
</objective>

<context>
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

## Comandos

| Comando | Função |
|---------|--------|
| /delegado bmad | Ativar BMad Method (4 fases) |
| /delegado bmad:1 | Fase 1: ANALYSIS |
| /delegado bmad:2 | Fase 2: PLANNING |
| /delegado bmad:3 | Fase 3: SOLUTIONING |
| /delegado bmad:4 | Fase 4: IMPLEMENTATION |
| /delegado propose [nome] | Criar change proposal |
| /delegado specs | Criar/editar specs |
| /delegado design | Criar/editar design |
| /delegado tasks | Gerar tasks da spec |
| /delegado apply | Executar tasks pendentes |
| /delegado verify | Verificar implementação |
| /delegado context | Carregar contexto atual |
| /delegado memory | Ver memória atual |
| /delegado memory:rules | Ver regras aprendidas |
| /delegado learn [regra] | Ensinar nova regra |
| /delegado feedback [texto] | Registrar feedback |

## Sub-Skills
| Skill | Função |
|-------|--------|
| ANALISE | Análise profunda de código |
| EXECUCAO | Execução de tarefas atômicas |
| PLANEJAMENTO | Decomposição e planejamento |
| QUALIDADE | Review e validação |
| SETUP | Onboarding e detecção |
| DEVELOPMENT | Bugfix, feature, refactor, TDD |
</context>

<process>
Execute the requested Delegado OS workflow or display the command reference.

For /delegado bmad: Guide through BMAD 4-phase method
For /delegado propose: Create new change proposal
For /delegado specs: Create/update specifications
For /delegado design: Create technical design
For /delegado tasks: Generate atomic tasks
For /delegado apply: Execute pending tasks
For /delegado verify: Validate implementation
For /delegado context: Load and display context
For /delegado memory: Show learned memory
For /delegado learn: Teach new rule
For /delegado feedback: Register feedback
</process>
