# HELL Framework Integration

## Overview

The HELL (Hyper-Extreme Learning Loop) framework is the core orchestration system of Delegado OS. This document explains how agent modes integrate with HELL phases.

## HELL Phases

```
┌─────────────────────────────────────────────────────────────┐
│                        HELL FRAMEWORK                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│   ┌───────┐    ┌───────┐    ┌───────┐    ┌───────┐       │
│   │   H   │───▶│   E   │───▶│   L   │───▶│   L   │       │
│   │ Hook  │    │ Educate│   │ Link  │    │ Loop  │       │
│   └───────┘    └───────┘    └───────┘    └───────┘       │
│      │                                          │          │
│      │         ┌───────────────────────┐       │          │
│      └────────▶│    OBSIDIAN BRAIN      │◀──────┘          │
│                └───────────────────────┘                  │
│                                                              │
└─────────────────────────────────────────────────────────────┘

H = Hook (Trigger, Context Setup)
E = Educate (Learn, Research, Analyze)
L = Link (Connect, Relate, Synthesize)
L = Loop (Iterate, Verify, Complete)
```

## Phase-to-Mode Mapping

### Phase H: Hook
| Sub-phase | Agent Mode | Responsibility |
|-----------|-----------|----------------|
| Trigger Detection | ORCHESTRATION | Detect user intent and context |
| Context Gathering | RESEARCHER | Gather relevant background |
| Mode Selection | ORCHESTRATION | Choose appropriate mode(s) |
| Pre-hooks | Mode-specific | Initialize mode environment |

### Phase E: Educate
| Sub-phase | Agent Mode | Responsibility |
|-----------|-----------|----------------|
| Information Gathering | RESEARCHER | Find and analyze sources |
| Concept Teaching | PROFESSOR | Explain and demonstrate |
| Pattern Analysis | ARCHITECT | Analyze design patterns |
| Security Education | GUARDIAN | Security awareness |

### Phase L: Link
| Sub-phase | Agent Mode | Responsibility |
|-----------|-----------|----------------|
| Connection Making | ORCHESTRATION | Relate concepts across modes |
| Knowledge Graph | RESEARCHER | Build knowledge relationships |
| Pattern Application | ARCHITECT | Apply architectural patterns |
| Best Practices | GUARDIAN | Link to security best practices |

### Phase L: Loop
| Sub-phase | Agent Mode | Responsibility |
|-----------|-----------|----------------|
| Iteration | DEBUGGER | Verify and iterate on solutions |
| Quality Check | GUARDIAN | Final security review |
| Documentation | PROFESSOR | Document learnings |
| Handoff | ORCHESTRATION | Summarize and deliver |

## HELL Milestones

The HELL framework uses milestones to track progress:

```yaml
milestones:
  m1_context:
    name: "Context Established"
    description: "User intent understood, relevant context gathered"
    exit_criteria:
      - Mode selected
      - Pre-hooks executed
      - Context documented
    
  m2_education:
    name: "Education Complete"
    description: "All learning objectives addressed"
    exit_criteria:
      - Concepts explained
      - Examples provided
      - Questions answered
    
  m3_integration:
    name: "Knowledge Linked"
    description: "Concepts connected and synthesized"
    exit_criteria:
      - Patterns identified
      - Relationships mapped
      - Gaps filled
    
  m4_delivery:
    name: "Solution Delivered"
    description: "Final output ready and documented"
    exit_criteria:
      - Solution implemented
      - Tests passing
      - Docs synced to Obsidian
```

## Mode HELL Instructions

Each mode includes HELL phase instructions:

### PROFESSOR Mode
```
In HELL Context (H): Identify what user wants to learn
In HELL Educate (E): Teach with examples, analogies, exercises
In HELL Link (L): Connect to user's existing knowledge
In HELL Loop (L): Verify understanding, iterate if needed
```

### DEBUGGER Mode
```
In HELL Context (H): Gather error logs, stack traces
In HELL Educate (E): Analyze root cause, understand system
In HELL Link (L): Connect to similar bugs, patterns
In HELL Loop (L): Implement fix, verify, prevent regression
```

### GUARDIAN Mode
```
In HELL Context (H): Identify attack surface, assets to protect
In HELL Educate (E): Analyze vulnerabilities, OWASP categories
In HELL Link (L): Connect to security patterns, compliance
In HELL Loop (L): Verify mitigations, document posture
```

## HELL Context Variables

When running in HELL mode, these variables are available:

| Variable | Description |
|----------|-------------|
| `$HELL_PHASE` | Current phase (hook/educate/link/loop) |
| `$HELL_MILESTONE` | Current milestone |
| `$HELL_ITERATION` | Loop iteration count |
| `$HELL_CONTEXT` | Path to context file |
| `$HELL_VAULT` | Obsidian vault path |

## Obsidian Integration with HELL

The Obsidian vault is the "brain" of the HELL framework:

```
/vault
├── 00-HELL/
│   ├── contexts/         # Saved HELL contexts
│   ├── milestones/       # Milestone tracking
│   └── loops/           # Loop iterations
├── 00-PROFESSOR/        # Teaching sessions
├── 00-DEBUGGER/         # Bug analysis
├── 00-GUARDIAN/         # Security notes
└── ...
```

## Running HELL Mode

```bash
# Activate HELL mode with specific starting phase
./scripts/delegate.sh hell --phase educate

# Resume from a specific milestone
./scripts/delegate.sh hell --resume m2_education

# View HELL status
./scripts/delegate.sh hell --status
```

## HELL + Mode Orchestration Example

```yaml
User request: "Preciso criar um sistema de auth seguro"

HELL Flow:
  H (Hook):
    - ORCHESTRATION detects: security + architecture + implementation
    - Mode selected: GUARDIAN + ARCHITECT + CODER
    
  E (Educate):
    - GUARDIAN: OWASP auth requirements
    - ARCHITECT: Auth patterns (JWT, OAuth, SAML)
    - RESEARCHER: Latest best practices
    
  L (Link):
    - ARCHITECT: Connect patterns to requirements
    - GUARDIAN: Map threats to mitigations
    - ORCHESTRATION: Synthesize into architecture
    
  L (Loop):
    - CODER: Implement
    - GUARDIAN: Security review
    - DEBUGGER: Test and verify
    - If issues → loop back to appropriate phase
```

## Best Practices

1. **Never skip phases**: Each HELL phase adds value
2. **Obsess over context**: Better context = better output
3. **Document in Loop**: Don't wait until the end
4. **Embrace iteration**: Loops are features, not bugs
5. **Mode switching**: Use right mode for each phase
