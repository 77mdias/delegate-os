---
name: dos-hell:status
description: "HELL Status — Dashboard of current HELL cycle, gates, and metrics"
allowed-tools:
  - Read
  - Glob
  - Grep
---

<objective>
HELL Status — Dashboard rápido do estado atual do ciclo HELL.

Mostra em qual fase estamos, quais gates passaram, métricas atuais.
</objective>

<context>
## Status Sources

| Source | What it Shows |
|--------|--------------|
| `changes/[proposal]/hell-spec.md` | Spec phase status |
| `changes/[proposal]/hell-tdd-log.md` | TDD phase status |
| `changes/[proposal]/hell-refactor-report.md` | Refactor phase status |
| `changes/[proposal]/hell-evolution-status.md` | Evolution phase status |
| `changes/[proposal]/hell-review.md` | Review status |
| `changes/[proposal]/hell-milestone.md` | Milestone gate status |
| `memory/hell-tech-debt.md` | Tech debt status |
</context>

<process>
1. **DETECT** active proposal in `changes/`
2. **SCAN** for HELL artifacts in proposal directory
3. **BUILD** status dashboard:

```
💀 HELL STATUS DASHBOARD
═══════════════════════════════════════════

Project: [name]
Proposal: [active proposal]

┌──────────┬──────────┬──────────┬──────────┐
│   SPEC   │   TDD    │ REFACTOR │  EVOLVE  │
│  [status]│  [status]│  [status]│  [status]│
│   Gate:  │   Gate:  │   Gate:  │   Gate:  │
│  [gate]  │  [gate]  │  [gate]  │  [gate]  │
└──────────┴──────────┴──────────┴──────────┘

Milestone: [latest milestone verdict]
Review: [review score if exists]
Tech Debt: [N] items ([trend])

Next Action: /dos-hell:[suggested command]
```

4. **SUGGEST** next action based on current state
</process>
