# Agent OS Setup — Onboarding

## First-Time Setup

When entering a new project, the agent must:

### 1. Detect Project Type
```typescript
// Automatic detection
const projectType = detectProject([
  { pattern: 'package.json', type: 'node' },
  { pattern: 'requirements.txt', type: 'python' },
  { pattern: 'Cargo.toml', type: 'rust' },
  { pattern: 'go.mod', type: 'go' },
]);
```

### 2. Load Project Context
```markdown
1. Read CLAUDE.md / CLAUDE.md / .cursorrules (project rules)
2. Read README.md (project overview)
3. Scan for: package.json, tsconfig.json, pyproject.toml, etc.
4. Identify stack: framework, ORM, language, patterns
```

### 3. Create Project Memory

Save to `.agents-os/setup/project-memory.md`:
```markdown
---
name: [project-name]
stack: [tech stack]
language: [primary language]
framework: [main framework]
database: [database if any]
testing: [test framework]
---

# Project Memory

## Stack
- Language: TypeScript
- Framework: Next.js 15
- ORM: Prisma
- ...

## Conventions
[Auto-learned from codebase]
```

### 4. Invoke Skill Detection

Based on project type, suggest relevant skills:
```typescript
const suggestedSkills = {
  node: ['feature-delivery', 'tdd-cycle', 'code-review'],
  python: ['python-development', 'django-patterns'],
  rust: ['rust-safety', 'cargo-workflows'],
};
```

## Setup Validation

After setup, validate:
- [ ] Project structure detected
- [ ] Tech stack identified
- [ ] Project memory saved
- [ ] Conventions extracted
- [ ] User preferences recorded
