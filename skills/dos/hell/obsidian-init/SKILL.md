---
name: dos-hell:obsidian-init
description: "Initialize HELL-Obsidian vault with structure, templates, plugins | /dos-hell:obsidian-init [create|setup|validate|migrate]"
argument-hint: "[create|setup|validate|migrate]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Obsidian Vault Initializer — Setup completo do vault

"Crie um vault HELL-Obsidian completo com estrutura, templates, plugins e configuração."

Inicializa vault Obsidian com estrutura recomendada, templates, plugins necessários e queries Dataview.
</objective>

<context>
## Vault Structure (from obsidian-integration.md)

```
HELL-Vault/
├── 00-INBOX/                    # Notas não processadas
├── 01-PROJECTS/                 # Uma pasta por projeto
│   └── MeuApp/
│       ├── specs/               # hell-spec-*.md
│       ├── tdd/                 # hell-tdd-*.md
│       ├── refactor/            # hell-refactor-*.md
│       ├── decisions/           # HELL-ADR-*.md
│       ├── debt/                # hell-debt-*.md
│       └── architecture/        # hell-arch-*.md
├── 02-PATTERNS/                 # Catálogo de patterns
│   ├── GRASP/
│   └── GoF/
├── 03-DASHBOARDS/               # Dataview dashboards + .base files
├── 04-TEMPLATES/                # Templater templates
├── 05-ARCHIVE/                  # Notas deprecated
└── .obsidian/                   # Config local
```

## Vault Creation Script

```bash
# Create vault with all structure
~/.claude/skills/dos-hell/obsidian-init/scripts/create-vault.sh [VAULT_NAME] [PATH]

# Example:
~/.claude/skills/dos-hell/obsidian-init/scripts/create-vault.sh MyHELLVault ~/Obsidian
```

The script creates:
- Full folder structure
- 4 Dataview dashboards (Overview, Tech Debt, TDD Coverage, ADR)
- 6 Templates (Spec, TDD, ADR, Debt, Daily, Refactor)
- Obsidian config files
- README.md with setup instructions

## HELL Dashboard Base

Pre-configured `.base` file for visual HELL tracking:
- `HELL-Dashboard.base` — Complete project overview with gates, coverage, debt
- Place in `03-DASHBOARDS/` folder
- Shows: Active Work, By Project, Tech Debt, TDD Coverage, Gate Status

## Frontmatter Schema

```yaml
---
Project: "[[NOME_DO_PROJETO]]"
Module: "auth"
Type: spec | tdd | refactor | decision | debt
HELL_Phase: Requisitos | Dev | TDD | Refactor | Evolution
HELL_Gate: PENDING | PASSED | BLOCKED
Status: 🔥 ACTIVE | ✅ DONE | ⏸ PAUSED | ❌ BLOCKED
Patterns_GRASP: [Controller, Information_Expert]
Patterns_GoF: [Strategy, Factory_Method]
Related: ["[[nota-1]]", "[[nota-2]]"]
Coverage: 85
Tech_Debt: none | minor | major | critical
Created: 2026-04-23
tags: [hell, tdd, grasp]
---
```

## Required Plugins

| Plugin | Purpose | Community? |
|--------|---------|------------|
| Dataview | YAML queries | Yes |
| Templater | Dynamic templates | Yes |
| Graph View | Built-in visualization | Built-in |
| Calendar | Daily notes | Yes |
| QuickAdd | Fast creation | Yes |

## Dataview Queries

```dataview
TABLE HELL_Phase, HELL_Gate, Patterns_GoF
FROM #hell
WHERE Status = "🔥 ACTIVE"
SORT Updated DESC
```

```dataview
TABLE Debt_Items.severity, Debt_Items.effort
FROM #hell AND #debt
WHERE Status = "🔥 ACTIVE"
```
</context>

<process>
Route to appropriate sub-operation:

- create → Create new vault structure
- setup → Setup templates and configs
- validate → Validate vault integrity
- migrate → Migrate existing notes

## HELL Logic Gate

1. **Information Expert** — Project or global structure?
2. **Pure Fabrication** — Template or script?
3. **Protected Variations** — Plugin or manual?
4. **Indirection** — Folder or metadata?
5. **Polymorphism** — New or existing vault?
</process>

<rules>
- Always create folder structure first
- Templates must have frontmatter
- Dataview queries must be in 03-DASHBOARDS/
- Use ISO dates in Created fields
- Tag all notes with #hell at minimum
- Archive deprecated notes, don't delete
</rules>