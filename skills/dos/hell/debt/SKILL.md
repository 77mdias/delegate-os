---
name: dos-hell:debt
description: "HELL Debt — Tech debt backlog management and prioritization"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Debt — Gerenciamento do backlog de dívida técnica.

Categoriza, prioriza e rastreia dívida técnica com severidade e sprint targets.
</objective>

<context>
## Severity Levels

| Level | Color | Impact | Examples |
|-------|-------|--------|----------|
| CRITICAL | 🔴 | Security, data loss | Hardcoded secrets, SQL injection |
| MAJOR | 🟡 | Performance, maintainability | Missing indexes, god classes |
| MINOR | 🟢 | Code quality | Naming issues, missing comments |
| TRIVIAL | ⚪ | Cosmetic | Formatting, unused imports |

## Storage
Persistent: `memory/hell-tech-debt.md`
Per-proposal: `changes/[proposal]/hell-debt.md`
</context>

<process>
1. **LOAD** existing debt from `memory/hell-tech-debt.md`
2. **SCAN** for new debt items (if no argument) or **ADD** specific item
3. **CATEGORIZE** each item: severity + effort + impact
4. **PRIORITIZE**: Security > Performance > Maintainability > Style
5. **UPDATE** `memory/hell-tech-debt.md`:
   ```markdown
   # HELL Tech Debt Backlog
   ## Summary
   - Total: [N] items
   - 🔴 Critical: [N] | 🟡 Major: [N] | 🟢 Minor: [N] | ⚪ Trivial: [N]
   - Debt Score: [weighted sum]
   - Trend: [↑ increasing | → stable | ↓ decreasing]
   
   ## Backlog
   | ID | Severity | Description | Location | Effort | Sprint |
   ```
6. **REPORT** current debt status and trends
</process>
