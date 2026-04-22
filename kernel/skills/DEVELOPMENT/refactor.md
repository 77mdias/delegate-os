---
name: refactor
description: Safe code refactoring without changing behavior
category: DEVELOPMENT
trigger: >
  /refactor, refactoring, improve code, clean up,
  restructure, technical debt
priority: medium
when_to_use: >
  When improving code without behavior change.
version: 1.0.0
depends_on:
  - tdd-cycle
  - code-review
---

# Skill: Refactor (Universal)

## Golden Rule

**Never change behavior while refactoring.**

## Patterns (Stack-Agnostic)

### Extract
```typescript
// Function
const process = (data) => data.map(x => x * 2).filter(x => x > 0);
// Becomes
const transform = (x) => x * 2;
const filter = (x) => x > 0;
const process = (data) => data.map(transform).filter(filter);
```

### Rename
```typescript
// Detect naming convention
const convention = project.conventions.naming.variables; // camelCase | PascalCase | snake_case
```

### Move
```typescript
// Move to appropriate layer
// UI → Business Logic → Data Access
```

## Steps

1. Ensure tests pass before
2. Make ONE small change
3. Verify tests still pass
4. Commit
5. Repeat

## Guardrails

- Run tests before AND after each step
- Never skip tests
- Commit after each safe transformation
