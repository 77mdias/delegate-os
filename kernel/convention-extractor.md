# Convention Extractor

Automatically extract project conventions from codebase.

## Extraction Strategy

### 1. File Patterns
```typescript
// Detect naming conventions
const patterns = {
  files: {
    PascalCase: ['*.tsx', '*.test.ts'],
    kebab_case: ['*.scss', '*.module.css'],
    camelCase: ['*.ts', '*.js'],
  },
  dirs: {
    kebab_case: ['src/components', 'src/lib'],
  },
};
```

### 2. Import Patterns
```typescript
// Detect import conventions
const imports = {
  aliases: ['@/', '@/'],
  relative: ['../', './'],
  packages: ['@scope/package'],
};
```

### 3. Code Patterns
```typescript
// Detect patterns in use
const codePatterns = {
  errorHandling: 'try-catch' | 'result-type' | 'throw',
  asyncPattern: 'async-await' | 'callbacks' | 'promises',
  typing: 'explicit' | 'inferred' | 'partial',
  testing: 'describe-it' | 'test-function' | 'scenario',
};
```

### 4. Documentation Patterns
```typescript
// Detect doc conventions
const docPatterns = {
  comments: 'jsdoc' | 'tsdoc' | '#' | '//',
  docsFolder: 'docs/' | 'documentation/' | 'wiki/',
  changelog: 'CHANGELOG.md' | 'HISTORY.md' | 'news/',
};
```

## Output Format

Save to `.agents-os/setup/conventions.md`:
```markdown
# Project Conventions

## Naming
| Type | Pattern | Example |
|------|---------|---------|
| Components | PascalCase | UserProfile.tsx |
| Utils | camelCase | formatDate.ts |

## Imports
- Alias: `@/` → `./src/`
- Packages: Named imports preferred

## Code Style
- Error handling: Result types
- Async: async/await only
- Types: Explicit with interfaces

## Testing
- Framework: Jest
- Pattern: describe-it
- Location: __tests__/ alongside source
```

## Learning Triggers

Extract conventions when:
1. First project setup
2. User corrects a pattern ("use PascalCase for components")
3. New file types detected
4. Convention file updated
