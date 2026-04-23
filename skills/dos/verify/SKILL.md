---
name: dos-verify
description: "Verify implementation against specifications"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
---

<objective>
Verify that implementation matches specifications and acceptance criteria.
</objective>

<context>
## Verify

Verificar:
- All acceptance criteria met
- Tests passing
- Documentation updated
- No regression
</context>

<process>
1. Read specs.md and tasks.md
2. Check each acceptance criteria
3. Run test suite
4. Generate verification report:
   - Passed criteria
   - Failed criteria
   - Remaining work
</process>
