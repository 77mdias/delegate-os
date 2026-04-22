---
name: feature-delivery
description: Universal feature delivery workflow adaptable to any stack
category: DEVELOPMENT
trigger: >
  /feature, new feature, add behavior, implement, create,
  significant change, behavior update, new functionality
priority: high
when_to_use: >
  When user requests new features. Workflow adapts to detected project stack.
version: 1.0.0
depends_on:
  - tdd-cycle
  - code-review
examples:
  - "add user authentication"
  - "implement payment processing"
  - "create export feature"
---

# Skill: Feature Delivery (Universal)

Adapts to any project stack: Node.js, Python, Rust, Go, etc.

## Stack Detection

```typescript
const stacks = {
  node: { test: 'jest|vitest', orm: 'prisma|sequelize', api: 'express|fastify' },
  python: { test: 'pytest', orm: 'sqlalchemy|django', api: 'fastapi|flask' },
  rust: { test: 'cargo test', orm: 'diesel|sqlx', api: 'axum|tower' },
  go: { test: 'go test', orm: 'gorm|sqlx', api: 'gin|echo' },
};
```

## Steps

1. **Confirm objective** — Business goal + acceptance criteria
2. **Detect stack** — Identify tech from project files
3. **Define contract** — Schema/API contract first
4. **Write failing test** — Test next behavior increment
5. **Implement** — Stack-appropriate implementation
6. **Refactor** — Improve without changing behavior
7. **Validate** — Run affected tests
8. **Document** — Update project docs

## Stack-Adaptive Implementation

### Node.js
```typescript
// Components: Server Actions → Services → Repositories
// Testing: Vitest/Jest with @testing-library
// Types: TypeScript with Zod schemas
```

### Python
```python
# Components: FastAPI routes → Services → Repositories
# Testing: pytest with fixtures
# Types: Pydantic models
```

### Rust
```rust
// Components: Axum handlers → Services → Repositories
// Testing: cargo test with #[test]
// Types: Structs with Diesel/SQLx
```

## Guardrails

- Do not bypass project conventions
- Do not trust unsanitized input
- Do not introduce stack coupling in domain

## Layer Assignment (Auto-Detected)

| Layer | Node | Python | Rust | Go |
|-------|------|--------|------|-----|
| Routing | server/*Actions | routes/ | handlers/ | handlers/ |
| Business | services/ | services/ | services/ | services/ |
| Data | repositories/ | repositories/ | repositories/ | repositories/ |
| Schema | schemas/ | models/ | models/ | models/ |
