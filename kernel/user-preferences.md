# User Preferences Learner

Learn and remember user preferences across sessions.

## Preference Categories

### 1. Communication
```typescript
interface CommunicationPrefs {
  language: 'en' | 'pt' | 'es';
  formality: 'formal' | 'informal';
  verbosity: 'brief' | 'detailed';
  summaries: boolean;
  codeExplanations: 'minimal' | 'detailed';
}
```

### 2. Workflow
```typescript
interface WorkflowPrefs {
  tdd: boolean;           // Test-driven development
  commitStyle: 'frequent' | 'bundled';
  prSize: 'small' | 'medium' | 'large';
  reviewStyle: 'strict' | 'lenient';
}
```

### 3. Technical
```typescript
interface TechnicalPrefs {
  frameworks: string[];
  architectures: string[];
  testing: string[];
  documentation: 'minimal' | 'comprehensive';
}
```

### 4. Quality Gates
```typescript
interface QualityGates {
  coverage: number;        // Minimum coverage %
  lint: boolean;
  typeCheck: boolean;
  securityScan: boolean;
}
```

## Learning Mechanism

### Explicit Learning
User explicitly states preference:
```
"Use small PRs, max 200 lines"
"Always run tests before commit"
```

### Implicit Learning
Agent observes patterns:
```
// User consistently requests X after Y
// User approves/rejects certain patterns
```

## Storage

Save to `.agents-os/setup/user-preferences.md`:
```markdown
---
updated: 2024-01-15
learned: 12 preferences
---

# User Preferences

## Communication
- Language: Portuguese (learned from user messages)
- Verbosity: Brief (learned from "/clear" commands)
- Summaries: Concise (default)

## Workflow
- PR Size: Small (<300 lines)
- TDD: Preferred for new features
- Commit: Frequently (every logical unit)

## Technical
- Stack: [learned from project scan]
- Patterns: [learned from codebase]

## Quality
- Coverage: 80% minimum
- Lint: Required
- Type Check: Required
```

## Update Triggers

- User corrects agent ("I prefer X, not Y")
- User approves agent choice (positive signal)
- User rejects agent choice (negative signal)
- Project changes
- Explicit `/preferences` command
