---
title: "HELL Milestone: {{type}}"
type: hell-milestone
mode: gate
status: pending
version: 1.0.0
author: "{{author}}"
date: "{{date}}"
milestone-type: "{{M-SPEC|M-TEST|M-QUALITY|M-SHIP|M-REVIEW}}"
---

# 💀 Milestone Gate: {{TYPE}}

```yaml
Project: "[[{{PROJECT}}]]"
HELL_Phase: Milestone
Milestone_Type: {{M-SPEC|M-TEST|M-QUALITY|M-SHIP|M-REVIEW}}
Status: ⬜ PENDING
Score: 0%
Verdict: PENDING
```

---

## 1. Verdict

### {{✅ PASSED | ⚠️ CONDITIONAL | ❌ BLOCKED}}

**Score:** {{passed}}/{{total}} criteria passed ({{percentage}}%)

---

## 2. Criteria Results

### M-SPEC Criteria
_(usar quando `milestone-type: M-SPEC`)_

| # | Criterion | Status | Notes |
|:--|:----------|:-------|:------|
| 1 | All requirements have priority (MUST/SHOULD/COULD/WONT) | ✅ / ❌ | |
| 2 | Domain modeled (Entities, VOs, Aggregates) | ✅ / ❌ | |
| 3 | Variation points identified with interfaces | ✅ / ❌ | |
| 4 | Ubiquitous Language documented | ✅ / ❌ | |
| 5 | No open questions blocking progress | ✅ / ❌ | |
| 6 | User/stakeholder approval obtained | ✅ / ❌ | |

### M-TEST Criteria
_(usar quando `milestone-type: M-TEST`)_

| # | Criterion | Status | Notes |
|:--|:----------|:-------|:------|
| 1 | Test coverage ≥80% (lines AND branches) | ✅ / ❌ | |
| 2 | Zero test failures | ✅ / ❌ | |
| 3 | Zero skipped/ignored tests | ✅ / ❌ | |
| 4 | All critical paths have tests | ✅ / ❌ | |
| 5 | TDD log documented | ✅ / ❌ | |

### M-QUALITY Criteria
_(usar quando `milestone-type: M-QUALITY`)_

| # | Criterion | Status | Notes |
|:--|:----------|:-------|:------|
| 1 | HELL Audit score ≥70% | ✅ / ❌ | |
| 2 | No critical code smells | ✅ / ❌ | |
| 3 | Average coupling <5 dependencies | ✅ / ❌ | |
| 4 | All classes have GRASP justification | ✅ / ❌ | |
| 5 | Diagrams updated (sequence + class) | ✅ / ❌ | |

### M-SHIP Criteria
_(usar quando `milestone-type: M-SHIP`)_

| # | Criterion | Status | Notes |
|:--|:----------|:-------|:------|
| 1 | CI/CD pipeline green | ✅ / ❌ | |
| 2 | Zero critical vulnerabilities | ✅ / ❌ | |
| 3 | Tech debt cataloged in memory/hell-tech-debt.md | ✅ / ❌ | |
| 4 | Documentation 100% synced | ✅ / ❌ | |
| 5 | Review completed (/dos-hell:review) | ✅ / ❌ | |
| 6 | Breaking changes documented | ✅ / ❌ | |

### M-REVIEW Criteria
_(usar quando `milestone-type: M-REVIEW`)_

| # | Criterion | Status | Notes |
|:--|:----------|:-------|:------|
| 1 | Review score ≥60 | ✅ / ❌ | |
| 2 | No blocking findings | ✅ / ❌ | |
| 3 | Feature suggestions triaged | ✅ / ❌ | |
| 4 | New spec proposals created or rejected | ✅ / ❌ | |
| 5 | Tech debt items logged | ✅ / ❌ | |

---

## 3. Blocking Issues

| # | Issue | Severity | Fix Command | Responsible |
|:--|:------|:---------|:-----------|:-----------|
| 1 | | 🔴 CRITICAL | `/dos-hell:{{cmd}}` | |
| 2 | | 🟡 MAJOR | `/dos-hell:{{cmd}}` | |

---

## 4. Action Items (Conditional)

| # | Action | Priority | Deadline | Command |
|:--|:-------|:---------|:---------|:--------|
| 1 | | 🔴 URGENT | | `/dos-hell:{{cmd}}` |
| 2 | | 🟡 HIGH | | `/dos-hell:{{cmd}}` |

---

## 5. Milestone History

| Date | Type | Score | Verdict | Notes |
|:-----|:-----|:------|:--------|:------|
| {{date}} | {{type}} | {{score}}% | {{verdict}} | Initial evaluation |
| | | | | Re-evaluation after fix |

---

## 6. Next Step

- ✅ PASSED → Prosseguir para: `{{next_step}}`
- ⚠️ CONDITIONAL → Resolver action items e prosseguir com monitoramento
- ❌ BLOCKED → Executar fix commands e re-run: `/dos-hell:milestone {{type}}`
