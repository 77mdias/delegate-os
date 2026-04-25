# HELL Phase Board

Sistema central de revisão e organização documental para super agents.

## Quick Start

```bash
/dos-hell:phase-board
```

## Estrutura

```
skills/dos/hell/phase-board/
├── SKILL.md                      # Skill principal (workflow completo)
├── README.md                     # Este arquivo
└── templates/
    ├── roadmap.template.md       # Roadmap de projeto
    ├── gap.template.md          # Gap document
    ├── feature.template.md      # Feature proposal
    └── gap-analysis.template.md # Gap analysis report
```

## COMPLETE REVIEW WORKFLOW

Execute revisão completa de todas as categorias:

```
INDEX → ROADMAP → PHASES → TASKS → SPECS → GAPS → CHANGELOG → REPORT
```

### 1. INDEX
- Verifica/atualiza `docs/development/README.md`
- Status de todas as phases
- Links para todos os documentos
- Tasks em andamento

### 2. ROADMAP
- Verifica `docs/development/ROADMAP.md`
- Consistencia com phase boards
- Timeline atual
- Features e gaps listados

### 3. PHASES
- Revisa todos os phase boards
- Progresso sincronizado
- Tasks com status, criterios, dependencias
- Blockers documentados

### 4. TASKS
- Tasks órfãs (não referenciadas)
- Duplicatas
- Status invalidos
- Progresso calculado

### 5. SPECS
- Specs referenciadas existem
- HELL Specs completas (domain model, GRASP)
- PRD Specs com criterios de aceite

### 6. GAPS
- Todo gap tem documento
- Severity classificada
- Gap crítico tem feature proposta

### 7. CHANGELOG
- Formato Keep a Changelog
- Entradas desde última review
- Sincronizado com phase boards

### 8. REPORT
- Status geral por categoria
- Issues críticos/maiores
- Próximos passos

---

## Templates

| Template | Caminho | Uso |
|----------|---------|-----|
| phase-board | `templates/tasks/phase-board.template.md` | Phase/Sprint tracking |
| sprint | `templates/tasks/sprint.template.md` | Sprint planning |
| single-task | `templates/tasks/single-task.template.md` | Unit task |
| hell-spec | `templates/hell/hell-spec.template.md` | HELL Specification |
| prd | `templates/prd/prd.template.md` | Product Requirements |
| changelog | `templates/spec/changelog.template.md` | Changelog |
| roadmap | `skills/dos/hell/phase-board/templates/roadmap.template.md` | Roadmap |
| gap | `skills/dos/hell/phase-board/templates/gap.template.md` | Gap |
| feature | `skills/dos/hell/phase-board/templates/feature.template.md` | Feature |

---

## Directory Structure

```
docs/development/
├── README.md                      # Índice central
├── ROADMAP.md                    # Roadmap
├── CHANGELOG.md                 # Changelog global
├── PHASES/
│   └── PHASE-XX/
│       ├── phase-board.md
│       ├── prd.md
│       ├── hell-spec.md
│       └── changelog.md
├── SPRINTS/
│   └── SPRINT-YY-sprint.md
├── TASKS/
│   ├── TASK-ID.md
│   └── PHASE-XX-tasks.md
├── SPECS/
├── PROPOSALS/
└── GAPS/
    ├── gap-XXX.md
    └── feature-YYY.md
```

---

## Categorias de Gap

| Severity | Significado | Ação |
|----------|------------|------|
| 🔴 CRITICAL | Seguranca/performance | Imediato |
| 🟡 MAJOR | Funcionalidade fraca | Próximo sprint |
| 🟢 MINOR | Melhoria | Backlog |
| 🔵 INFO | Observação | Quando possível |

---

## Prioridade de Issues

| Severidade | Tempo |
|------------|-------|
| 🔴 CRITICAL | Esta sessão |
| 🟡 MAJOR | Antes do sprint |
| 🟢 MINOR | Quando possível |

---

## Regras de Ouro

1. **INDEX first** — Sempre atualize índice antes de trabalhar
2. **Consistency check** — Verifique consistência cruzada
3. **No orphan docs** — Todo documento referenciado
4. **Changelog on change** — Atualize ao completar
5. **Gap = Feature** — Todo gap tem feature proposta
6. **Phase gates** — Não avance sem gate approval
