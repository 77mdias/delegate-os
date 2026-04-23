---
name: dos-hell:milestone
description: "HELL Milestone — Workflow checkpoint gate with quality criteria and go/no-go decision"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Milestone — Ponto de controle crucial dentro de qualquer workflow.

O Milestone é um GATE obrigatório que bloqueia progresso se critérios 
de qualidade não forem atendidos. Ele integra com BMAD, OpenSpec e 
o ciclo HELL como checkpoint universal.

"Nenhuma fase avança sem aprovação do Milestone. Sem exceção."
</objective>

<context>
## Milestone Integration Points

```
BMAD Workflow:
  ANALYSIS ──► [M1] ──► PLANNING ──► [M2] ──► SOLUTIONING ──► [M3] ──► IMPLEMENTATION ──► [M4]

OpenSpec Workflow:
  proposal ──► [M1] ──► specs ──► [M2] ──► design ──► [M3] ──► tasks ──► [M4] ──► implement ──► [M5]

HELL Cycle:
  SPEC ──► [M1] ──► TDD ──► [M2] ──► REFACTOR ──► [M3] ──► EVOLVE ──► [M4]

Standalone:
  Any workflow step ──► /dos-hell:milestone ──► next step
```

## Milestone Types

| Type | Gate Criteria | When to Use |
|------|-------------|-------------|
| **M-SPEC** | Requirements complete, domain mapped | After spec/planning |
| **M-TEST** | Coverage ≥80%, zero failures | After TDD/implementation |
| **M-QUALITY** | Audit score ≥70%, no critical smells | After refactor |
| **M-SHIP** | Pipeline green, docs synced, debt logged | Before deploy |
| **M-REVIEW** | Review score ≥60, no blockers | After review |
| **M-CUSTOM** | User-defined criteria | Any time |

## Milestone Status

- ✅ **PASSED** — All criteria met. Proceed.
- ⚠️ **CONDITIONAL** — Minor issues. Proceed with caution + action items.
- ❌ **BLOCKED** — Critical issues. DO NOT proceed. Fix and re-evaluate.
</context>

<process>
## 1. DETECT — Identify Which Milestone

1. Check current workflow state:
   - Is there an active BMAD phase? → Use BMAD milestone
   - Is there an active OpenSpec artifact? → Use OpenSpec milestone
   - Is there an active HELL cycle? → Use HELL milestone
   - Otherwise → Use standalone (M-CUSTOM)

2. Determine milestone type from context or user argument:
   - `/dos-hell:milestone spec` → M-SPEC
   - `/dos-hell:milestone test` → M-TEST
   - `/dos-hell:milestone quality` → M-QUALITY
   - `/dos-hell:milestone ship` → M-SHIP
   - `/dos-hell:milestone review` → M-REVIEW
   - `/dos-hell:milestone` (no arg) → Auto-detect from workflow state

## 2. EVALUATE — Run Gate Criteria

### M-SPEC Gate
- [ ] All requirements have priority (MUST/SHOULD/COULD/WONT)
- [ ] Domain model exists with Entities, VOs, Aggregates
- [ ] Variation points identified with interfaces
- [ ] Ubiquitous Language documented
- [ ] No open questions blocking progress
- [ ] Stakeholder/user approval obtained

### M-TEST Gate
- [ ] Test coverage ≥80% (lines AND branches)
- [ ] Zero test failures
- [ ] Zero skipped/ignored tests
- [ ] All critical paths have tests
- [ ] TDD log documented

### M-QUALITY Gate
- [ ] HELL Audit score ≥70% (run /dos-hell:audit if needed)
- [ ] No critical code smells
- [ ] Average coupling <5 dependencies
- [ ] All classes have GRASP justification
- [ ] Diagrams updated (sequence + class)

### M-SHIP Gate
- [ ] CI/CD pipeline green
- [ ] Zero critical vulnerabilities
- [ ] Tech debt cataloged in memory/hell-tech-debt.md
- [ ] Documentation 100% synced (README, CHANGELOG, API docs)
- [ ] Review completed (/dos-hell:review)
- [ ] Breaking changes documented

### M-REVIEW Gate
- [ ] HELL Review score ≥60
- [ ] No blocking findings
- [ ] Feature suggestions triaged
- [ ] New spec proposals created or rejected with reason
- [ ] Tech debt items logged

### M-CUSTOM Gate
- Ask user for custom criteria
- Evaluate each criterion
- Score pass/fail

## 3. VERDICT — Go/No-Go Decision

Calculate:
- **Total criteria** for this milestone type
- **Passed criteria**
- **Failed criteria** (with severity)
- **Score** = passed / total * 100

Decision logic:
- Score ≥90% AND zero critical failures → ✅ PASSED
- Score ≥70% AND zero critical failures → ⚠️ CONDITIONAL
- Score <70% OR any critical failure → ❌ BLOCKED

## 4. GENERATE — Milestone Report

Generate/update `hell-milestone.md` in `changes/[proposal]/`:

```markdown
---
Project: [[PROJECT]]
HELL_Phase: Milestone
Milestone_Type: [M-SPEC|M-TEST|M-QUALITY|M-SHIP|M-REVIEW|M-CUSTOM]
Status: [✅ PASSED|⚠️ CONDITIONAL|❌ BLOCKED]
Score: [X]%
---

# Milestone Gate: [Type]

## Verdict: [✅|⚠️|❌] [PASSED|CONDITIONAL|BLOCKED]
## Score: [X]/[Y] criteria passed ([Z]%)

## Criteria Results
| # | Criterion | Status | Notes |
|---|-----------|--------|-------|
| 1 | [criterion] | ✅/❌ | [details] |

## Blocking Issues (if any)
| Issue | Severity | Fix Command |
|-------|----------|-------------|
| [issue] | 🔴 CRITICAL | /dos-hell:[cmd] |

## Action Items (for CONDITIONAL)
| Action | Priority | Command |
|--------|----------|---------|
| [action] | HIGH | /dos-hell:[cmd] |

## History
| Date | Type | Score | Verdict |
|------|------|-------|---------|
| [date] | [type] | [score] | [verdict] |

## Next Step
→ [Approved workflow step] or [Fix and re-run /dos-hell:milestone]
```

## 5. ENFORCE — Block or Proceed

- If ✅ PASSED → Report and suggest next workflow step
- If ⚠️ CONDITIONAL → Report action items, allow proceed with warning
- If ❌ BLOCKED → Report blocking issues with fix commands. DO NOT suggest proceeding.
</process>
