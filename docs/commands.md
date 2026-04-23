# 📋 Referência de Comandos — Delegado OS

> Todos os comandos disponíveis no sistema.

---

## Comandos CLI (`delegado.sh`)

| Comando | Função |
|---------|--------|
| `delegado.sh menu` | Menu interativo |
| `delegado.sh setup` | Setup inicial (detecta stack, configura memória) |
| `delegado.sh detectar` | Detectar stack do projeto |
| `delegado.sh aprender "regra"` | Ensinar nova regra/preferência |
| `delegado.sh memoria` | Ver memória persistente |
| `delegado.sh status` | Status do agente |
| `delegado.sh feedback "texto"` | Registrar feedback |
| `delegado.sh --version` | Versão do Delegado OS |

---

## Comandos Agent (`/dos-*`)

### Workflows

| Comando | Descrição | Artefato |
|---------|-----------|----------|
| `/dos-help` | Exibir ajuda | — |
| `/dos-bmad` | BMAD 4-phase method | — |
| `/dos-bmad 1` | Fase ANALYSIS | `proposal.md` |
| `/dos-bmad 2` | Fase PLANNING | `prd.md`, `specs.md` |
| `/dos-bmad 3` | Fase SOLUTIONING | `architecture.md`, `design.md` |
| `/dos-bmad 4` | Fase IMPLEMENTATION | `tasks.md`, código |
| `/dos-propose [nome]` | Criar change proposal | `changes/[nome]/proposal.md` |
| `/dos-specs` | Criar/editar especificações | `specs.md` |
| `/dos-design` | Criar design técnico | `design.md`, `architecture.md` |
| `/dos-tasks` | Gerar tarefas atômicas | `tasks.md` |
| `/dos-apply` | Executar tasks pendentes | — |
| `/dos-verify` | Verificar implementação | Relatório |

### Contexto e Memória

| Comando | Descrição |
|---------|-----------|
| `/dos-context` | Carregar contexto do projeto |
| `/dos-memory` | Ver memória atual |
| `/dos-learn [regra]` | Ensinar nova regra |
| `/dos-feedback [texto]` | Registrar feedback |

---

## 💀 Comandos HELL (`/dos-hell:*`)

### Ciclo Principal

| Comando | Fase | Descrição | Artefato |
|---------|------|-----------|----------|
| `/dos-hell` | — | Help do HELL Method | — |
| `/dos-hell:spec` | Specification | Extração de requisitos + GRASP analysis | `hell-spec.md` |
| `/dos-hell:tdd` | TDD | Ciclo Red/Green/Refactor | `hell-tdd-log.md` |
| `/dos-hell:refactor` | Refactor | Smell detection + GoF patterns | `hell-refactor-report.md` |
| `/dos-hell:evolve` | Evolution | CI/CD + tech debt + doc sync | `hell-evolution-status.md` |

### Review e Qualidade

| Comando | Descrição | Artefato |
|---------|-----------|----------|
| `/dos-hell:review` | Review profundo + sugestão de features + novas specs | `hell-review.md` |
| `/dos-hell:audit` | Auditoria GRASP/GoF/SOLID per-class | `hell-audit-report.md` |
| `/dos-hell:milestone` | Gate de milestone (checkpoint) | `hell-milestone.md` |
| `/dos-hell:milestone spec` | Force M-SPEC gate | `hell-milestone.md` |
| `/dos-hell:milestone test` | Force M-TEST gate | `hell-milestone.md` |
| `/dos-hell:milestone quality` | Force M-QUALITY gate | `hell-milestone.md` |
| `/dos-hell:milestone ship` | Force M-SHIP gate | `hell-milestone.md` |
| `/dos-hell:milestone review` | Force M-REVIEW gate | `hell-milestone.md` |

### Tracking

| Comando | Descrição | Artefato |
|---------|-----------|----------|
| `/dos-hell:debt` | Tech debt backlog management | `memory/hell-tech-debt.md` |
| `/dos-hell:status` | Dashboard do ciclo HELL | — (display only) |

---

## Comandos Delegado (`/delegado`)

Aliases que mapeiam para `/dos-*`:

| Comando | Equivalente |
|---------|-------------|
| `/delegado bmad` | `/dos-bmad` |
| `/delegado hell` | `/dos-hell` |
| `/delegado hell:spec` | `/dos-hell:spec` |
| `/delegado propose` | `/dos-propose` |
| `/delegado specs` | `/dos-specs` |
| `/delegado design` | `/dos-design` |
| `/delegado tasks` | `/dos-tasks` |
| `/delegado apply` | `/dos-apply` |
| `/delegado verify` | `/dos-verify` |
| `/delegado context` | `/dos-context` |
| `/delegado memory` | `/dos-memory` |
| `/delegado learn` | `/dos-learn` |
| `/delegado feedback` | `/dos-feedback` |
