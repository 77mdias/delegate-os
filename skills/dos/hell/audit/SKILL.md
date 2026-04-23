---
name: dos-hell:audit
description: "HELL Audit — GRASP/GoF compliance audit with violation report"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Audit — Auditoria focada em compliance GRASP/GoF.

Diferente do Review (análise ampla), o Audit é cirúrgico: 
verifica CADA classe contra os padrões e reporta violações.
</objective>

<context>
## GRASP Checklist (per class)

- [ ] **Information Expert** — Class operates on its OWN data?
- [ ] **Creator** — Class creates entities it contains/uses closely?
- [ ] **Controller** — No business logic in presentation layer?
- [ ] **Low Coupling** — ≤3 dependencies from same level?
- [ ] **High Cohesion** — ≤200 LOC OR justified decomposition?
- [ ] **Polymorphism** — No switch/if chains on same type (>3 branches)?
- [ ] **Pure Fabrication** — Technical concerns in separate classes?
- [ ] **Indirection** — Mediators where components might change?
- [ ] **Protected Variations** — Interfaces for unstable points?

## SOLID Checklist (per class)

- [ ] **SRP** — One reason to change?
- [ ] **OCP** — Open for extension, closed for modification?
- [ ] **LSP** — Subtypes substitute supertypes?
- [ ] **ISP** — No forced dependency on unused methods?
- [ ] **DIP** — Depends on abstractions, not concretes?
</context>

<process>
1. **SCAN** all classes/modules in `lib/` or `src/`
2. **FOR EACH** class:
   - Run GRASP checklist (9 items)
   - Run SOLID checklist (5 items)
   - Score: passed/total (e.g., 11/14)
   - Flag violations as: 🔴 CRITICAL | 🟡 WARNING | 🟢 OK
3. **GENERATE** `hell-audit-report.md`:
   ```markdown
   # HELL Audit Report
   ## Summary: [passed]/[total] checks passed
   ## By Class
   | Class | GRASP Score | SOLID Score | Violations | Severity |
   ## Critical Violations (Action Required)
   ## Warnings
   ## Recommendations
   ```
4. **LINK** violations to fix commands:
   - Pattern violation → `/dos-hell:refactor`
   - Missing tests → `/dos-hell:tdd`
   - Architecture violation → `/dos-hell:spec` (re-spec the module)
</process>
