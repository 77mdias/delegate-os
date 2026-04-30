# Design Patterns Guide

## Overview

This guide documents common design patterns used in Delegado OS and how to apply them.

## Agent Mode Patterns

### 1. Hierarchical Mode Pattern

Higher modes can call lower modes:

```
ORCHESTRATION (top)
    ├── RESEARCHER
    ├── ARCHITECT
    └── GUARDIAN

CODER (bottom - no sub-modes)
```

**When to use:** Complex tasks requiring multiple specialized views.

**Example:**
```yaml
orchestration:
  mode: ORCHESTRATION
  subtasks:
    - Research: "Analyze microservices patterns"
      mode: RESEARCHER
    - Design: "Create architecture document"
      mode: ARCHITECT
    - Secure: "Review for vulnerabilities"
      mode: GUARDIAN
```

### 2. Pipeline Pattern

Modes process output sequentially:

```
RESEARCHER → ARCHITECT → CODER → DEBUGGER → REVIEW
```

**When to use:** Linear workflows with clear handoffs.

**Example:**
```yaml
pipeline:
  stages:
    - name: research
      mode: RESEARCHER
      output: tech-stack.md
    - name: architecture
      mode: ARCHITECT
      input: tech-stack.md
      output: design.md
    - name: implementation
      mode: CODER
      input: design.md
      output: code/
```

### 3. Parallel Mode Pattern

Multiple modes work simultaneously:

```yaml
parallel:
  modes:
    - RESEARCHER: "Research frontend frameworks"
    - RESEARCHER: "Research backend options"
    - GUARDIAN: "Initial security assessment"
  merge: "Consolidate findings"
```

**When to use:** Independent tasks that can run concurrently.

### 4. Observer Pattern

One mode monitors another's output:

```yaml
observer:
  primary: CODER
  observers:
    - GUARDIAN: "Monitor for security issues"
    - DEBUGGER: "Track test coverage"
```

### 5. Strategy Pattern

Select mode based on context:

```yaml
context_analysis:
  detect: "Analyze task keywords"
  strategies:
    bug: DEBUGGER
    new_feature: ARCHITECT + CODER
    learn: PROFESSOR
    review: REVIEW
```

## Hook Patterns

### 1. Before-Aft...[truncated]