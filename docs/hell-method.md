# 💀 HELL Method — Guia Completo

> *"Alta Coesão. Baixo Acoplamento. Sem piedade."*

O HELL Method é um framework de desenvolvimento orientado a padrões GRASP/GoF com TDD obrigatório, gates de qualidade e controle de milestones.

---

## Por que HELL?

| Problema | Solução HELL |
|----------|-------------|
| Lógica de negócio na UI | **Controller** (GRASP) separa camadas |
| Switch/if chains imensos | **Strategy/State** (GoF) substitui condicionais |
| Código sem testes | TDD **Red/Green/Refactor** obrigatório |
| Mudanças que quebram tudo | **Protected Variations** com interfaces |
| Code review superficial | **Audit** per-class com GRASP/GoF checklist |
| Deploy sem confiança | **Milestone gates** com critérios objetivos |
| Tech debt invisível | **Debt tracking** com severidade e sprint targets |

---

## O Ciclo HELL

```
┌────────────┐    ┌────────────┐    ┌────────────┐    ┌────────────┐
│    SPEC     │───►│    TDD     │───►│  REFACTOR  │───►│  EVOLVE    │
│ Specification│   │ Red/Green  │    │ GoF/GRASP  │    │ CI/CD+Debt │
└────────────┘    └────────────┘    └────────────┘    └────────────┘
     │                  │                  │                  │
  [M-SPEC]          [M-TEST]         [M-QUALITY]         [M-SHIP]
                                                              │
                                                          REVIEW
                                                              │
                                                         [M-REVIEW]
```

---

## Fase 1: HELL Specification (`/dos-hell:spec`)

**Objetivo:** Extração bruta de requisitos. Zero ambiguidade.

### O que faz:
1. Interroga requisitos (Funcional, Não-Funcional, Constraints)
2. Mapeia domínio com GRASP (Information Expert, Creator, Protected Variations)
3. Identifica pontos de variação e define interfaces
4. Gera `hell-spec.md`

### Gate M-SPEC:
- Requisitos priorizados (MUST/SHOULD/COULD/WONT)
- Domínio modelado (Entities, VOs, Aggregates)
- Variação pontos identificados com interfaces
- Glossário documentado

---

## Fase 2: HELL TDD (`/dos-hell:tdd`)

**Objetivo:** Implementação dirigida por testes. Sem teste = Sem código.

### O ciclo:

| Passo | Regra |
|-------|-------|
| **RED** | Escreva teste que FALHA. Define o contrato. |
| **GREEN** | Código MÍNIMO para passar. Zero otimização. |
| **REFACTOR** | Limpe + aplique padrão. Testes continuam verdes. |

### Commits:
- `test: RED — [test_name]`
- `feat: GREEN — [feature]`
- `refactor: [pattern] — [justification]`

### Gate M-TEST:
- Coverage ≥80%
- Zero test failures
- Zero skipped tests
- TDD log documentado

---

## Fase 3: HELL Refactor (`/dos-hell:refactor`)

**Objetivo:** Aplicação sistemática de Design Patterns.

### Smell → Pattern Map:

| Smell | Pattern |
|-------|---------|
| Conditional Complexity | Strategy / State |
| Constructor Overload | Builder |
| God Class | Facade + Decomposition |
| Tight Coupling | Observer / Mediator |
| Duplicated Creation | Factory Method |
| Feature Envy | Move Method (Expert) |

### Regras de Segurança:
- Refatore UM pattern por vez
- Rode TODOS os testes entre CADA refactor
- Se teste quebrar → REVERTA
- Commit granular: `refactor(GoF): [pattern] — [module]`

### Gate M-QUALITY:
- Audit score ≥70%
- No critical smells
- Coupling <5 avg

---

## Fase 4: HELL Evolution (`/dos-hell:evolve`)

**Objetivo:** Automação e rastreamento de dívida técnica.

### Checklist:
1. CI/CD pipeline (lint → format → test → build → deploy)
2. Tech debt catalogada em `memory/hell-tech-debt.md`
3. Documentação sincronizada
4. Monitoring e feedback loop

### Gate M-SHIP:
- Pipeline green
- Zero critical vulnerabilities
- Debt catalogada
- Docs 100% synced

---

## HELL Review (`/dos-hell:review`)

**Objetivo:** Análise profunda com sugestão de features e novas specs.

### 6 Dimensões:

| Dimensão | Output |
|----------|--------|
| Architecture | Compliance score |
| Patterns | Pattern map (applied vs missing) |
| Coverage | Coverage report |
| Debt | Debt items |
| Features | Feature proposals → `/dos-propose` |
| Security | Security findings |

### Health Score: 0-100 (🟢🟡🔴)

---

## HELL Milestone (`/dos-hell:milestone`)

**Objetivo:** Gate checkpoint universal para qualquer workflow.

### 5 Tipos:

| Type | After | Critical Criteria |
|------|-------|-------------------|
| M-SPEC | Specification | Requirements + domain model |
| M-TEST | TDD/Implementation | Coverage + zero failures |
| M-QUALITY | Refactor | Audit + no smells |
| M-SHIP | Evolution | Pipeline + docs + debt |
| M-REVIEW | Review | Score + no blockers |

### Verdict:

```
Score ≥90% + zero critical → ✅ PASSED
Score ≥70% + zero critical → ⚠️ CONDITIONAL
Score <70% or critical     → ❌ BLOCKED
```

---

## HELL Logic Gate

Execute internamente ANTES de qualquer código:

1. **Information Expert** — Quem detém a informação?
2. **Pure Fabrication** — Precisa de abstração artificial?
3. **Protected Variations** — O que pode mudar?
4. **Indirection** — Quem media a comunicação?
5. **Polymorphism** — Tem condicional complexa?

---

## Referências Internas

| Documento | Localização |
|-----------|------------|
| Core Engine | `kernel/hell/HELL-CORE-ENGINE.md` |
| Workflow Steps | `kernel/hell/HELL-WORKFLOW-STEPS.md` |
| Flutter Example | `kernel/hell/HELL-FLUTTER-EXAMPLE.md` |
| Obsidian Schema | `kernel/hell/HELL-OBSIDIAN-SCHEMA.md` |
| Milestone Workflow | `workflows/hell-milestone.yml` |
