# ADR-001: Use TypeScript

**Status**: Accepted

**Date**: 2024-01-15

**Authors**: Delegado OS Team

**Deciders**: Delegado OS Team, Project Maintainers

---

## Context

Delegado OS is a multi-agent orchestration system that needs to support multiple programming languages and runtime environments. The core system is built on JavaScript/Node.js, but we need to decide on a primary language for:

- Core plugins and extensions
- Agent implementations
- Tool integrations
- Internal libraries

We evaluated JavaScript (ES2024+), TypeScript, Python, and Go based on:

- Team expertise and learning curve
- Ecosystem and library availability
- Performance requirements
- Type safety and maintainability
- Tooling quality

---

## Decision

We will use **TypeScript** as the primary language for all new plugin development and core system components.

JavaScript (ES2024+) remains supported for:
- Simple scripts and automation hooks
- Legacy plugins awaiting migration
- User-provided scripts in workflows

### TypeScript Configuration

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

---

## Consequences

### Positive

- **Type Safety**: Catch errors at compile time, reduce runtime type errors by ~40%
- **Better IDE Support**: Improved autocomplete, refactoring, and navigation
- **Documentation**: Types serve as living documentation
- **Refactoring Confidence**: Safer large-scale changes
- **Cross-team Collaboration**: Clear contracts between plugins

### Negative

- **Build Step Required**: Compilation adds ~5-10 seconds to development cycle
- **Learning Curve**: Team members unfamiliar with TypeScript need ramp-up time
- **Complexity**: Some patterns more verbose than equivalent JavaScript
- **Migration Effort**: ~20 existing JavaScript modules need migration

### Neutral

- **Runtime Behavior**: TypeScript compiles to JavaScript, same runtime performance
- **Bundle Size**: Slight increase from type definitions (negligible with tree-shaking)

---

## Alternatives Considered

### Option 1: JavaScript Only

**Pros**:
- No build step, faster development
- Lower learning curve
- More flexibility with dynamic patterns

**Cons**:
- No compile-time type checking
- Higher error rates in production
- Poor scalability for large codebase

**Decision**: Rejected due to maintainability concerns at scale.

### Option 2: Python

**Pros**:
- Strong ML/AI ecosystem
- Fast prototyping
- Large talent pool

**Cons**:
- Type hints are optional, not enforced
- Slower runtime performance
- Less ideal for concurrent/parallel workloads
- JavaScript ecosystem integration would require IPC

**Decision**: Rejected - better suited for ML components, not core orchestration.

### Option 3: Go

**Pros**:
- Excellent performance
- Strong concurrency model
- Single binary deployment

**Cons**:
- Learning curve for team
- Verbose error handling
- Less flexible for scripting/automation
- Slower iteration for prototyping

**Decision**: Rejected - better for high-performance services, not agent orchestration.

---

## Implementation Plan

### Phase 1: Core Migration (Weeks 1-2)
- Migrate kernel/ to TypeScript
- Set up CI/CD for TypeScript builds
- Write type definitions for plugin API

### Phase 2: Plugin Migration (Weeks 3-4)
- Migrate priority plugins to TypeScript
- Create TypeScript starter template
- Update documentation

### Phase 3: Full Migration (Weeks 5-6)
- Migrate remaining plugins
- Deprecate JavaScript-only patterns
- Finalize type definitions

---

## References

- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [TypeScript Configuration Reference](https://www.typescriptlang.org/tsconfig)
- Related ADR: [ADR-003: Build Tool Choice](./adr-003-build-tools.md)
