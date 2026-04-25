---
name: dos-hell:phase_board
description: "HELL Phase Board — Complete review: phases, roadmap, tasks, specs, changelog, gaps. Verify and update all development documents."
argument-hint: "[full|index|roadmap|phases|tasks|specs|gaps|changelog|report]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Phase Board — Sistema central de revisão e organização documental.

Faz **revisão completa** de todo o sistema de documentação:
- Verifica PHASES, ROADMAP, TASKS, SPECS
- Atualiza CHANGELOG e GAPS
- Mantém consistência cruzada entre documentos
- Reporta status, blockers e próximos passos

"Revise. Atualize. Sincronize. Nunca deixe documento órfão."
</objective>

<context>
## Organization Structure

```
docs/development/
├── README.md                      # Índice central (ATUALIZADO PELO PHASE-BOARD)
├── ROADMAP.md                     # Roadmap (VERIFICADO PELO PHASE-BOARD)
├── PHASES/
│   ├── PHASE-01/
│   │   ├── phase-board.md         # Board desta phase
│   │   ├── prd.md                 # Product Requirements
│   │   ├── hell-spec.md           # HELL Specification
│   │   └── changelog.md           # Changelog da phase
│   └── PHASE-XX/
├── SPRINTS/
│   └── SPRINT-YY-sprint.md
├── TASKS/
│   ├── TASK-ID.md                 # Tarefas unitárias
│   └── PHASE-XX-tasks.md         # Board consolidado
├── SPECS/
│   └── SPEC-name.md
├── PROPOSALS/
│   └── PROPOSAL-name.md
├── GAPS/
│   ├── gap-001.md                 # Gap encontrado
│   └── feature-001.md            # Feature proposta
└── CHANGELOG.md                  # Changelog global (ATUALIZADO PELO PHASE-BOARD)
```

## Templates Reference

| Template | Location | Use |
|----------|----------|-----|
| phase-board | `templates/tasks/phase-board.template.md` | Phase/Sprint tracking |
| sprint | `templates/tasks/sprint.template.md` | Sprint planning |
| single-task | `templates/tasks/single-task.template.md` | Unit task |
| hell-spec | `templates/hell/hell-spec.template.md` | HELL specification |
| prd | `templates/prd/prd.template.md` | Product Requirements |
| changelog | `templates/spec/changelog.template.md` | Changelog entry |
| roadmap | `skills/dos/hell/phase-board/templates/roadmap.template.md` | Roadmap |
| gap | `skills/dos/hell/phase-board/templates/gap.template.md` | Gap document |
| feature | `skills/dos/hell/phase-board/templates/feature.template.md` | Feature proposal |

## Document Naming Convention

```
TYPE-ID-short-description.md

Exemplos:
- PHASE-01-auth-system.md
- SPRINT-05-user-flow.md
- TASK-023-fix-login-bug.md
- SPEC-payment-gateway.md
- GAP-002-missing-analytics.md
- FEATURE-007-dark-mode.md
```
</context>

<process>
## COMPLETE REVIEW WORKFLOW

Execute na ordem: INDEX → ROADMAP → PHASES → TASKS → SPECS → GAPS → CHANGELOG → REPORT

---

### 1. INDEX — Update Central Index

Execute primeiro. Verifica e atualiza `docs/development/README.md`:

**Verificar:**
- [ ] README.md existe
- [ ] Tem tabela de status de phases
- [ ] Tem links para todos os documentos
- [ ] Tem seção de gaps abertos
- [ ] Tem seção de changelog

