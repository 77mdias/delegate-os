---
name: dos-hell:refactor
description: "HELL Refactor — GoF/GRASP smell detection and systematic pattern application"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Refactor Phase — Aplicação sistemática de Design Patterns com testes como rede de segurança.

Detect smells → Match patterns → Refactor safely → Measure improvement.
</objective>

<context>
## Smell → Pattern Map

| Smell | GoF Pattern |
|-------|-------------|
| Conditional Complexity | Strategy / State |
| Constructor Overload | Builder |
| God Class | Facade + Decomposition |
| Tight Coupling | Observer / Mediator |
| Duplicated Creation | Factory Method |
| Feature Envy | Move Method (Expert) |
| Shotgun Surgery | Decorator / Strategy |

## Safety Rules

- Refactor ONE pattern at a time
- Run ALL tests between EACH refactor
- If a test breaks → REVERT and re-evaluate
- Commit granular: `refactor(GoF): [pattern] — [module]`

## Reference
Full process: `kernel/hell/HELL-WORKFLOW-STEPS.md` → FASE 3
</context>

<process>
1. **SCAN** codebase for smells:
   - Run lint/analysis tools if available
   - Check GRASP violations:
     - Low Cohesion → class doing too much
     - High Coupling → too many cross-dependencies
     - God Class → omniscient class
     - Feature Envy → method using other class's data
   - Prioritize: Critical > Major > Minor

2. **MATCH** each smell to GoF/GRASP pattern:
   - Justify WHY this pattern (not another)
   - Document in Decision Log format

3. **REFACTOR** safely:
   - Apply ONE pattern
   - Run tests → MUST pass
   - If fail → revert
   - Commit: `refactor(GoF): [pattern] — [module]`
   - Repeat for next smell

4. **MEASURE** improvement:
   - Cyclomatic Complexity: before/after
   - Coupling (avg): before/after
   - Cohesion (avg): before/after
   - LOC: before/after

5. **GENERATE** `hell-refactor-report.md` in `changes/[proposal]/`:
   ```markdown
   ---
   HELL_Phase: Refactor
   ---
   # Refactor Report
   ## Smells Detected
   ## Patterns Applied
   ## Metrics Before/After
   ## Class Diagram (Mermaid)
   ```

6. **GATE CHECK**:
   - [ ] No critical smells remaining
   - [ ] Average coupling <5 dependencies
   - [ ] All tests pass
   - [ ] Class diagrams updated
</process>
