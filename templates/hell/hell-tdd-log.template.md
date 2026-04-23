---
title: "HELL TDD Log: {{module}}"
type: hell-tdd
mode: development
status: draft
version: 1.0.0
author: "{{author}}"
date: "{{date}}"
related-docs: ["hell-spec.md"]
---

# 💀 HELL TDD Log: {{MODULE}}

```yaml
Project: "[[{{PROJECT}}]]"
HELL_Phase: TDD
HELL_Gate: PENDING
Status: 🔥 ACTIVE
Coverage: 0
Tests_Total: 0
Tests_Passing: 0
Tests_Failing: 0
Tests_Skipped: 0
```

---

## 1. Test Suites

### Suite: {{ClassName}}

**File:** `test/{{path}}/{{class}}_test.{{ext}}`
**Subject:** `lib/{{path}}/{{class}}.{{ext}}`

---

## 2. TDD Cycles

### Cycle C1 — {{test_description}}

#### 🔴 RED — Define Contract

```
Given: [precondição / estado inicial]
When:  [ação executada]
Then:  [resultado esperado]
```

**Test Code:**
```{{lang}}
// TODO: test code here
```

- [ ] Teste compila
- [ ] Teste FALHA ✅
- Commit: `test: RED — {{test_name}}`

#### 🟢 GREEN — Minimal Implementation

**Implementation:**
```{{lang}}
// TODO: minimal code to pass
```

- [ ] Teste PASSA ✅
- [ ] ZERO código além do necessário
- Commit: `feat: GREEN — {{feature_name}}`

#### 🔵 REFACTOR — Clean + Pattern

**Smell detected:** [nenhum | duplicação | método longo | ...]
**Pattern applied:** [nenhum | Strategy | Factory | ...]
**Justificativa:** [por que este padrão]

- [ ] Todos os testes continuam VERDES ✅
- Commit: `refactor: {{pattern}} — {{justification}}`

---

### Cycle C2 — {{test_description}}

#### 🔴 RED

```
Given: 
When:  
Then:  
```

- [ ] FALHA ✅

#### 🟢 GREEN

- [ ] PASSA ✅

#### 🔵 REFACTOR

**Pattern:** 
**Justificativa:** 

- [ ] Testes verdes ✅

---

### Cycle C3 — {{test_description}}

_(copiar estrutura acima para cada ciclo adicional)_

---

## 3. Coverage Report

| Módulo | Linhas | Branches | Funções | Status |
|:-------|:-------|:---------|:--------|:-------|
| | %  | % | % | |
| | %  | % | % | |
| **TOTAL** | **%** | **%** | **%** | |

---

## 4. TDD Summary

| Ciclo | Teste | RED | GREEN | REFACTOR | Padrão Aplicado |
|:------|:------|:----|:------|:---------|:---------------|
| C1 | | ✅ FAIL | ✅ PASS | ✅ CLEAN | |
| C2 | | ✅ FAIL | ✅ PASS | ✅ CLEAN | |
| C3 | | ✅ FAIL | ✅ PASS | ✅ CLEAN | |

---

## 5. Commit Log

| # | Hash | Tipo | Mensagem |
|:--|:-----|:-----|:---------|
| 1 | | `test:` | RED — |
| 2 | | `feat:` | GREEN — |
| 3 | | `refactor:` | — |

---

## 6. Gate M-TEST — Checklist

- [ ] Coverage ≥80% (linhas E branches)
- [ ] Zero testes falhando
- [ ] Zero testes pulados (skipped/ignored)
- [ ] Todos os caminhos críticos testados
- [ ] Cada classe tem justificativa de padrão GRASP
- [ ] Commits seguem convenção `test:`, `feat:`, `refactor:`
- [ ] TDD log documentado (esta tabela)

**Gate Status:** ⬜ PENDING | ✅ PASSED | ❌ BLOCKED

---

## 7. Próximo Passo

→ Gate M-TEST aprovado → Prosseguir para `/dos-hell:refactor`
