# ⚡ Quick Reference — Delegado OS

> Single-page reference for all agent modes, workflows, and common commands.

---

## Mode Selection

| Prefix | Mode | Use When |
|--------|------|----------|
| `[PROFESSOR]` | 👨‍🏫 Professor | Learning, teaching, explaining |
| `[ARCHITECT]` | 🏗️ Architect | System design, patterns, ADRs |
| `[DEBUGGER]` | 🔍 Debugger | Bugs, errors, root cause |
| `[GUARDIAN]` | 🛡️ Guardian | Security, compliance, audits |
| `[RESEARCHER]` | 🔬 Researcher | Tech eval, widgets, investigation |
| `[MENTOR]` | 🎓 Mentor | Career, skills, growth |

**Auto-selection**: The Mode Orchestrator picks the best mode based on context keywords.

---

## Mode Details

### 👨‍🏫 PROFESSOR
```
Teach me [topic]
Explain [concept]
How does [X] work?
```
**Skills**: `/learn`, `/teach`, `/quiz`

### 🏗️ ARCHITECT
```
Design a [system]
What pattern for [X]?
Create ADR for [decision]
```
**Skills**: `/design`, `/pattern`, `/adr`

### 🔍 DEBUGGER
```
Fix this error
Debug [issue]
Why is [X] failing?
```
**Skills**: `/debug`, `/trace`, `/analyze`

### 🛡️ GUARDIAN
```
Security audit
Check compliance
Review access control
```
**Skills**: `/audit`, `/scan`, `/verify`

### 🔬 RESEARCHER
```
Research [technology]
Find widgets for [X]
Investigate [option]
```
**Skills**: `/search`, `/compare`, `/eval`

### 🎓 MENTOR
```
Career advice
Skill gap analysis
Learning path for [X]
```
**Skills**: `/path`, `/coach`, `/review`

---

## Workflows

| Workflow | Command | Phases |
|----------|---------|--------|
| **GSD** | `/gsd` | Briefing → Analysis → Decomposition → Execution → Validation |
| **HELL** | `/hell` | SPEC → TDD → REFACTOR → EVOLVE |
| **OpenSpec** | `/openspec` | Proposal → Specs → Design → Tasks → Implement |
| **BMAD** | `/bmad` | Analysis → Planning → Solutioning → Implementation |

### Workflow Phases

**GSD** (Get Shit Done):
```
/gsd:brief    → Define task completely
/gsd:analyze   → Identify components
/gsd:decompose → Break into atomic units
/gsd:execute   → Implement with milestones
/gsd:validate  → Verify against brief
```

**HELL** (GRASP/GoF + TDD):
```
/hell:spec      → M-SPEC gate (requirements)
/hell:tdd       → M-TEST gate (tests pass)
/hell:refactor  → M-QUALITY gate (patterns)
/hell:evolve    → M-SHIP gate (production ready)
```

---

## Plugin Hooks Quick Reference

### Container Plugin
| Hook | Trigger | Script |
|------|---------|--------|
| `pre_container_start` | Before container starts | `hooks/pre_container_start.sh` |
| `post_container_stop` | After container stops | `hooks/post_container_stop.sh` |
| `on_container_create` | On container creation | `hooks/on_container_create.sh` |

### Kubernetes Plugin
| Hook | Trigger | Script |
|------|---------|--------|
| `pre_deploy` | Before K8s deploy | `hooks/pre_deploy.sh` |
| `post_deploy` | After K8s deploy | `hooks/post_deploy.sh` |
| `on_scale` | On replica scaling | `hooks/on_scale.sh` |

### Analytics Plugin
| Hook | Trigger | Script |
|------|---------|--------|
| `daily` | Daily report generation | `hooks/daily_report.sh` |
| `weekly` | Weekly report generation | `hooks/weekly_report.sh` |
| `monthly` | Monthly report generation | `hooks/monthly_report.sh` |

