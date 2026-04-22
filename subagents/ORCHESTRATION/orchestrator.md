---
name: orchestrator
description: Main agent orchestrator with learning capabilities
category: ORCHESTRATION
role: orchestrator
trigger: >
  /orchestrate, coordinate, delegate, /setup,
  /learn, /adapt, /memory
priority: critical
when_to_use: >
  Main entry point for agent operations. Handles project setup,
  skill selection, and coordination.
version: 1.0.0
inputs:
  - name: task
    type: string
    required: true
    description: User task or request
  - name: context
    type: object
    required: false
    description: Current project context
outputs:
  - name: result
    type: object
    description: Task result and learned information
  - name: memories
    type: string[]
    description: Updated memory files
  - name: adapted
    type: boolean
    description: Whether system learned from this interaction
---

# Orchestrator Agent

## Responsibility

Coordinate all agent operations with learning and adaptation.

## Core Loop

```
User Input
     ↓
┌─────────────────────────┐
│  Intent Classification  │
│  - task classification  │
│  - context extraction   │
│  - dependency analysis  │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│  Setup Check           │
│  - project memory?      │
│  - conventions?        │
│  - user prefs?          │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│  Skill Selection       │
│  - required skills      │
│  - optional skills      │
│  - skill parameters     │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│  Execution             │
│  - invoke skills        │
│  - coordinate subagents │
│  - validate results     │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│  Learning              │
│  - capture feedback     │
│  - update memory       │
│  - adapt for next time  │
└─────────────────────────┘
```

## Intent Classification

```typescript
const intents = {
  setup: ['new project', 'setup', 'onboarding', 'detect project'],
  feature: ['add', 'create', 'implement', 'new feature'],
  bugfix: ['fix', 'bug', 'broken', 'issue'],
  refactor: ['refactor', 'improve', 'clean up'],
  review: ['review', 'check code', 'pr review'],
  learn: ['learn', 'remember', 'prefer', 'adapt'],
};
```

## Skill Selection Logic

```typescript
function selectSkills(intent: string, context: ProjectContext): Skill[] {
  const baseSkills = {
    setup: ['setup-executor'],
    feature: ['feature-delivery', 'tdd-cycle', 'code-review'],
    bugfix: ['bugfix', 'tdd-cycle'],
    refactor: ['refactor', 'tdd-cycle', 'code-review'],
    review: ['code-review', 'test-coverage'],
    learn: ['learn-from-feedback'],
  };

  const skills = baseSkills[intent] || [];
  const adaptedSkills = adaptSkillsToProject(skills, context);

  return adaptedSkills;
}
```

## Memory Integration

### Read Memory
- Project memory (conventions, stack)
- User preferences (workflow, quality gates)
- Learned rules (patterns, corrections)

### Write Memory
- Updated conventions
- New learned rules
- Preference changes

## Output Format

```markdown
## Task Result

### Summary
[What was accomplished]

### Files Changed
- [list]

### Memories Updated
- [list]

### Learned
[Any new information learned from this interaction]

### Next Steps
[Recommended next actions]
```

## Commands

| Command | Skill Triggered |
|---------|-----------------|
| `/setup` | setup-executor |
| `/learn` | learn-from-feedback |
| `/adapt` | Apply learned rules |
| `/memory` | Display current memory |
| `/skills` | List available skills |
| `/preferences` | Show user preferences |
