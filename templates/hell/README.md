# 💀 HELL Templates

Templates usados pelo HELL Agent durante o ciclo de desenvolvimento.

---

## Template Map

```
SPEC ────────► TDD ────────► REFACTOR ──────► EVOLVE ──────► REVIEW
  │               │              │               │              │
  ▼               ▼              ▼               ▼              ▼
hell-spec     hell-tdd-log   hell-refactor   hell-evolution   hell-review
              hell-tdd-task  hell-adr        hell-tech-debt   hell-audit
                                                              hell-milestone
                                                              hell-status
```

---

## Templates por Fase

| Template | Fase | Comando | Propósito |
|:---------|:-----|:--------|:----------|
| `hell-spec.template.md` | SPEC | `/dos-hell:spec` | Interrogatório de requisitos + GRASP domain model |
| `hell-tdd-log.template.md` | TDD | `/dos-hell:tdd` | Registro de ciclos Red/Green/Refactor |
| `hell-tdd-task.template.md` | TDD | `/dos-hell:tdd` | Task atômica com TDD + GRASP validation |
| `hell-refactor-report.template.md` | REFACTOR | `/dos-hell:refactor` | Smell detection + pattern application |
| `hell-adr.template.md` | REFACTOR | `/dos-hell:refactor` | Architecture Decision Record |
| `hell-evolution-status.template.md` | EVOLVE | `/dos-hell:evolve` | CI/CD + docs + monitoring status |
| `hell-tech-debt.template.md` | EVOLVE | `/dos-hell:debt` | Tech debt backlog com severidade |
| `hell-review.template.md` | REVIEW | `/dos-hell:review` | Deep analysis + health score + feature suggestions |
| `hell-audit-report.template.md` | AUDIT | `/dos-hell:audit` | Per-class GRASP/SOLID compliance |
| `hell-milestone.template.md` | GATE | `/dos-hell:milestone` | Checkpoint com 5 tipos de gate |
| `hell-status.template.md` | ALL | `/dos-hell:status` | Dashboard do ciclo |

---

## Uso

O agente HELL instancia estes templates automaticamente em `changes/[proposal]/`:

```bash
# Ao executar /dos-hell:spec, cria:
changes/my-feature/hell-spec.md

# Ao executar /dos-hell:tdd, cria:
changes/my-feature/hell-tdd-log.md

# Para cada ADR, cria:
changes/my-feature/decisions/HELL-ADR-001.md
```
