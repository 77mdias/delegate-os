---
title: "Phase {{XX}}: {{Phase Name}}"
type: phase-board
status: 🔵 Planejada
version: 1.0.0
last-updated: "{{YYYY-MM-DD}}"
phase-number: "{{XX}}"
phase-name: "{{Phase Name}}"
sprint-atual: "Sprint {{YY}}"
status-geral: "🟡 0% (0/0 tarefas completas) - PLANEJAMENTO"
eta: "{{Estimativa de tempo}}"
pre-requisito: "{{Phase ou recurso necessário}}"
---

# 🧪 Tasks - Fase {{XX}}: {{Phase Name}}

**Status:** {{🟢 ATIVA|🔵 Planejada|⚪ Arquivada}}
**Última atualização:** {{YYYY-MM-DD}}
**Sprint Atual:** {{Sprint Atual}}
**Status Geral:** {{Status Geral com % e tarefas}}
**ETA:** {{Tempo estimado}}
**Pré-requisito:** {{Pré-requisito}}

---

> **📌 NOTA:** {{Nota contextual sobre a fase, estratégia, decisões importantes}}

---

## 📊 Resumo de Progresso

| Categoria | Total | Concluído | Em Andamento | Pendente | Bloqueado |
| --- | --- | --- | --- | --- | --- |
| {{Categoria 1}} | {{N}} | {{N}} | {{N}} | {{N}} | {{N}} |
| {{Categoria 2}} | {{N}} | {{N}} | {{N}} | {{N}} | {{N}} |
| **TOTAL** | **{{N}}** | **{{N}}** | **{{N}}** | **{{N}}** | **{{N}}** |

### 🎯 Principais Indicadores
- {{✅|⚠️|❌}} {{Indicador 1 com data se concluído}}
- {{✅|⚠️|❌}} {{Indicador 2 com data se concluído}}
- {{✅|⚠️|❌}} {{Indicador 3}}

---

## 🎯 Objetivos da Fase

{{Lista de objetivos em formato de bullet points}}

---

## 📦 Estrutura de Categorias

### 📦 {{Categoria 1}} - {{Nome da Categoria}}

#### Objetivo
{{Descrição do objetivo desta categoria}}

#### {{TASK-ID}} - {{Nome da Task}}

- [ ] **{{PHASE-XX-CAT-001}}** - {{Nome da Task}} {{🔴|🟡|🟢|🔵}} ({{YYYY-MM-DD}})

  **Descrição curta:**
  {{Descrição clara e concisa do que será feito}}

  **Implementação sugerida:**
  {{Passos sugeridos para implementação}}

  **Arquivos/áreas afetadas:** {{Lista de arquivos e áreas}}

  **Critérios de aceitação:**
  - [ ] {{Critério 1}}
  - [ ] {{Critério 2}}
  - [ ] {{Critério 3}}

  **Notas de implementação:**
  {{Notas sobre decisões de design, técnicas, pitfalls}}

  **Prioridade:** {{🔴 Crítica|🟡 Alta|🟢 Média|🔵 Baixa}}
  **Estimativa:** {{Tempo estimado em horas}}
  **Dependências:** {{PHASE-XX-XXX ou "nenhuma"}}
  **Status:** {{🔴 Pendente|🚧 Em progresso|✅ Concluído|⛔ Bloqueada}}

---

### 📦 {{Categoria 2}} - {{Nome da Categoria}}

#### Objetivo
{{Descrição do objetivo desta categoria}}

#### {{TASK-ID}} - {{Nome da Task}}

- [ ] **{{PHASE-XX-CAT-001}}** - {{Nome da Task}} {{🔴|🟡|🟢|🔵}}

  **Descrição curta:**
  {{Descrição clara e concisa}}

  **Implementação sugerida:**
  {{Passos}}

  **Arquivos/áreas afetadas:** {{Lista}}

  **Critérios de aceitação:**
  - [ ] {{Critério 1}}
  - [ ] {{Critério 2}}

  **Notas de implementação:**
  {{Notas}}

  **Prioridade:** {{🔴|🟡|🟢|🔵}}
  **Estimativa:** {{Tempo}}
  **Dependências:** {{Dependência ou "nenhuma"}}
  **Status:** {{🔴|🚧|✅|⛔}}

---

## 🧪 Testes e Validações

{{Seção específica para estratégia de teste da fase}}

- **Framework:** {{Ferramenta de teste}}
- **Cobertura alvo:** {{Número de cenários}}
- **Comandos de verificação:**
  ```bash
  {{comando 1}}
  {{comando 2}}
  ```
- **Estratégia de dados:** {{Estratégia de dados para testes}}

---

## 📚 Documentação e Comunicação

- Atualizar `{{caminho do docs/TASKS.md}}` com referência desta fase ao iniciar execução.
- Atualizar `{{caminho do CHANGELOG.md}}` sob `[Unreleased]` ao concluir blocos da fase.
- Documentar decisões importantes em `{{caminho}}`.
- Registrar decisões de implementação neste arquivo para evitar divergência entre PRs.

---

## ✅ Checklist de Encerramento da Fase

- [ ] Todas as tarefas da fase concluídas com status atualizado
- [ ] {{Critério de encerramento 1}}
- [ ] {{Critério de encerramento 2}}
- [ ] {{Critério de encerramento 3}}
- [ ] {{Critério de encerramento 4}}
- [ ] Documentação de task/changelog atualizada
- [ ] Aprovação final registrada em PR/issue

Ao finalizar, mover para estado "ARQUIVADA" e registrar nota histórica no topo com data e resumo de entregas.
