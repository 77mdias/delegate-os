---
name: tdd-cycle
description: Test-driven development cycle with stack detection
category: DEVELOPMENT
trigger: >
  /tdd, test-driven, red-green-refactor, test first,
  red green refactor, write tests first
priority: high
when_to_use: >
  When user wants TDD approach or for any behavior change.
  Automatically detects test framework.
version: 1.0.0
depends_on: []
examples:
  - "use tdd for this feature"
  - "write tests first"
  - "red green refactor"
---

# Skill: TDD Cycle (Universal)

Auto-detects test framework: Jest, Vitest, pytest, cargo test, go test

## Framework Detection

```typescript
const frameworks = {
  jest: { config: 'jest.config.*', pattern: 'describe|it|expect' },
  vitest: { config: 'vitest.config.*', pattern: 'describe|it|expect' },
  pytest: { config: 'pytest.ini|conftest.py', pattern: 'def test_' },
  'cargo test': { config: 'Cargo.toml', pattern: '#[test]|#[cfg(test)]' },
  'go test': { config: '*_test.go', pattern: 'func Test' },
};
```

## Red-Green-Refactor

### Red Phase
1. Write ONE failing test
2. Name test clearly: `it('should X when Y')`
3. Run test — verify failure

### Green Phase
1. Implement MINIMUM change
2. All tests must pass
3. No shortcuts

### Refactor Phase
1. Improve code structure
2. Preserve behavior
3. Tests still passing

## Test Selection (Auto-Detected)

| Framework | Unit | Integration | E2E |
|-----------|------|-------------|-----|
| Jest/Vitest | `*.test.ts` | `*.integration.test.ts` | `tests/e2e/*` |
| pytest | `test_*.py` | `test_*_integration.py` | `tests/e2e/*` |
| cargo test | `#[test]` | `#[integration_test]` | `tests/e2e/*` |
| go test | `*_test.go` | `*_integration_test.go` | `tests/e2e/*` |

## Naming Conventions (Auto-Detected)

| Stack | Test Location | Naming |
|-------|---------------|--------|
| Node | alongside source | `User.test.ts` |
| Python | `tests/` folder | `test_user.py` |
| Rust | `tests/` or `src/` | `#[test]` |
| Go | same package | `*_test.go` |

## Guardrails

- Never skip from Red to Green
- One assertion concept per test
- Refactor only when tests pass
- Run full suite before commit

## Stack-Specific Examples

### TypeScript/Jest
```typescript
describe('UserService', () => {
  it('should create user with hashed password', async () => {
    const user = await createUser({ email, password: 'plain' });
    expect(user.password).not.toBe('plain');
    expect(await bcrypt.compare('plain', user.password)).toBe(true);
  });
});
```

### Python/pytest
```python
def test_user_creation():
    user = create_user(email="test@example.com", password="plain")
    assert user.password != "plain"
    assert bcrypt.checkpw("plain", user.password)
```

### Rust
```rust
#[test]
fn user_password_is_hashed() {
    let user = create_user("test@example.com", "plain");
    assert_ne!(user.password, "plain");
    assert!(verify_password("plain", &user.password));
}
```
