---
name: project-detector
description: Auto-detect project type and tech stack
category: SETUP
trigger: >
  /detect, detect project, what project, project type,
  scan project, identify stack
priority: critical
when_to_use: >
  When project memory doesn't exist or when explicitly requested.
  This is the first skill to run in a new project.
version: 1.0.0
depends_on: []
---

# Skill: Project Detector

## Detection Strategy

### 1. Language Detection

```typescript
const languages = {
  typescript: ['tsconfig.json', 'package.json'],
  javascript: ['package.json'],
  python: ['requirements.txt', 'pyproject.toml'],
  rust: ['Cargo.toml'],
  go: ['go.mod'],
  java: ['pom.xml', 'build.gradle'],
  csharp: ['*.csproj'],
};
```

### 2. Framework Detection

```typescript
const frameworks = {
  // JavaScript/TypeScript
  nextjs: ['next.config.*', 'app/'],
  nuxt: ['nuxt.config.*'],
  vite: ['vite.config.*'],
  webpack: ['webpack.config.*'],

  // Python
  django: ['manage.py', 'settings.py'],
  fastapi: ['main.py', 'app.py'],
  flask: ['app.py', 'run.py'],

  // Rust
  axum: ['Cargo.toml'],
  actix: ['Cargo.toml'],
  rocket: ['Cargo.toml'],

  // Go
  gin: ['go.mod'],
  echo: ['go.mod'],
};
```

### 3. ORM Detection

```typescript
const orms = {
  prisma: ['prisma/schema.prisma'],
  sqlalchemy: ['models.py', 'alembic/'],
  diesel: ['src/schema.rs'],
  gorm: ['models.go'],
  typeorm: ['entity/*.ts'],
};
```

### 4. Testing Framework Detection

```typescript
const testing = {
  jest: ['jest.config.*'],
  vitest: ['vitest.config.*'],
  pytest: ['pytest.ini', 'conftest.py'],
  'cargo test': ['Cargo.toml'],
  'go test': ['*_test.go'],
  rspec: ['spec/', 'rspec.*'],
};
```

## Output Format

```typescript
interface ProjectInfo {
  language: 'typescript' | 'javascript' | 'python' | 'rust' | 'go' | 'java' | 'csharp';
  framework: string | null;
  orm: string | null;
  testing: string[];
  projectType: 'web' | 'api' | 'cli' | 'library' | 'mobile' | 'embedded';
  structure: {
    sourceDir: string;
    testDir: string;
    docsDir: string;
  };
  packageManager: 'npm' | 'yarn' | 'pnpm' | 'pip' | 'cargo' | 'go' | 'maven';
  conventions: {
    naming: NamingConvention;
    imports: ImportStyle;
    testing: TestLocation;
  };
}
```

## Usage

```markdown
# Project Detection Result

## Stack
- **Language**: TypeScript
- **Framework**: Next.js 15 (App Router)
- **ORM**: Prisma
- **Testing**: Vitest

## Structure
- Source: `src/`
- Tests: `*.test.ts` (co-located)
- Docs: `docs/`

## Conventions (Detected)
- Components: PascalCase
- Utils: camelCase
- Imports: named preferred

Ready to create project memory?
```
