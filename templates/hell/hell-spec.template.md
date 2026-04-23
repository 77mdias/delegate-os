---
title: "HELL Specification: {{module}}"
type: hell-spec
mode: specification
status: draft
version: 1.0.0
author: "{{author}}"
date: "{{date}}"
related-docs: ["proposal/{{proposal-link}}.md"]
---

# 💀 HELL Specification: {{MODULE}}

```yaml
Project: "[[{{PROJECT}}]]"
HELL_Phase: Requisitos
HELL_Gate: PENDING
Status: 🔥 ACTIVE
Patterns_Used: [Information_Expert, Creator, Protected_Variations]
```

---

## 1. Interrogatório de Requisitos

### 1.1 Requisitos Funcionais

| ID | Caso de Uso | Ator | Ação | Resultado Esperado | Prioridade |
|:---|:------------|:-----|:-----|:-------------------|:-----------|
| RF-01 | | | | | MUST |
| RF-02 | | | | | MUST |
| RF-03 | | | | | SHOULD |
| RF-04 | | | | | COULD |
| RF-05 | | | | | WONT |

### 1.2 Requisitos Não-Funcionais

| ID | Categoria | Métrica | Target | Verificação |
|:---|:----------|:--------|:-------|:------------|
| RNF-01 | Performance | Latência p99 | <200ms | Load test |
| RNF-02 | Segurança | Auth method | JWT + RBAC | Pen test |
| RNF-03 | Disponibilidade | Uptime | 99.9% | Monitoring |
| RNF-04 | Escalabilidade | Concurrent users | 10k | Stress test |

### 1.3 Constraints

| Constraint | Tipo | Descrição |
|:-----------|:-----|:----------|
| | Stack | |
| | Budget | |
| | Regulatório | |
| | Timeline | |

---

## 2. Domain Model (GRASP)

### 2.1 Entidades

| Entidade | Responsabilidade (Information Expert) | Atributos | Creator |
|:---------|:--------------------------------------|:----------|:--------|
| | | | |
| | | | |

### 2.2 Value Objects

| Value Object | Pertence a | Regras de Validação |
|:-------------|:-----------|:--------------------|
| | | |
| | | |

### 2.3 Aggregates

| Aggregate Root | Entidades Contidas | Invariantes |
|:---------------|:-------------------|:------------|
| | | |

### 2.4 Domain Events

| Evento | Trigger | Handlers |
|:-------|:--------|:---------|
| | | |

---

## 3. Pontos de Variação (Protected Variations)

| ID | O que Pode Mudar | Interface Protetora | Implementações Previstas |
|:---|:-----------------|:-------------------|:------------------------|
| PV-01 | | | |
| PV-02 | | | |
| PV-03 | | | |

---

## 4. GRASP Assignment Map

| Classe/Módulo | Expert (dados) | Creator (quem cria) | Controller (quem orquestra) |
|:--------------|:---------------|:--------------------|:---------------------------|
| | | | |
| | | | |

---

## 5. Ubiquitous Language

| Termo do Domínio | Definição Técnica | Contexto de Uso |
|:-----------------|:------------------|:----------------|
| | | |
| | | |

---

## 6. Edge Cases & Boundary Conditions

| Cenário | Input | Comportamento Esperado | Prioridade |
|:--------|:------|:-----------------------|:-----------|
| | | | |
| | | | |

---

## 7. Gate M-SPEC — Checklist

- [ ] Todos os requisitos têm prioridade (MUST/SHOULD/COULD/WONT)
- [ ] Domínio modelado com Entities, VOs, Aggregates
- [ ] Pontos de variação identificados com interfaces
- [ ] Ubiquitous Language documentado
- [ ] Edge cases mapeados
- [ ] GRASP assignment map completo
- [ ] Nenhuma pergunta aberta pendente

**Gate Status:** ⬜ PENDING | ✅ PASSED | ❌ BLOCKED

---

## 8. Perguntas Abertas

| # | Pergunta | Status | Resposta |
|:--|:---------|:-------|:---------|
| 1 | | ⬜ OPEN | |
| 2 | | ⬜ OPEN | |

---

## 9. Próximo Passo

→ Gate M-SPEC aprovado → Prosseguir para `/dos-hell:tdd`
