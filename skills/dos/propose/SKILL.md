---
name: dos-propose
description: "Create a new change proposal for OpenSpec workflow"
argument-hint: "[proposal-name]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
---

<objective>
Create a new change proposal for the OpenSpec workflow. This initializes a new change with proposal.md artifact.
</objective>

<context>
## OpenSpec Workflow

proposal → specs → design → tasks → implement

## Proposta

Criar proposal.md com:
- Problema ou oportunidade
- Scope e limites
- Contexto e motivação
- Critérios de sucesso
</context>

<process>
Create a new change proposal:

1. Use argument as proposal name or prompt for one
2. Create directory: changes/[proposal-name]/
3. Create proposal.md with sections:
   - # Proposal: [nome]
   - ## Problema
   - ## Scope
   - ## Contexto
   - ## Critérios de Sucesso
4. Show created artifact path
</process>