### Observability Plugin
| Hook | Trigger | Script |
|------|---------|--------|
| `pre_observation_start` | Before observability starts | `hooks/pre_observation_start.sh` |
| `post_observation_stop` | After observability stops | `hooks/post_observation_stop.sh` |
| `on_metric` | On each metric emission | `hooks/on_metric.sh` |

### Secret Manager Plugin
| Hook | Trigger | Script |
|------|---------|--------|
| `pre_secret_access` | Before secret read | `hooks/pre_secret_access.sh` |
| `post_secret_access` | After secret read | `hooks/post_secret_access.sh` |

---

## CLI Commands

| Command | Description |
|---------|-------------|
| `./delegado.sh` | Interactive menu |
| `./delegado.sh setup` | Initial setup |
| `./delegado.sh detectar` | Detect tech stack |
| `./delegado.sh mode [mode]` | Switch mode |
| `./delegado.sh workflow [name]` | Start workflow |

### HELL Commands
| Command | Description |
|---------|-------------|
| `/dos-hell:spec` | Create SPEC document |
| `/dos-hell:tdd` | Run TDD cycle |
| `/dos-hell:refactor` | Apply patterns |
| `/dos-hell:audit` | Audit codebase |
| `/dos-hell:milestone` | Check milestone status |

---

## File Locations

| Path | Purpose |
|------|---------|
| `workflows/*.yml` | Workflow definitions |
| `plugins/*/manifest.yaml` | Plugin metadata |
| `plugins/*/hooks/*.sh` | Hook scripts |
| `templates/learning-paths/*.md` | Learning curricula |
| `docs/QUICKREF.md` | This file |
| `docs/GLOSSARY.md` | Full glossary |
| `docs/FAQ.md` | Common questions |

---

## Milestone Verdict Symbols

| Symbol | Meaning |
|--------|---------|
| ✅ PASSED | Criteria met, proceed |
| ⚠️ CONDITIONAL | Minor issues, proceed with caution |
| ❌ BLOCKED | Criteria not met, must fix |

---

## Tech Debt Severity

| Symbol | Severity | Action |
|--------|----------|--------|
| 🔴 | CRITICAL | Fix immediately |
| 🟡 | MAJOR | Fix in current sprint |
| 🟢 | MINOR | Fix when convenient |
| ⚪ | TRIVIAL | Low priority |

---

## TDD Cycle

```
┌─────────────────────────────────────┐
│              RED                     │
│   Write a failing test              │
│   (Test describes expected behavior) │
└─────────────────┬───────────────────┘
                  ▼
┌─────────────────────────────────────┐
│             GREEN                    │
│   Write minimum code to pass         │
│   (Make the test happy)             │
└─────────────────�───────────────────┘
                  ▼
┌─────────────────────────────────────┐
│           REFACTOR                   │
│   Apply GRASP/GoF patterns         │
│   Clean up without changing         │
│   behavior                         │
└─────────────────────────────────────┘
```

---

## GRASP Patterns (Quick)

| Pattern | Apply When |
|---------|------------|
| **Information Expert** | Where to assign responsibility? |
| **Creator** | Who creates object X? |
| **Controller** | Who handles system events? |
| **Low Coupling** | How to minimize dependencies? |
| **High Cohesion** | How to keep focus? |
| **Pure Fabrication** | Who creates non-domain object? |
| **Indirection** | How to decouple components? |
| **Protected Variations** | How to isolate instability? |
| **Polymorphism** | How to handle variations? |

---

## GoF Patterns (By Category)

**Creational** (Object Creation):
- Factory Method
- Abstract Factory
- Builder
- Prototype
- Singleton

**Structural** (Object Composition):
- Adapter
- Bridge
- Composite
- Decorator
- Facade
- Flyweight
- Proxy

**Behavioral** (Object Communication):
- Chain of Responsibility
- Command
- Iterator
- Mediator
- Memento
- Observer
- State
- Strategy
- Template Method
- Visitor

---

## Keyboard Shortcuts (CLI)

| Key | Action |
|-----|--------|
| `Ctrl+C` | Cancel current operation |
| `Ctrl+Z` | Suspend to background |
| `Tab` | Autocomplete |
| `↑/↓` | History navigation |