**Se faltando, criar/atualizar:**
```markdown
# Development Board

**Última atualização:** {{YYYY-MM-DD}}
**Agent:** {{agent-name}}

## 📊 Status Geral

| Phase | Status | Progresso | Sprint Atual | Docs |
|-------|--------|-----------|-------------|------|
| PHASE-01 | ✅ Completa | 100% | - | [board](./PHASES/PHASE-01/) |
| PHASE-02 | 🚧 Em progresso | 60% | Sprint-03 | [board](./PHASES/PHASE-02/) |
| PHASE-03 | 🔵 Planejada | 0% | - | - |

## 📁 Estrutura de Diretórios

- [Phases](./PHASES/) — Boards de fase
- [Sprints](./SPRINTS/) — Sprints ativos
- [Tasks](./TASKS/) — Tarefas unitárias
- [Specs](./SPECS/) — Especificações técnicas
- [Proposals](./PROPOSALS/) — Propostas de feature
- [Gaps](./GAPS/) — Gaps identificados
- [Changelog](./CHANGELOG.md) — Histórico de mudanças

## 🔥 Gaps Abertos

| ID | Descrição | Severidade | Status | Proposta |
|----|-----------|------------|--------|----------|
| GAP-001 | Missing analytics | 🟡 MAJOR | OPEN | [FEATURE-005](./GAPS/feature-005.md) |
| GAP-002 | Incomplete auth | 🔴 CRITICAL | PROPOSED | - |

## 📋 Tasks em Andamento

| Task | Phase | Status | Blocker |
|------|-------|--------|---------|
| TASK-023 | PHASE-02 | 🚧 Em progresso | - |
| TASK-024 | PHASE-02 | ⛔ Bloqueada | Aguardando TASK-023 |

## 🔗 Documentos Recentes

- {{YYYY-MM-DD}} — PHASE-02 sprint-board.md atualizado
- {{YYYY-MM-DD}} — GAP-001 criado
- {{YYYY-MM-DD}} — CHANGELOG.md atualizado
```

---

### 2. ROADMAP — Verify Roadmap

Verifica `docs/development/ROADMAP.md`:

**Checklist de Verificação:**
- [ ] ROADMAP.md existe
- [ ] Todas as phases estão listadas
- [ ] Status de cada phase está correto
- [ ] Progresso está sincronizado com phase-boards
- [ ] Timeline está atual
- [ ] Features principais estão listadas
- [ ] Gaps críticos estão listados
- [ ] Próximos passos estão definidos

**Se ROADMAP.md não existir, criar a partir do template:**
```bash
cp skills/dos/hell/phase-board/templates/roadmap.template.md docs/development/ROADMAP.md
```

**Verificação de Consistência Cruzada:**
```
Se PHASE-01 está ✅ no ROADMAP
  → Verificar que PHASE-01/phase-board.md também está ✅

Se PHASE-02 está 🚧 no ROADMAP com 60%
  → Verificar que TASKS completadas / total = ~60%

Se FEATURE-X está listada no ROADMAP
  → Verificar que existe SPEC-X.md ou PROPOSAL-X.md
```

**Atualizar ROADMAP se不一致:**
- Sincronizar status de phases
- Atualizar progresso baseado em tasks
- Adicionar features/gaps identificados
- Corrigir timeline se necessário

---

### 3. PHASES — Review All Phase Boards

Para cada phase em `docs/development/PHASES/`:

**Checklist de Verificação:**
- [ ] phase-board.md existe
- [ ] Frontmatter completo (title, type, status)
- [ ] Status está consistente com ROADMAP
- [ ] Progresso está correto (tasks completadas / total)
- [ ] Todas as tasks têm:
  - [ ] ID único
  - [ ] Status definido
  - [ ] Critérios de aceitação
  - [ ] Dependências listadas
  - [ ] Estratégia de teste
- [ ] Dependências entre phases resolvidas
- [ ] Checkpoints de gate marcados
- [ ] блокирующие (blockers) documentados

**Verificação de Consistência:**
```
Se PHASE-02 tem TASK-023 dependendo de TASK-022 (PHASE-01)
  → Verificar que TASK-022 está ✅ em PHASE-01

Se PHASE-02 é pré-requisito de PHASE-03
  → Verificar que PHASE-02 está ✅ antes de iniciar PHASE-03
```

**Se Phase Board desatualizado:**
1. Identificar tasks completadas desde última atualização
2. Recalcular progresso
3. Atualizar status de tasks
4. Documentar blockers atuais
5. Atualizar data de última modificação

---

### 4. TASKS — Review Task Status

Verificar `docs/development/TASKS/`:

**Checklist de Verificação:**
- [ ] Tasks órfãs (não referenciadas em nenhuma phase) → Identificar
- [ ] Tasks duplicadas → Merge ou marque como obsoleto
- [ ] Tasks com status inválido → Corrigir
- [ ] Tasks sem criterios de aceitação → Adicionar
- [ ] Tasks sem dependências listadas → Verificar
- [ ] Tasks bloqueadas têm motivo documentado

