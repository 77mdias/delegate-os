# 💀 HELL OBSIDIAN METADATA SCHEMA v2.0
# Esquema de Metadados YAML para Integração com Obsidian

> *"Seu cérebro digital fala YAML. O HELL Agent escuta."*

---

## 1. SCHEMA PRINCIPAL — Frontmatter Padrão

Todo arquivo no vault HELL do Obsidian DEVE conter este frontmatter:

```yaml
---
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# HELL METADATA SCHEMA v2.0
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# IDENTIFICAÇÃO
Project: "[[NOME_DO_PROJETO]]"          # Link para nota do projeto
Module: "auth"                           # Módulo/feature
Type: spec | tdd | refactor | decision | architecture | debt | note

# CICLO HELL
HELL_Phase: Requisitos | Dev | TDD | Refactor | Evolution
HELL_Gate: PENDING | PASSED | BLOCKED
Status: 🔥 ACTIVE | ✅ DONE | ⏸ PAUSED | ❌ BLOCKED | 🗑 DEPRECATED

# PADRÕES APLICADOS
Patterns_GRASP:
  - Controller
  - Information_Expert
  - Pure_Fabrication
  - Protected_Variations
  - Creator
  - Low_Coupling
  - High_Cohesion
  - Polymorphism
  - Indirection

Patterns_GoF:
  - Strategy
  - Factory_Method
  - Observer
  - Repository
  - Singleton
  - Adapter
  - Facade
  - Decorator

# RASTREABILIDADE
Related:
  - "[[HELL-Note-Relacionada-1]]"
  - "[[HELL-Note-Relacionada-2]]"
Specs: "[[hell-spec-RF01]]"              # Link para spec de requisito
Tests: "[[hell-tdd-log-auth]]"           # Link para log TDD
Decision: "[[HELL-ADR-001]]"             # Link para Architecture Decision Record

# QUALIDADE
Coverage: 85                             # Percentual de cobertura
Tech_Debt: none | minor | major | critical
Complexity: low | medium | high

# TEMPORAL
Created: 2026-04-23
Updated: 2026-04-23
Sprint: "Sprint 12"
Due: 2026-05-01

# TAGS (para Dataview queries)
tags:
  - hell
  - tdd
  - grasp
  - flutter
---
```

---

## 2. SCHEMAS POR TIPO DE NOTA

### 2.1 — Spec Note (`Type: spec`)

```yaml
---
Project: "[[MeuApp]]"
Module: "auth"
Type: spec
HELL_Phase: Requisitos
HELL_Gate: PENDING
Status: 🔥 ACTIVE

# SPEC-SPECIFIC
Requirements:
  - id: RF-01
    description: "Login com email/senha"
    priority: MUST
    status: PENDING
  - id: RF-02
    description: "Login com Google"
    priority: MUST
    status: IN_PROGRESS

Actors:
  - Usuário
  - Sistema
  - Admin

Domain_Entities:
  - User
  - Session
  - AuthToken

Variation_Points:
  - point: "Auth Provider"
    protection: "AuthStrategy interface"
  - point: "Session Storage"
    protection: "AuthRepository interface"

tags: [hell, spec, auth]
Created: 2026-04-23
---
```

### 2.2 — TDD Note (`Type: tdd`)

```yaml
---
Project: "[[MeuApp]]"
Module: "auth"
Type: tdd
HELL_Phase: TDD
HELL_Gate: PASSED
Status: ✅ DONE

# TDD-SPECIFIC
Test_Suites:
  - name: "AuthController"
    file: "test/application/controllers/auth_controller_test.dart"
    cycles:
      - id: C1
        test: "should_login_successfully"
        red: true
        green: true
        refactor: true
        pattern: Controller
      - id: C2
        test: "should_handle_login_failure"
        red: true
        green: true
        refactor: true
        pattern: Strategy

Coverage: 92
Tests_Total: 12
Tests_Passing: 12
Tests_Failing: 0
Tests_Skipped: 0

Related:
  - "[[hell-spec-auth]]"
  - "[[HELL-ADR-001-Strategy]]"

tags: [hell, tdd, auth, green]
Created: 2026-04-23
---
```

### 2.3 — Architecture Decision Record (`Type: decision`)

