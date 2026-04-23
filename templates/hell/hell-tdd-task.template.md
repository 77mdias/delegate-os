---
title: "HELL TDD Task: {{task_id}}"
type: hell-tdd-task
mode: execution
status: pending
version: 1.0.0
author: "{{author}}"
date: "{{date}}"
related-docs: ["hell-spec.md", "hell-tdd-log.md"]
---

# 💀 TDD Task: {{TASK_ID}} — {{TITLE}}

```yaml
HELL_Phase: TDD
Status: ⬜ PENDING
Pattern_Target: {{pattern}}
Spec_Ref: RF-{{id}}
```

---

## 1. Identificação

| Campo | Valor |
|:------|:------|
| **Task ID** | {{task_id}} |
| **Spec Ref** | RF-{{id}} |
| **Tipo** | feature / fix / refactor |
| **Prioridade** | 🔴 Crítica / 🟡 Alta / 🟢 Média |
| **Estimativa** | {{time}} |
| **Pattern Target** | {{GRASP/GoF pattern}} |

---

## 2. Contrato (Given/When/Then)

```
Given: [precondição — estado do sistema antes da ação]
When:  [ação — o que o ator/sistema executa]
Then:  [resultado — o que DEVE acontecer]
```

---

## 3. 🔴 RED — Test First

**Test File:** `test/{{path}}/{{name}}_test.{{ext}}`

```{{lang}}
// Write the test that MUST FAIL

test('should {{behavior}}', () {
  // Arrange (Given)
  
  // Act (When)
  
  // Assert (Then)
  
});
```

- [ ] Test compiles
- [ ] Test FAILS ✅
- Commit: `test: RED — {{test_name}}`

---

## 4. 🟢 GREEN — Minimal Code

**Implementation File:** `lib/{{path}}/{{name}}.{{ext}}`

```{{lang}}
// Write MINIMUM code to make the test pass
// NO optimization. NO extras. Just enough.
```

- [ ] Test PASSES ✅
- [ ] ZERO code beyond what's needed
- Commit: `feat: GREEN — {{feature}}`

---

## 5. 🔵 REFACTOR — Pattern Application

**Smell detected:** [none / duplication / long method / ...]
**Pattern applied:** [none / Strategy / Factory / ...]

```{{lang}}
// Refactored code (if pattern applied)
```

**Justificativa:** [WHY this pattern — what problem it solves HERE]

- [ ] ALL tests still GREEN ✅
- [ ] Pattern documented in TDD Log
- Commit: `refactor: {{pattern}} — {{justification}}`

---

## 6. GRASP Validation

| Principle | Satisfied? | Evidence |
|:----------|:-----------|:---------|
| Information Expert | ✅ / ❌ | |
| Creator | ✅ / ❌ / N/A | |
| Controller | ✅ / ❌ / N/A | |
| Low Coupling | ✅ / ❌ | |
| High Cohesion | ✅ / ❌ | |

---

## 7. Definition of Done

- [ ] Test written and failing (RED) ✅
- [ ] Minimal code passes test (GREEN) ✅
- [ ] Code refactored with pattern (REFACTOR) ✅
- [ ] GRASP validation passed
- [ ] Lint clean
- [ ] Type check clean
- [ ] Commit messages follow convention
- [ ] TDD Log updated

---

## 8. Notes / Decisions

[Any notes, blockers, or technical decisions made during this task]
