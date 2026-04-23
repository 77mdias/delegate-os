---
name: dos-hell:evolve
description: "HELL Evolution — CI/CD pipeline, tech debt tracking, documentation sync"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Evolution Phase — Automação completa e rastreamento de dívida técnica.

Pipeline verde. Debt catalogada. Docs sincronizados.
</objective>

<context>
## Evolution Checklist

```
PIPELINE ──► DEBT TRACKING ──► MONITORING ──► DOC SYNC
```

## Reference
Full process: `kernel/hell/HELL-WORKFLOW-STEPS.md` → FASE 4
</context>

<process>
1. **AUDIT CI/CD PIPELINE**:
   - Check: lint → format → test → build → deploy
   - Identify missing stages
   - Suggest pipeline improvements
   - Verify quality gates (coverage thresholds, complexity limits)

2. **TRACK TECH DEBT**:
   - Categorize: 🔴 CRITICAL | 🟡 MAJOR | 🟢 MINOR | ⚪ TRIVIAL
   - Log in `memory/hell-tech-debt.md`
   - Prioritize: Security > Performance > Maintainability > Style
   - Assign sprint targets

3. **SYNC DOCUMENTATION**:
   - README updated?
   - API docs current?
   - CHANGELOG updated?
   - Architecture decisions recorded?

4. **GENERATE** `hell-evolution-status.md`:
   ```markdown
   ---
   HELL_Phase: Evolution
   ---
   # Evolution Status
   ## Pipeline Status
   ## Tech Debt Backlog
   ## Documentation Status
   ```

5. **GATE CHECK**:
   - [ ] CI pipeline exists and is green
   - [ ] Zero critical vulnerabilities
   - [ ] Tech debt cataloged and prioritized
   - [ ] Documentation 100% synced
</process>
