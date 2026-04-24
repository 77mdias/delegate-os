# ADR-002: Mode Orchestration Approach

**Status**: Accepted

**Date**: 2024-01-15

**Authors**: Delegado OS Team

**Deciders**: Delegado OS Team, Project Maintainers

---

## Context

Delegado OS supports multiple specialized agent modes (Guardian, Mentor, Consultant, Architect, Professor, Researcher) that work together to handle different aspects of software development tasks. The challenge is orchestrating these modes efficiently to:

- Route tasks to appropriate modes based on capabilities
- Enable collaboration between modes when needed
- Manage resource allocation across modes
- Maintain context and state between mode switches
- Support both autonomous and coordinated operation

We evaluated several approaches to mode orchestration.

---

## Decision

We implement a hierarchical mode orchestration system with three tiers:

### Tier 1: Orchestrator (Top Level)

The Orchestrator mode acts as the top-level coordinator:

```yaml
orchestrator:
  routing:
    strategy: capability-based
    fallback: guardian
  coordination:
    enabled: true
    max_concurrent_modes: 3
  context:
    shared: true
    sync_interval_ms: 1000
```

### Tier 2: Mode Specialization (Middle Level)

Each mode specializes in specific task types:

| Mode | Primary Focus | Capabilities |
|------|--------------|--------------|
| Guardian | Security & Compliance | security-audit, vulnerability-scan, compliance-check |
| Mentor | Learning & Career | career-roadmap, skill-assessment, learning-path |
| Consultant | Strategic Advisory | tech-strategy, architecture-review, cost-analysis |
| Architect | System Design | system-design, pattern-selection, tradeoff-analysis |
| Professor | Education | lesson-planning, code-review, explanation |
| Researcher | Investigation | literature-review, benchmarking, prototyping |

### Tier 3: Task Execution (Bottom Level)

Tasks execute within modes using specialized skills.

### Mode Handoff Protocol

When a task requires multiple modes:

```yaml
handoff:
  protocol: state-transfer
  modes:
    - from: architect
      to: guardian
      trigger: design-complete
  state:
    include: [context, decisions, artifacts]
    exclude: [intermediate-computation]
```

---

## Mode Orchestration Rules

### 1. Single Mode Execution

Default behavior - tasks execute within a single mode:

```
task(type=security-audit) -> orchestrator -> guardian -> execution
```

### 2. Sequential Mode Handoff

For tasks requiring multiple specialized views:

```
task(type=security-design) 
  -> architect (design) 
  -> guardian (review) 
  -> architect (revise)
  -> completion
```

### 3. Parallel Mode Execution

For independent sub-tasks:

```
task(type=comprehensive-review)
  -> orchestrator
  -> [guardian, mentor, consultant] (parallel)
  -> result aggregation
  -> summary
```

---

## Implementation

### Mode Registry

```yaml
modes:
  guardian:
    priority: 10
    capabilities:
      - security-audit
      - vulnerability-scan
      - compliance-check
    config:
      severity_threshold: medium
      auto_remediate: false
    resources:
      max_agents: 4
      memory_per_agent_mb: 256

  mentor:
    priority: 5
    capabilities:
      - career-roadmap
      - skill-assessment
      - learning-path
    config:
      include_examples: true
      difficulty: adaptive
    resources:
      max_agents: 2
      memory_per_agent_mb: 512
```

### Routing Algorithm

```python
def route_task(task):
    # 1. Match by explicit mode hint
    if task.mode_hint:
        return get_mode(task.mode_hint)
    
    # 2. Match by task type
    for mode_id, mode in modes.items():
        if task.type in mode.capabilities:
            return mode
    
    # 3. Fallback to orchestrator default
    return get_mode(config.fallback_mode)
```

### Context Sharing

```yaml
context:
  shared_between_modes: true
  sync:
    interval_ms: 1000
    strategy: eventual-consistency
  isolation:
    guardian: { isolated: false }
    default: { isolated: false }
```

---

## Consequences

### Positive

- **Clear Specialization**: Each mode has defined responsibilities
- **Flexible Routing**: Tasks route to appropriate modes automatically
- **Scalable**: New modes can be added without modifying core orchestration
- **Parallelism**: Independent tasks execute concurrently across modes
- **Context Preservation**: State transfers between modes for related tasks

### Negative

- **Complexity**: More moving parts than single-mode execution
- **Latency**: Cross-mode handoffs add overhead (100-500ms)
- **Debugging**: Harder to trace execution across multiple modes
- **Resource Management**: Requires careful allocation across modes

### Neutral

- Mode switching is transparent to end users
- Implementation complexity hidden by orchestrator abstraction

---

## Alternatives Considered

### Option 1: Single Mode with Capability Switching

One agent mode that dynamically switches capabilities based on task type.

**Pros**: Simpler architecture, lower cross-mode overhead, easier debugging

**Cons**: Less clear specialization, harder to maintain capability boundaries

**Decision**: Rejected - specialization provides better task fit.

### Option 2: Fully Autonomous Mode Selection

Each mode operates independently, selecting tasks from a shared queue.

**Pros**: Maximum parallelism, no orchestration bottleneck, fault isolation

**Cons**: No coordination for multi-mode tasks, resource competition

**Decision**: Rejected - lack of coordination breaks complex workflows.

### Option 3: Centralized Mode Controller

Single controller that assigns all tasks to modes.

**Pros**: Full visibility, optimal resource allocation, simple decision-making

**Cons**: Single point of failure, bottleneck for high task volumes

**Decision**: Rejected - hierarchical approach provides both coordination and autonomy.

---

## References

- [ADR-001: ADRs Introduction](./adr-001-adr-introduction.md)
- [ADR-003: Obsidian Vault Structure](./adr-003-obsidian-vault-structure.md)
- [MODE-ORCHESTRATOR.md](../../MODE-ORCHESTRATOR.md)
- [AGENT-MODES.md](../../AGENT-MODES.md)
