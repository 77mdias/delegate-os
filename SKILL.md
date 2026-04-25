---
name: delegado-os
description: "AI Agent OS — HELL-Centric Meta-Prompting with Autonomous CLI Agent | Full automation: skill auto-load, obsidian sync, pattern detection | /delegado [bmad|hell|hell:phase-board|propose|specs|design|tasks|apply|verify|context|memory|learn|feedback]"
argument-hint: "[bmad|hell|hell:phase-board|propose|specs|design|tasks|apply|verify|context|memory|learn|feedback]"
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

"O contexto é poder. A memória é força. A execução é brutal. A automação é rei."

Sistema de meta-prompting HELL-CENTRIC para desenvolvimento de software assistido por IA.
</objective>

<context>
## Philosophy

```
HELL IS THE CENTER ──┐
                     ▼
OBSIDIAN IS THE BRAIN (Persistent Memory, Graph, Dataview)
                     │
CLI AGENT IS AUTONOMOUS ◄────► USER (Bidirectional Interaction)
                     │
AUTOMATION WITHOUT WAITING ──┘
```

## Autonomous Agent Loop

```
RECEIVE → ANALYZE → DECIDE → EXECUTE → RECORD → SYNC → VALIDATE → LEARN
```

## HELL Method (Core)

| Phase | Command | Gate |
|-------|---------|------|
| SPEC | `/delegado hell:spec` | M-SPEC |
| TDD | `/delegado hell:tdd` | M-TEST |
| REFACTOR | `/delegado hell:refactor` | M-QUALITY |
| EVOLVE | `/delegado hell:evolve` | M-SHIP |
| REVIEW | `/delegado hell:review` | M-REVIEW |

## Skill Auto-Loading

| Trigger | Skill Loaded |
|---------|-------------|
| "analisar" / "review" | ANALISE |
| "implementar" / "executar" | EXECUCAO |
| "planejar" / "decompor" | PLANEJAMENTO |
| "testar" / "tdd" / "validar" | QUALIDADE + DEVELOPMENT/tdd-cycle |
| "hell" / "grasp" / "gof" | HELL CORE ENGINE (kernel/hell/HELL-CORE-ENGINE.md) |
| "obsidian" | Obsidian integration (docs/obsidian-integration.md) |
| "setup" / "detectar" | SETUP |
| "bug" / "fix" | DEVELOPMENT/bugfix |
| "feature" / "entregar" | DEVELOPMENT/feature-delivery |
| "refatorar" / "pattern" | DEVELOPMENT/refactor |

## Obsidian Sync Triggers (Auto)

| Event | Obsidian Action |
|-------|-----------------|
| hell-spec created | Create vault note in specs/ |
| TDD cycle complete | Update hell-tdd-log-*.md |
| Milestone passed | Update HELL dashboard |
| New rule learned | Update memory/ + vault |
| Debt discovered | Add to hell-debt-*.md |
| Context gap | Create note in 00-INBOX/ |

## When to AUTO-EXECUTE (No Approval)

| Condition | Action |
|-----------|--------|
| Test missing + spec exists | Create test skeleton |
| Test failing | Run TDD cycle |
| Obsidian note missing | Create note |
| Pattern smell detected | Propose refactor |

## When to PROPOSE (Ask First)

| Condition | Action |
|-----------|--------|
| Refactor will break >3 tests | Show plan + approve |
| Milestone borderline (score ~70%) | Propose conditional pass |
| Major architecture change | Create ADR first |
| Delete file > 100 LOC | Archive before delete |

## Workflows

| Workflow | HELL Integration |
|----------|-----------------|
| OpenSpec | proposal → hell-spec → TDD → refactor |
| BMAD | ANALYSIS → triggers HELL SPEC |
| GSD | Tasks → TDD cycles via HELL |

## Commands

| Command | Function |
|---------|----------|
| `/delegado bmad` | BMAD 4-phase method |
| `/delegado hell` | HELL Method help + status |
| `/delegado hell:spec` | HELL Specification (GRASP domain model) |
| `/delegado hell:tdd` | HELL TDD cycle (Red/Green/Refactor) |
| `/delegado hell:refactor` | HELL Refactor (GoF patterns) |
| `/delegado hell:evolve` | HELL Evolution (CI/CD + debt) |
| `/delegado hell:audit` | HELL Audit (GRASP/SOLID compliance) |
| `/delegado hell:review` | HELL Review (6 dimensions + health score) |
| `/delegado hell:milestone [TYPE]` | Milestone gate checkpoint |
| `/delegado hell:debt` | Tech debt backlog |
| `/delegado hell:status` | HELL dashboard (all phases) |
| `/delegado hell:phase-board` | Complete review: phases, roadmap, tasks, specs, gaps, changelog |
| `/delegado propose [nome]` | Create change proposal |
| `/delegado specs` | Create/update specs |
| `/delegado design` | Create technical design |
| `/delegado tasks` | Generate atomic tasks |
| `/delegado apply` | Execute pending tasks |
| `/delegado verify` | Validate implementation |
| `/delegado context` | Load current context |
| `/delegado memory` | Show learned memory |
| `/delegado learn [regra]` | Teach new rule |
| `/delegado feedback [texto]` | Register feedback |

</context>

<process>
Execute the requested Delegado OS workflow or display the command reference.

For autonomous execution:
1. Detect context (project, stack, HELL phase, user preferences)
2. Load relevant skills automatically
3. Execute or propose based on confidence threshold
4. Sync results to Obsidian vault (if applicable)
5. Suggest next action

For `/delegado hell:*` → Use kernel/hell/HELL-CORE-ENGINE.md as reference
For `/delegado bmad:*` → Use workflows/bmad.yml
For obsidian sync → Use docs/obsidian-integration.md for vault structure
</process>