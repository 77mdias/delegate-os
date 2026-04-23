---
title: "HELL Cycle Status: {{project}}"
type: hell-status
mode: dashboard
status: active
version: 1.0.0
date: "{{date}}"
---

# 💀 HELL Cycle Status: {{PROJECT}}

```yaml
Project: "[[{{PROJECT}}]]"
Status: 🔥 ACTIVE
Current_Phase: {{phase}}
Last_Gate: {{gate_status}}
```

---

## Cycle Progress

| Phase | Status | Gate | Score | Date |
|:------|:-------|:-----|:------|:-----|
| SPEC | ✅ Done / 🔥 Active / ⬜ Pending | M-SPEC | %  | |
| TDD | ✅ / 🔥 / ⬜ | M-TEST | % | |
| REFACTOR | ✅ / 🔥 / ⬜ | M-QUALITY | % | |
| EVOLVE | ✅ / 🔥 / ⬜ | M-SHIP | % | |
| REVIEW | ✅ / 🔥 / ⬜ | M-REVIEW | % | |

---

## Metrics

| Metric | Value | Target | Status |
|:-------|:------|:-------|:-------|
| Coverage | % | ≥80% | ✅ / ❌ |
| Audit Score | % | ≥70% | ✅ / ❌ |
| Review Health | /100 | ≥60 | ✅ / ❌ |
| Tech Debt Score | | ≤50 | ✅ / ❌ |
| Open Critical | | 0 | ✅ / ❌ |

---

## Artifacts Generated

| Artifact | Status | Location |
|:---------|:-------|:---------|
| hell-spec.md | ✅ / ⬜ | `changes/{{proposal}}/` |
| hell-tdd-log.md | ✅ / ⬜ | `changes/{{proposal}}/` |
| hell-refactor-report.md | ✅ / ⬜ | `changes/{{proposal}}/` |
| hell-evolution-status.md | ✅ / ⬜ | `changes/{{proposal}}/` |
| hell-review.md | ✅ / ⬜ | `changes/{{proposal}}/` |
| hell-audit-report.md | ✅ / ⬜ | `changes/{{proposal}}/` |
| hell-milestone.md | ✅ / ⬜ | `changes/{{proposal}}/` |
| hell-tech-debt.md | ✅ / ⬜ | `memory/` |
| ADRs | ✅ / ⬜ | `changes/{{proposal}}/decisions/` |

---

## Quick Actions

| Ação | Comando |
|:-----|:--------|
| Run next phase | `/dos-hell:{{next_phase}}` |
| Check milestone | `/dos-hell:milestone {{type}}` |
| Review codebase | `/dos-hell:review` |
| Audit classes | `/dos-hell:audit` |
| Manage debt | `/dos-hell:debt` |
