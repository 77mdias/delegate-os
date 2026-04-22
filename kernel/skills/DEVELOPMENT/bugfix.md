---
name: bugfix
description: Bug identification and fixing workflow
category: DEVELOPMENT
trigger: >
  /bugfix, fix bug, bug, broken, fix this, issue
priority: high
when_to_use: >
  When user reports a bug or unexpected behavior.
version: 1.0.0
depends_on:
  - tdd-cycle
---

# Skill: Bugfix Workflow (Universal)

## Steps

1. **Reproduce** — Create minimal failing test
2. **Isolate** — Find root cause boundary
3. **Fix** — Smallest possible change
4. **Verify** — Ensure test passes + no regressions
5. **Document** — Record bug + fix

## Auto-Detection

```typescript
const bugIndicators = [
  'broken',
  'bug',
  'fix this',
  'does not work',
  'error',
  'fails',
  'wrong behavior',
];

const testPattern = {
  jest: '*.test.ts',
  pytest: 'test_*.py',
  rust: '#[test]',
  go: '*_test.go',
};
```

## Guardrails

- Reproduce before fixing
- Add regression test
- Do not refactor unrelated code
- Do not add features in bugfix scope

## Output

- Root cause analysis
- Files changed
- Regression test added
