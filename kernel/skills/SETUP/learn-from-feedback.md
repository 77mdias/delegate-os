---
name: learn-from-feedback
description: Continuous learning from user feedback
category: SETUP
trigger: >
  /learn, learn from feedback, adapt, adjust,
  remember this, learn preference
priority: critical
when_to_use: >
  When user provides feedback, corrections, or preferences.
  This skill updates memory and adapts behavior.
version: 1.0.0
depends_on: []
---

# Skill: Learn from Feedback

Process user feedback and update system.

## Feedback Types

### 1. Correction
User corrects agent:
```
"Not that way, I prefer X instead"
```

### 2. Approval
User approves agent:
```
"Exactly, that's perfect"
```

### 3. Preference
User states preference:
```
"I always prefer small PRs"
```

### 4. Pattern
User demonstrates pattern:
```
"Use this pattern instead..."
```

## Processing Pipeline

```
User Feedback
     ↓
┌─────────────────────────┐
│  1. Categorize          │
│     - correction        │
│     - approval          │
│     - preference        │
│     - pattern           │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│  2. Extract             │
│     - what changed       │
│     - context            │
│     - reason             │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│  3. Update Memory       │
│     - learned rules      │
│     - preferences        │
│     - project memory     │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│  4. Adapt               │
│     - apply immediately   │
│     - update skills       │
│     - confirm change      │
└─────────────────────────┘
```

## Memory Update

### Learned Rules
Update `.agents-os/setup/learned-rules.md`:
```markdown
## Rule: [Pattern Name]
- Context: [When to apply]
- Previous: [Old behavior]
- New: [New behavior]
- Source: user-correction
- Confidence: 85%
- Updated: 2024-01-15
```

### User Preferences
Update `.agents-os/setup/user-preferences.md`:
```markdown
## [Category]
- [Preference]: [Value]
- Learned from: [Source]
- Confidence: [X]%
```

## Confirmation

After learning, confirm:
```markdown
## Learned

**Updated**: PR size preference
- **From**: Medium (<500 lines)
- **To**: Small (<300 lines)
- **Confidence**: 90%

I'll apply this to future PRs. Should I update existing project rules?
```

## Auto-Trigger

This skill triggers automatically when:
- User says "remember", "learn", "prefer", "I always"
- User corrects agent behavior
- User approves unusual choice
- `/learn` command invoked
