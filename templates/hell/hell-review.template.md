---
title: "HELL Review: {{project}}"
type: hell-review
mode: analysis
status: draft
version: 1.0.0
author: "{{author}}"
date: "{{date}}"
review-type: full
---

# 💀 HELL Review: {{PROJECT}}

```yaml
Project: "[[{{PROJECT}}]]"
HELL_Phase: Review
Review_Type: full
Status: 🔥 ACTIVE
Health_Score: 0
```

---

## 1. Health Score

### Overall: {{score}}/100 {{🟢🟡🔴}}

| Dimensão | Score | Peso | Weighted |
|:---------|:------|:-----|:---------|
| Architecture | /100 | 25% | |
| Patterns | /100 | 20% | |
| Coverage | /100 | 20% | |
| Security | /100 | 15% | |
| Debt | /100 | 10% | |
| Documentation | /100 | 10% | |
| **TOTAL** | | **100%** | **/100** |

---

## 2. Architecture Compliance

### Layer Separation

| Layer | Status | Violations |
|:------|:-------|:-----------|
| Presentation | ✅ / ❌ | |
| Application | ✅ / ❌ | |
| Domain | ✅ / ❌ | |
| Infrastructure | ✅ / ❌ | |

### Dependency Direction

```
Expected: Presentation → Application → Domain ← Infrastructure
Actual:   [describe actual dependency flow]
```

### Violations Found

| # | Violation | Módulo | Severidade | Fix |
|:--|:----------|:-------|:-----------|:----|
| V1 | | | 🔴 / 🟡 / 🟢 | |
| V2 | | | 🔴 / 🟡 / 🟢 | |

---

## 3. Pattern Map

### Patterns Applied ✅

| Pattern | Tipo | Where | Quality |
|:--------|:-----|:------|:--------|
| | GRASP / GoF | `lib/...` | 🟢 Good / 🟡 OK / 🔴 Bad |
| | GRASP / GoF | `lib/...` | 🟢 / 🟡 / 🔴 |

### Patterns Missing ⚠️

| Pattern Needed | Where it Should Be | Impact if Absent | Effort |
|:--------------|:-------------------|:-----------------|:-------|
| | `lib/...` | HIGH / MED / LOW | S / M / L |
| | `lib/...` | HIGH / MED / LOW | S / M / L |

### Anti-Patterns Detected 🔴

| Anti-Pattern | Location | Severity | Recommended Fix |
|:-------------|:---------|:---------|:---------------|
| | `lib/...` | 🔴 / 🟡 / 🟢 | `/dos-hell:refactor` |
| | `lib/...` | 🔴 / 🟡 / 🟢 | |

---

## 4. Coverage Gaps

| Módulo | Coverage % | Critical Path? | Risk |
|:-------|:-----------|:---------------|:-----|
| | % | ✅ / ❌ | HIGH / MED / LOW |
| | % | ✅ / ❌ | HIGH / MED / LOW |

**Untested Critical Paths:**
1. 
2. 

---

## 5. Feature Suggestions 🚀

| ID | Feature | Baseado Em | Motivação | Prioridade | Effort | Comando |
|:---|:--------|:-----------|:----------|:-----------|:-------|:--------|
| FS-01 | | Pattern gap / Debt reduction | | HIGH / MED / LOW | S / M / L | `/dos-propose {{name}}` |
| FS-02 | | User need / Performance | | HIGH / MED / LOW | S / M / L | `/dos-propose {{name}}` |
| FS-03 | | Extension point / Security | | HIGH / MED / LOW | S / M / L | `/dos-propose {{name}}` |

---

## 6. New Spec Proposals 📋

| ID | Spec Title | Motivação | Status | Ação |
|:---|:-----------|:----------|:-------|:-----|
| SP-01 | | Gap found in review | ⬜ PROPOSED | → `/dos-propose {{name}}` |
| SP-02 | | Feature suggestion | ⬜ PROPOSED | → `/dos-propose {{name}}` |

---

## 7. Security Findings 🔐

| # | Finding | Severity | Location | OWASP | Remediation |
|:--|:--------|:---------|:---------|:------|:-----------|
| SEC-01 | | 🔴 CRITICAL / 🟡 HIGH / 🟢 MED | `lib/...` | | |
| SEC-02 | | 🔴 / 🟡 / 🟢 | `lib/...` | | |

---

## 8. Tech Debt Discovered

| ID | Severity | Description | Location | Effort | Comando |
|:---|:---------|:-----------|:---------|:-------|:--------|
| TD-01 | 🔴 CRITICAL | | `lib/...` | S / M / L | `/dos-hell:debt` |
| TD-02 | 🟡 MAJOR | | `lib/...` | S / M / L | |

---

## 9. Recommended Next Actions

| # | Action | Priority | Comando |
|:--|:-------|:---------|:--------|
| 1 | | 🔴 URGENT | `/dos-hell:{{cmd}}` |
| 2 | | 🟡 HIGH | `/dos-hell:{{cmd}}` |
| 3 | | 🟢 NORMAL | `/dos-hell:{{cmd}}` |

---

## 10. Gate M-REVIEW — Checklist

- [ ] Health score ≥60
- [ ] No blocking findings
- [ ] Feature suggestions triaged (proposed or rejected with reason)
- [ ] New spec proposals created or rejected
- [ ] Tech debt items logged in `memory/hell-tech-debt.md`
- [ ] Security findings with remediation plan

**Gate Status:** ⬜ PENDING | ✅ PASSED | ❌ BLOCKED
