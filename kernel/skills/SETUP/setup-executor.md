---
name: setup-executor
description: Project setup and learning system
category: SETUP
trigger: >
  /setup, new project, initialize, onboarding,
  learn project, detect project
priority: critical
when_to_use: >
  When entering a new project or when /setup is invoked.
  This skill runs the onboarding and learning pipeline.
version: 1.0.0
depends_on: []
---

# Skill: Setup Executor

Run this on first project contact or when `/setup` is invoked.

## Pipeline

```
┌─────────────────────────────────────────────────────────┐
│  1. Project Detection                                   │
│     - Scan for project files                           │
│     - Identify language/framework                       │
│     - Create project memory                            │
└───────────────────────────┬─────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│  2. Convention Extraction                              │
│     - Naming patterns                                  │
│     - Import conventions                               │
│     - Code patterns                                    │
│     - Project-specific rules                           │
└───────────────────────────┬─────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│  3. User Preference Learning                           │
│     - Ask clarifying questions                          │
│     - Learn from feedback                              │
│     - Record preferences                               │
└───────────────────────────┬─────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│  4. Skill Selection                                    │
│     - Enable relevant skills                           │
│     - Disable irrelevant skills                         │
│     - Configure skill parameters                        │
└───────────────────────────┬─────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│  5. Validation                                         │
│     - Confirm understanding                             │
│     - User approval                                    │
└─────────────────────────────────────────────────────────┘
```

## Project Detection

### Files to Scan

```typescript
const projectIndicators = {
  // Languages
  node: ['package.json', 'package-lock.json'],
  python: ['requirements.txt', 'pyproject.toml', 'setup.py'],
  rust: ['Cargo.toml', 'Cargo.lock'],
  go: ['go.mod', 'go.sum'],
  java: ['pom.xml', 'build.gradle'],
  dotnet: ['*.csproj', '*.sln'],

  // Frameworks
  nextjs: ['next.config.*', 'app/'],
  react: ['vite.config.*', 'webpack.config.*'],
  vue: ['vite.config.*', 'nuxt.config.*'],
  django: ['manage.py', 'settings.py'],
  fastapi: ['main.py'],
  rails: ['config/routes.rb', 'Gemfile'],
  spring: ['pom.xml', 'application.properties'],

  // ORMs
  prisma: ['prisma/schema.prisma'],
  sqlalchemy: ['models.py', 'alembic/'],
  diesel: ['src/schema.rs'],
  gorm: ['models.go'],

  // Testing
  jest: ['jest.config.*'],
  vitest: ['vitest.config.*'],
  pytest: ['pytest.ini', 'conftest.py'],
  rspec: ['spec/', 'rspec.*'],
};
```

## Convention Extraction

### Extract and Record

1. **Naming Conventions**
   - Files: PascalCase vs kebab-case vs snake_case
   - Variables: camelCase vs snake_case
   - Constants: UPPER_SNAKE vs camelCase

2. **Import Patterns**
   - Aliases: `@/` → `./src/`
   - Relative: `../` vs `./`
   - Style: named vs default imports

3. **Code Patterns**
   - Error handling: try-catch vs result types
   - Async: async/await vs callbacks vs promises
   - Typing: explicit vs inferred

4. **Testing Patterns**
   - Location: alongside vs separate
   - Naming: `*.test.ts` vs `*_test.go`
   - Style: describe-it vs test-function

## User Questions

If conventions unclear, ask:

```markdown
## Clarifying Questions

1. **Naming**: Do you prefer PascalCase or camelCase for components?
   - PascalCase (React convention)
   - camelCase (default)

2. **Testing**: Where should tests be located?
   - Alongside source files
   - In separate `tests/` folder

3. **Quality**: What are your quality gates?
   - Minimum coverage %
   - Required checks (lint, type-check)
```

## Output

Create `.agents-os/setup/project-memory.md`:
```markdown
---
name: [project-name]
stack: [detected tech]
language: [primary language]
framework: [main framework]
database: [database if any]
testing: [test framework]
conventions: [extracted conventions]
---

# Project Memory

[Auto-generated project understanding]
```

## Validation

After setup, confirm with user:
```markdown
## Setup Complete

I've detected and learned:

- **Stack**: Next.js 15 + TypeScript + Prisma + PostgreSQL
- **Naming**: PascalCase (components), camelCase (utils)
- **Tests**: Vitest, co-located with source
- **Quality**: 80% coverage, lint + type-check required

**Skills enabled**: feature-delivery, tdd-cycle, code-review, etc.

Does this look correct? Any adjustments?
```