```yaml
---
Project: "[[MeuApp]]"
Module: "auth"
Type: decision
HELL_Phase: Refactor
Status: ✅ DONE

# ADR-SPECIFIC
ADR_ID: "ADR-001"
ADR_Title: "Usar Strategy Pattern para Auth Providers"
ADR_Status: ACCEPTED  # PROPOSED | ACCEPTED | DEPRECATED | SUPERSEDED
ADR_Date: 2026-04-23

Context: "Múltiplos auth providers com lógica distinta"
Decision: "Implementar AuthStrategy interface com implementações concretas"
Consequences:
  positive:
    - "Adicionar novo provider = 1 classe nova"
    - "Zero impacto no Controller/UI"
  negative:
    - "Mais classes no projeto"
  tradeoffs:
    - "Complexidade inicial vs extensibilidade futura"

Alternatives_Rejected:
  - name: "Switch/case no Controller"
    reason: "Viola OCP, cresce linearmente com providers"
  - name: "Mixin por provider"
    reason: "Acoplamento alto, difícil de testar isoladamente"

Patterns_Applied:
  GRASP: [Protected_Variations, Pure_Fabrication]
  GoF: [Strategy, Factory_Method]

Superseded_By: null  # "[[HELL-ADR-002]]" se for superseded

tags: [hell, decision, adr, strategy]
Created: 2026-04-23
---
```

### 2.4 — Tech Debt Note (`Type: debt`)

```yaml
---
Project: "[[MeuApp]]"
Module: "global"
Type: debt
HELL_Phase: Evolution
Status: 🔥 ACTIVE

# DEBT-SPECIFIC
Debt_Items:
  - id: TD-001
    severity: critical  # critical | major | minor | trivial
    description: "API key hardcoded em config"
    location: "lib/infrastructure/api_client.dart:42"
    effort: S  # XS | S | M | L | XL
    impact: HIGH
    sprint_target: "Sprint 13"
    fix_pattern: "Protected Variations → env-based config"
  - id: TD-002
    severity: major
    description: "Sem retry logic em chamadas HTTP"
    location: "lib/infrastructure/http_client.dart"
    effort: M
    impact: MEDIUM
    sprint_target: "Sprint 14"
    fix_pattern: "Decorator Pattern → RetryDecorator"

Total_Debt_Score: 42  # Soma ponderada: critical=10, major=5, minor=2, trivial=1
Debt_Trend: increasing | stable | decreasing

tags: [hell, debt, tracking]
Created: 2026-04-23
Updated: 2026-04-23
---
```

### 2.5 — Refactor Note (`Type: refactor`)

```yaml
---
Project: "[[MeuApp]]"
Module: "auth"
Type: refactor
HELL_Phase: Refactor
HELL_Gate: PASSED
Status: ✅ DONE

# REFACTOR-SPECIFIC
Smells_Detected:
  - smell: "Conditional Complexity"
    location: "AuthService.authenticate()"
    severity: major
  - smell: "God Class"
    location: "UserManager"
    severity: critical

Refactorings_Applied:
  - smell: "Conditional Complexity"
    pattern: Strategy
    before_complexity: 42
    after_complexity: 12
    tests_maintained: "24/24"
    commit: "abc1234"
  - smell: "God Class"
    pattern: Facade
    before_loc: 580
    after_loc: 120
    tests_maintained: "18/18"
    commit: "def5678"

Metrics_Delta:
  cyclomatic_complexity: { before: 42, after: 18, delta: "-57%" }
  coupling_avg: { before: 8.3, after: 3.1, delta: "-63%" }
  cohesion_avg: { before: 0.34, after: 0.82, delta: "+141%" }

tags: [hell, refactor, gof, metrics]
Created: 2026-04-23
---
```

---

## 3. DATAVIEW QUERIES PARA OBSIDIAN

Cole estas queries em notas de dashboard para visualizar dados automaticamente:

### Dashboard: Visão Geral HELL

````markdown
## 🔥 Notas Ativas HELL
```dataview
TABLE HELL_Phase, HELL_Gate, Patterns_GoF
FROM #hell
WHERE Status = "🔥 ACTIVE"
SORT Updated DESC
```

## ✅ Concluídas
```dataview
TABLE Module, HELL_Phase, Coverage
FROM #hell
WHERE Status = "✅ DONE"
SORT Updated DESC
LIMIT 10
```

## ❌ Bloqueadas
```dataview
LIST
FROM #hell
WHERE Status = "❌ BLOCKED"
```
````

### Dashboard: Tech Debt

````markdown
## 🔴 Dívida Técnica
```dataview
TABLE Debt_Items.severity AS Severidade, Debt_Items.effort AS Esforço
FROM #hell AND #debt
WHERE Status = "🔥 ACTIVE"
SORT Debt_Items.severity ASC
```
````

### Dashboard: TDD Coverage

````markdown
## 🧪 Cobertura de Testes
```dataview
TABLE Module, Coverage, Tests_Total, Tests_Passing
FROM #hell AND #tdd
SORT Coverage ASC
```
````

### Dashboard: Architecture Decisions

````markdown
## 📐 Architecture Decision Records
```dataview
TABLE ADR_ID, ADR_Title, ADR_Status, Patterns_Applied.GoF
FROM #hell AND #adr
SORT ADR_Date DESC
```
````

