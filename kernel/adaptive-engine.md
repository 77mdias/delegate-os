# Adaptive Learning Engine

System that adjusts agent behavior based on project and user feedback.

## Learning Loop

```
User Feedback → Analyzer → Adapter → Updated Behavior
     ↑                              ↓
     └──────── Validation ←─────────┘
```

## Feedback Types

### 1. Correction Feedback
```typescript
// User corrects agent behavior
interface Correction {
  type: 'correction';
  context: string;        // What agent did
  correction: string;    // What user wanted
  reason?: string;       // Why user corrected
}
```

### 2. Approval Feedback
```typescript
// User approves agent behavior
interface Approval {
  type: 'approval';
  context: string;        // What agent did
  implicit: boolean;      // True if no explicit approval needed
  approvalLevel: 'full' | 'partial';
}
```

### 3. Pattern Feedback
```typescript
// User demonstrates preferred pattern
interface Pattern {
  type: 'pattern';
  example: string;        // Code example user provided
  context: string;        // When to use
  reason?: string;        // Why this pattern
}
```

## Adaptation Rules

### Rule Generation
```typescript
// From corrections, generate rules
corrections = [
  { context: 'naming', correction: 'PascalCase for components' },
  { context: 'naming', correction: 'camelCase for hooks' },
];

// Generate rule
rules.push({
  condition: 'file.type === "component"',
  pattern: 'PascalCase',
  source: 'user-correction',
  confidence: 0.9,
});
```

### Rule Storage
Save to `.agents-os/setup/learned-rules.md`:
```markdown
# Learned Rules

## Naming Conventions
| Pattern | Rule | Source | Confidence |
|---------|------|--------|------------|
| *.tsx | PascalCase | user-correction | 90% |
| *.test.ts | camelCase | project-convention | 100% |

## Workflow Preferences
| Pattern | Rule | Source | Confidence |
|---------|------|--------|------------|
| commit-msg | conventional-commits | project | 100% |
```

## Confidence Scoring

```typescript
interface RuleConfidence {
  baseScore: number;      // 0.0 - 1.0
  sources: number;       // How many sources agree
  recentUse: boolean;    // Used successfully recently
  userConfirmed: boolean; // User explicitly confirmed
}

// Calculate confidence
confidence = baseScore * (1 + sources * 0.1) * (recentUse ? 1.2 : 1.0);
```

## Validation

Before applying learned rule:
1. Check confidence threshold (>= 0.7)
2. Verify pattern matches current context
3. Apply with warning if confidence < 0.9
4. Track rule usage for future confidence adjustment

## Memory Sync

Learned rules sync to:
- `.agents-os/setup/learned-rules.md` (persistent)
- Session memory (current context)
- Project memory (project-specific rules)
