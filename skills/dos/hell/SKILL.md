---
name: dos-hell
description: "HELL Method — GRASP/GoF-driven development (Spec → TDD → Refactor → Evolve) + Review/Milestone/Phase-Board control | /dos-hell [spec|tdd|refactor|evolve|review|audit|milestone|debt|status|phase-board]"
argument-hint: "[spec|tdd|refactor|evolve|review|audit|milestone|debt|status|phase-board]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Method — Meta-Prompting Framework para Engenharia de Software

"Alta Coesão. Baixo Acoplamento. Sem piedade."

Sistema de desenvolvimento orientado a GRASP/GoF patterns com TDD obrigatório, 
gates de qualidade e controle de milestones.
</objective>

<context>
## HELL Cycle

```
SPEC ──► TDD ──► REFACTOR ──► EVOLVE
  │        │          │           │
 Gate    Gate       Gate        Gate
 REQ     TEST      AUDIT      DEPLOY
```

## Commands

| Command | Description |
|---------|-------------|
| /dos-hell | Show HELL help |
| /dos-hell:spec | HELL Specification — extract requirements, domain model |
| /dos-hell:tdd | TDD Cycle — Red/Green/Refactor |
| /dos-hell:refactor | GoF/GRASP refactoring with smell detection |
| /dos-hell:evolve | CI/CD + tech debt tracking |
| /dos-hell:review | Review codebase, suggest features/specs, analyze patterns |
| /dos-hell:audit | GRASP/GoF compliance audit |
| /dos-hell:milestone | Milestone gate — checkpoint control in workflow |
| /dos-hell:debt | Tech debt backlog and prioritization |
| /dos-hell:status | HELL cycle status dashboard |
| /dos-hell:phase-board | Document organization, gap finding, feature suggestions |

## Integration with BMAD/OpenSpec

HELL extends the existing workflows:
- **OpenSpec:** proposal → specs → design → **hell:spec** → **hell:tdd** → tasks → apply → **hell:review** → verify
- **BMAD:** ANALYSIS → PLANNING → **hell:spec** → SOLUTIONING → **hell:tdd** → IMPLEMENTATION → **hell:review**
- **Milestone:** Any workflow phase can invoke **hell:milestone** as a quality gate

## Core Engine

Reference: `kernel/hell/HELL-CORE-ENGINE.md`
Workflow Steps: `kernel/hell/HELL-WORKFLOW-STEPS.md`
</context>

<process>
Route to appropriate sub-skill based on argument:

- spec → /dos-hell:spec (HELL Specification phase)
- tdd → /dos-hell:tdd (TDD Red/Green/Refactor)
- refactor → /dos-hell:refactor (GoF/GRASP refactor)
- evolve → /dos-hell:evolve (CI/CD + tech debt)
- review → /dos-hell:review (Codebase review + feature suggestions)
- audit → /dos-hell:audit (GRASP/GoF compliance audit)
- milestone → /dos-hell:milestone (Milestone gate checkpoint)
- debt → /dos-hell:debt (Tech debt backlog)
- status → /dos-hell:status (Cycle status)
- phase-board → /dos-hell:phase-board (Document org, gap finding, changelog)

Or display this help if no argument.

## HELL Logic Gate (execute before ANY code)

1. **Information Expert** — Quem detém a informação?
2. **Pure Fabrication** — Precisa de abstração artificial?
3. **Protected Variations** — O que pode mudar?
4. **Indirection** — Quem media a comunicação?
5. **Polymorphism** — Tem condicional complexa?
</process>