---

## 4. TEMPLATE OBSIDIAN — Quick Create

Salve em `templates/` no seu vault:

### `templates/HELL-Note-Template.md`

```markdown
---
Project: "[[<%tp.file.cursor(1)%>]]"
Module: "<%tp.file.cursor(2)%>"
Type: <%tp.file.cursor(3)%>
HELL_Phase: <%tp.file.cursor(4)%>
HELL_Gate: PENDING
Status: 🔥 ACTIVE
Patterns_GRASP: []
Patterns_GoF: []
Related: []
Coverage: 0
Tech_Debt: none
Created: <% tp.date.now("YYYY-MM-DD") %>
Updated: <% tp.date.now("YYYY-MM-DD") %>
tags: [hell]
---

# <%tp.file.title%>

## Contexto


## Conteúdo


## Decisões


## Links
- Spec: [[]]
- Tests: [[]]
- ADR: [[]]
```

---

## 5. FOLDER STRUCTURE — Vault Obsidian

```
HELL-Vault/
├── 00-INBOX/                    # Notas não processadas
├── 01-PROJECTS/                 # Uma pasta por projeto
│   └── MeuApp/
│       ├── specs/               # Type: spec
│       │   └── hell-spec-auth.md
│       ├── tdd/                 # Type: tdd
│       │   └── hell-tdd-log-auth.md
│       ├── refactor/            # Type: refactor
│       │   └── hell-refactor-auth.md
│       ├── decisions/           # Type: decision (ADRs)
│       │   └── HELL-ADR-001.md
│       ├── debt/                # Type: debt
│       │   └── hell-debt-sprint13.md
│       └── architecture/        # Type: architecture
│           └── hell-arch-auth.md
├── 02-PATTERNS/                 # Catálogo de patterns
│   ├── GRASP/
│   │   ├── Controller.md
│   │   ├── Information-Expert.md
│   │   └── ...
│   └── GoF/
│       ├── Strategy.md
│       ├── Factory-Method.md
│       └── ...
├── 03-DASHBOARDS/               # Dataview dashboards
│   ├── HELL-Overview.md
│   ├── HELL-Debt-Tracker.md
│   └── HELL-TDD-Coverage.md
├── 04-TEMPLATES/                # Templater templates
│   └── HELL-Note-Template.md
└── 05-ARCHIVE/                  # Notas deprecated
```

---

## 6. CONVENÇÕES DE NOMENCLATURA

| Tipo | Prefixo | Exemplo |
|------|---------|---------|
| Spec | `hell-spec-` | `hell-spec-auth.md` |
| TDD Log | `hell-tdd-` | `hell-tdd-log-auth.md` |
| Refactor | `hell-refactor-` | `hell-refactor-auth.md` |
| ADR | `HELL-ADR-` | `HELL-ADR-001.md` |
| Tech Debt | `hell-debt-` | `hell-debt-sprint13.md` |
| Architecture | `hell-arch-` | `hell-arch-auth.md` |
| Dashboard | `HELL-` | `HELL-Overview.md` |

---

## 7. INTEGRAÇÃO HELL AGENT ↔ OBSIDIAN

### Como o HELL Agent Lê Seu Cérebro

```
1. HELL Agent recebe demanda do usuário
2. Busca no vault por notas com:
   - Project: [[PROJETO_ATUAL]]
   - HELL_Phase: fase relevante
   - Patterns_*: padrões já aplicados
3. Carrega contexto de:
   - Specs existentes (decisões prévias)
   - TDD logs (contratos já definidos)
   - ADRs (decisões arquiteturais vigentes)
   - Tech Debt (o que já é conhecido)
4. Gera saída com metadata YAML compatível
5. Sugere notas para criar/atualizar
```

### YAML Output Footer (Todo Output HELL)

Toda resposta complexa do HELL Agent termina com:

```yaml
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# HELL OBSIDIAN SYNC
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Obsidian_Notes_To_Create:
  - path: "01-PROJECTS/MeuApp/specs/hell-spec-[módulo].md"
    type: spec
    reason: "Nova spec gerada nesta interação"
  - path: "01-PROJECTS/MeuApp/tdd/hell-tdd-log-[módulo].md"
    type: tdd
    reason: "Ciclos TDD executados"
  - path: "01-PROJECTS/MeuApp/decisions/HELL-ADR-[número].md"
    type: decision
    reason: "Decisão arquitetural registrada"
```

---

**HELL OBSIDIAN METADATA SCHEMA — DEPLOYED.**
**Seu cérebro digital agora fala a linguagem do HELL Agent.**
**Datatview queries prontas. Templates carregados. Vault estruturado.**