**Análise de Progresso:**
```markdown
## Progresso de Tasks

| Phase | Total | ✅ Completa | 🚧 Em progresso | ⛔ Bloqueada | ⏳ Pendente |
|-------|-------|-------------|-----------------|--------------|------------|
| PHASE-01 | 15 | 15 | 0 | 0 | 0 |
| PHASE-02 | 23 | 12 | 6 | 2 | 3 |
| PHASE-03 | 10 | 0 | 0 | 0 | 10 |

**Total do Projeto:** 48 tasks | 27 ✅ | 6 🚧 | 2 ⛔ | 13 ⏳
**Progresso Geral:** 56%
```

**Tasks Críticas ( próximo sprint):**
1. [TASK-023] — 🚧 Em progresso — eta: hoje
2. [TASK-024] — ⛔ Bloqueada — блокер: TASK-023
3. [TASK-025] — ⏳ Pendente — dependência: TASK-024

---

### 5. SPECS — Review Specifications

Verificar `docs/development/SPECS/`:

**Checklist de Verificação:**
- [ ] SPECs referenciadas em PHASE-01/PRDs existem
- [ ] SPECs órfãs (não referenciadas) → Reportar
- [ ] HELL Specs têm domain model completo
- [ ] HELL Specs têm GRASP assignment map
- [ ] HELL Specs têm gate checklist
- [ ] PRD Specs têm critérios de aceite
- [ ] PRD Specs têm estratégia de execução

**Consistência Cruzada:**
```
Para cada SPEC-XXX.md em SPECS/:
  → Verificar se está referenciada em:
     - ROADMAP.md (se feature principal)
     - PHASE-XX/phase-board.md (se em desenvolvimento)
     - PHASE-XX/prd.md (se PRD)

Se não referenciada → GAP: SPEC órfã
```

**Categorias de Spec:**
| Tipo | Descrição | Template |
|------|-----------|----------|
| hell-spec | Especificação técnica HELL | `templates/hell/hell-spec.template.md` |
| prd | Product Requirements | `templates/prd/prd.template.md` |
| design | Design técnico | `templates/design/design.template.md` |

---

### 6. GAPS — Review and Update Gaps

Verificar `docs/development/GAPS/`:

**Checklist de Verificação:**
- [ ] Todo gap identificado tem documento
- [ ] Gaps têm severity classificada
- [ ] Gaps têm status atual (OPEN/PROPOSED/IMPLEMENTED/WONTFIX)
- [ ] Gaps críticos têm feature proposta
- [ ] Features propostas têm templates selecionados
- [ ] Features aprovadas têm phase designada

**Gap Analysis:**
```markdown
## Gap Analysis — {{YYYY-MM-DD}}

### 🔴 Críticos (devem ser resolvidos esta sprint)
| ID | Gap | Feature | Status |
|----|-----|---------|--------|
| GAP-002 | Auth incompleto | FEATURE-008 | PROPOSED |

### 🟡 Maiores (devem ser resolvidos no roadmap)
| ID | Gap | Feature | Phase |
|----|-----|---------|-------|
| GAP-001 | Analytics missing | FEATURE-005 | PHASE-03 |

### 🟢 Menores (backlog)
| ID | Gap | Prioridade |
|----|-----|------------|
| GAP-003 | Logging fraco | 🔵 BAIXA |
```

**Para cada GAP sem feature proposta:**
- [ ] Analisar e propor feature
- [ ] Criar `GAPS/feature-XXX.md`
- [ ] Definir templates sugeridos
- [ ] Designar phase

---

### 7. CHANGELOG — Update and Verify

Verificar `docs/development/CHANGELOG.md`:

**Checklist de Verificação:**
- [ ] CHANGELOG.md existe
- [ ] Formato está correto (Keep a Changelog)
- [ ] Entradas desde última review estão presentes
- [ ] Formato de data está consistente (YYYY-MM-DD)

**Se CHANGELOG desatualizado:**
```markdown
## [YYYY-MM-DD] — Phase {{XX}} — Sprint {{YY}}

### Added
- [Feature implementada]

### Changed
- [Mudança de comportamento]

### Fixed
- [Bug corrigido]

### Notes
- [Observações]
```

