# 📓 Integração Obsidian — Delegado OS

> Como conectar o Delegado OS ao seu Obsidian vault para criar um "Super Cérebro".

---

## Conceito

O HELL Method gera metadados YAML compatíveis com Obsidian, permitindo:
- Notas auto-linkadas via `[[wikilinks]]`
- Dashboards automáticos via Dataview
- Templates via Templater
- Rastreabilidade de decisões arquiteturais

---

## Setup do Vault

### Estrutura Recomendada

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
├── 03-DASHBOARDS/               # Dataview dashboards
├── 04-TEMPLATES/                # Templater templates
└── 05-ARCHIVE/                  # Notas deprecated
```

### Plugins Necessários

| Plugin | Função |
|--------|--------|
| **Dataview** | Queries automáticas sobre metadata YAML |
| **Templater** | Templates com variáveis dinâmicas |
| **Graph View** (built-in) | Visualização do grafo de notas |

---

## Schema YAML

Todo arquivo HELL no vault deve ter este frontmatter:

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

→ Schema completo: `kernel/hell/HELL-OBSIDIAN-SCHEMA.md`

---

## Dataview Queries

### Dashboard: Visão Geral

```dataview
TABLE HELL_Phase, HELL_Gate, Patterns_GoF
FROM #hell
WHERE Status = "🔥 ACTIVE"
SORT Updated DESC
```

### Dashboard: Tech Debt

```dataview
TABLE Debt_Items.severity AS Severidade, Debt_Items.effort AS Esforço
FROM #hell AND #debt
WHERE Status = "🔥 ACTIVE"
```

### Dashboard: TDD Coverage

```dataview
TABLE Module, Coverage, Tests_Total, Tests_Passing
FROM #hell AND #tdd
SORT Coverage ASC
```

### Dashboard: ADRs

```dataview
TABLE ADR_ID, ADR_Title, ADR_Status
FROM #hell AND #adr
SORT ADR_Date DESC
```

---

## Convenções de Nomenclatura

| Tipo | Prefixo | Exemplo |
|------|---------|---------|
| Spec | `hell-spec-` | `hell-spec-auth.md` |
| TDD Log | `hell-tdd-` | `hell-tdd-log-auth.md` |
| Refactor | `hell-refactor-` | `hell-refactor-auth.md` |
| ADR | `HELL-ADR-` | `HELL-ADR-001.md` |
| Tech Debt | `hell-debt-` | `hell-debt-sprint13.md` |
| Architecture | `hell-arch-` | `hell-arch-auth.md` |

---

## Fluxo Agent ↔ Obsidian

```
1. HELL Agent recebe demanda
2. Busca no vault por notas com Project + HELL_Phase
3. Carrega contexto de specs, ADRs, debt
4. Gera saída com metadata YAML compatível
5. Sugere notas para criar/atualizar no vault
```

Toda resposta complexa do HELL Agent inclui:

```yaml
Obsidian_Notes_To_Create:
  - path: "01-PROJECTS/MeuApp/specs/hell-spec-[module].md"
  - path: "01-PROJECTS/MeuApp/decisions/HELL-ADR-[number].md"
```
