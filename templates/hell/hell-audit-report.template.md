---
title: "HELL Audit Report: {{project}}"
type: hell-audit
mode: analysis
status: draft
version: 1.0.0
author: "{{author}}"
date: "{{date}}"
---

# 💀 HELL Audit Report: {{PROJECT}}

```yaml
Project: "[[{{PROJECT}}]]"
HELL_Phase: Audit
Status: 🔥 ACTIVE
Total_Classes: 0
Total_Checks: 0
Passed_Checks: 0
Audit_Score: 0%
```

---

## 1. Summary

**Audit Score:** {{passed}}/{{total}} checks passed ({{percentage}}%)

| Severity | Count |
|:---------|:------|
| 🔴 Critical Violations | |
| 🟡 Warnings | |
| 🟢 OK | |

---

## 2. Per-Class Audit

### Class: `{{ClassName}}`

**File:** `lib/{{path}}`
**LOC:** {{loc}}
**Dependencies:** {{count}}

#### GRASP Checklist

| # | Principle | Status | Evidence |
|:--|:----------|:-------|:---------|
| 1 | **Information Expert** — operates on OWN data? | ✅ / ❌ | |
| 2 | **Creator** — creates entities it contains/uses? | ✅ / ❌ | |
| 3 | **Controller** — no business logic in presentation? | ✅ / ❌ | |
| 4 | **Low Coupling** — ≤3 deps from same level? | ✅ / ❌ | |
| 5 | **High Cohesion** — ≤200 LOC or justified? | ✅ / ❌ | |
| 6 | **Polymorphism** — no switch/if >3 branches? | ✅ / ❌ | |
| 7 | **Pure Fabrication** — technical concerns separated? | ✅ / ❌ | |
| 8 | **Indirection** — mediators where needed? | ✅ / ❌ | |
| 9 | **Protected Variations** — interfaces for unstable points? | ✅ / ❌ | |

#### SOLID Checklist

| # | Principle | Status | Evidence |
|:--|:----------|:-------|:---------|
| 1 | **SRP** — one reason to change? | ✅ / ❌ | |
| 2 | **OCP** — open for extension, closed for modification? | ✅ / ❌ | |
| 3 | **LSP** — subtypes substitute supertypes? | ✅ / ❌ | |
| 4 | **ISP** — no forced dependency on unused methods? | ✅ / ❌ | |
| 5 | **DIP** — depends on abstractions, not concretes? | ✅ / ❌ | |

**Score:** {{passed}}/14 | **Severity:** 🟢 OK / 🟡 WARNING / 🔴 CRITICAL

---

### Class: `{{ClassName2}}`

_(repetir bloco GRASP + SOLID para cada classe)_

---

## 3. Critical Violations (Action Required)

| # | Class | Principle | Violation | Fix Command |
|:--|:------|:----------|:----------|:-----------|
| 1 | | | | `/dos-hell:refactor` |
| 2 | | | | `/dos-hell:tdd` |

---

## 4. Warnings

| # | Class | Principle | Warning | Recommendation |
|:--|:------|:----------|:--------|:--------------|
| 1 | | | | |
| 2 | | | | |

---

## 5. Recommendations

| Priority | Recommendation | Affected Classes | Command |
|:---------|:-------------- |:----------------|:--------|
| 🔴 HIGH | | | `/dos-hell:refactor` |
| 🟡 MED | | | `/dos-hell:tdd` |
| 🟢 LOW | | | |

---

## 6. Audit Score by Class

| Class | GRASP | SOLID | Total | Severity |
|:------|:------|:------|:------|:---------|
| | /9 | /5 | /14 | 🟢 / 🟡 / 🔴 |
| | /9 | /5 | /14 | 🟢 / 🟡 / 🔴 |
| **AVG** | **/9** | **/5** | **/14** | |