**Sincronizar com Phase Boards:**
```
Se PHASE-02 task TASK-023 foi marcada como ✅
  → Adicionar entrada no CHANGELOG

Se PRD foi atualizado
  → Adicionar em Changed

Se bug crítico foi corrigido
  → Adicionar em Fixed com referência ao gap
```

---

### 8. REPORT — Generate Complete Status Report

Após todas as verificações, gere relatório:

```markdown
---
title: "Phase Board Review Report"
type: report
date: {{YYYY-MM-DD}}
agent: {{agent-name}}
---

# 📊 Phase Board Review Report — {{YYYY-MM-DD}}

## Executive Summary

| Categoria | Status | Issues | Ação Necessária |
|-----------|--------|--------|-----------------|
| INDEX | ✅/⚠️/❌ | {{n}} | {{ação}} |
| ROADMAP | ✅/⚠️/❌ | {{n}} | {{ação}} |
| PHASES | ✅/⚠️/❌ | {{n}} | {{ação}} |
| TASKS | ✅/⚠️/❌ | {{n}} | {{ação}} |
| SPECS | ✅/⚠️/❌ | {{n}} | {{ação}} |
| GAPS | ✅/⚠️/❌ | {{n}} | {{ação}} |
| CHANGELOG | ✅/⚠️/❌ | {{n}} | {{ação}} |

---

## 🔴 Issues Críticos

### Issue 1
**Categoria:** [PHASES/TASKS/SPECS/etc]
**Descrição:** [Descrição]
**Impacto:** [Impacto]
**Recomendação:** [Ação]

---

## 🟡 Issues Maiores

### Issue 1
**Categoria:** [PHASES/TASKS/SPECS/etc]
**Descrição:** [Descrição]
**Recomendação:** [Ação]

---

## 🟢 Observações

- [Observação 1]
- [Observação 2]

---

## 📋 Próximos Passos

1. [Ação 1]
2. [Ação 2]
3. [Ação 3]

---

## ✅ Checklist de Correções

- [ ] INDEX atualizado
- [ ] ROADMAP sincronizado
- [ ] Phase boards verificados
- [ ] Tasks atualizadas
- [ ] Specs verificadas
- [ ] Gaps documentados
- [ ] Changelog atualizado
- [ ] Links verificados
```

---

### 9. VALIDATE — Final Structure Check

Execute verificação final:

```bash
# Estrutura de diretórios
ls -la docs/development/
ls -la docs/development/PHASES/
ls -la docs/development/GAPS/

# Documentos sem referência (órfãos)
# (verificar manualmente ou com grep)

# Consistência de status
grep -r "status:" docs/development/PHASES/ | head -20
```

**Checklist Final:**
- [ ] INDEX atualizado com últimos cambios
- [ ] ROADMAP sincronizado com phases
- [ ] Todas as phases com boards atualizados
- [ ] Progresso de tasks calculado corretamente
- [ ] Specs referenciadas corretamente
- [ ] Gaps críticos mapeados
- [ ] CHANGELOG atualizado desde última review
- [ ] Sem documentos órfãos
- [ ] Links entre documentos funcionando
</process>

<rules>
## Regras de Ouro

1. **INDEX first** — Sempre atualize o índice antes de trabalhar
2. **Consistency check** — Verifique consistência cruzada sempre
3. **No orphan docs** — Todo documento deve ser referenciado
4. **Changelog on change** — Atualize ao completar qualquer task/feature
5. **Gap = Feature** — Todo gap deve ter uma feature proposta
6. **Phase gates** — Não avance phase sem gate approval

## Prioridade de Issues

| Severidade | Ação | Tempo |
|------------|------|-------|
| 🔴 CRITICAL | Resolver imediatamente | Esta sessão |
| 🟡 MAJOR | Resolver esta sprint | Antes do sprint |
| 🟢 MINOR | Backlog | Quando possível |
| 🔵 INFO | Documentar | Oportunamente |

## Prohibited

- ❌ Deixar INDEX desatualizado por mais de 1 sessão
- ❌ Ignorar gap identificado
- ❌ Deixar changelog sem entrada quando task completa
- ❌ Criar spec sem referenciá-la em phase-board
- ❌ Ter tasks órfãs não rastreadas
- ❌ Sincronizar manualmente ao invés de usar phase-board
</rules>
