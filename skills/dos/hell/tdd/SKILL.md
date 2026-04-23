---
name: dos-hell:tdd
description: "HELL TDD Cycle — Red/Green/Refactor with mandatory pattern justification"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL TDD Cycle — Implementação dirigida por testes.

Sem teste = Sem código. Cada ciclo RED/GREEN/REFACTOR é atômico e documentado.
</objective>

<context>
## TDD Cycle

```
┌───────┐
│  RED  │ → Escreva teste que FALHA
└───┬───┘
    ↓
┌───────┐
│ GREEN │ → Código MÍNIMO que passa
└───┬───┘
    ↓
┌──────────┐
│ REFACTOR │ → Limpe + aplique GRASP/GoF
└──────────┘
```

## Rules

- **RED:** Teste DEVE compilar e FALHAR
- **GREEN:** Código MÍNIMO. PROIBIDO otimizar. PROIBIDO mudar teste.
- **REFACTOR:** Testes DEVEM continuar verdes. Padrão DEVE ser documentado.

## Commit Convention

- `test: RED — [test_name]`
- `feat: GREEN — [feature]`
- `refactor: [pattern] — [justification]`

## Reference
Full process: `kernel/hell/HELL-WORKFLOW-STEPS.md` → FASE 2
</context>

<process>
1. **LOCATE** `hell-spec.md` or `specs.md` in current proposal
   - If no spec exists, warn: "Execute /dos-hell:spec primeiro."

2. **FOR EACH** functional requirement:
   a. **RED** — Define smallest testable unit:
      - Write test with Given/When/Then (Arrange/Act/Assert)
      - Verify test COMPILES but FAILS
      - Log: `C[n] | RED | test_name | ✅ FAIL`
   
   b. **GREEN** — Implement minimum passing code:
      - ONLY code needed to pass the test
      - NO optimization, NO extras
      - Verify test PASSES
      - Log: `C[n] | GREEN | test_name | ✅ PASS`
   
   c. **REFACTOR** — Clean + apply pattern:
      - Detect code smells (duplication, long method, feature envy)
      - Apply GRASP/GoF pattern
      - Verify ALL tests still PASS
      - Document: which pattern, WHY
      - Log: `C[n] | REFACTOR | test_name | ✅ PASS | [Pattern]`

3. **GENERATE/UPDATE** `hell-tdd-log.md` in `changes/[proposal]/`:
   ```markdown
   ---
   HELL_Phase: TDD
   Status: 🔥 ACTIVE
   ---
   # TDD Log: [Feature]
   | Ciclo | Teste | RED | GREEN | REFACTOR | Padrão |
   ```

4. **GATE CHECK**:
   - [ ] Coverage ≥80% (lines AND branches)
   - [ ] Zero skipped tests
   - [ ] Each class has GRASP justification
   - [ ] Commits follow convention
   - Report gate status
</process>
