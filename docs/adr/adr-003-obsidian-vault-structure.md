# ADR-003: Obsidian Vault Structure

**Status**: Accepted

**Date**: 2024-01-15

**Authors**: Delegado OS Team

**Deciders**: Delegado OS Team, Project Maintainers

---

## Context

Delegado OS uses Obsidian as its persistent memory layer. The vault structure must support:

- Agent session memory and context
- Knowledge graph with linked concepts
- Mode-specific memory organization
- Task execution history and artifacts
- Learning and skill tracking
- Long-term knowledge retention

The challenge is designing a vault structure that is:
- Intuitive for agents to navigate
- Supports efficient querying via Dataview
- Scales to thousands of notes
- Enables cross-mode context sharing
- Maintains clear organization without becoming fragmented

---

## Decision

We adopt a **hierarchical namespace** vault structure with **mode-prefixed** organization:

```
Obsidian/
├── 00-meta/                    # Vault-level metadata
│   ├── vault-config.md         # Vault settings and structure
│   ├── index.md               # Vault index
│   └── graph-overview.md      # High-level knowledge map
│
├── 01-sessions/               # Agent session logs
│   ├── 2024/
│   │   ├── 01-15-session-001.md
│   │   ├── 01-15-session-002.md
│   │   └── 01-16-session-003.md
│   └── _TEMPLATES/
│       └── session-template.md
│
├── 02-modes/                  # Mode-specific memory
│   ├── guardian/
│   │   ├── security-audits/
│   │   ├── vulnerabilities/
│   │   └── compliance/
│   ├── mentor/
│   │   ├── career-paths/
│   │   ├── skill-assessments/
│   │   └── learning-resources/
│   ├── consultant/
│   │   ├── strategies/
│   │   ├── reviews/
│   │   └── analyses/
│   ├── architect/
│   │   ├── designs/
│   │   ├── patterns/
│   │   └── tradeoffs/
│   ├── professor/
│   │   ├── lessons/
│   │   ├── explanations/
│   │   └── reviews/
│   └── researcher/
│       ├── literature/
│       ├── benchmarks/
│       └── experiments/
│
├── 03-knowledge/              # Shared knowledge base
│   ├── concepts/              # Fundamental concepts
│   ├── patterns/              # Design patterns (GoF, GRASP)
│   ├── practices/             # Best practices
│   └── references/            # External references
│
├── 04-tasks/                  # Task execution history
│   ├── completed/
│   ├── failed/
│   └── queued/
│
├── 05-artifacts/              # Generated artifacts
│   ├── code/
│   ├── configs/
│   ├── docs/
│   └── reports/
│
├── 06-learning/               # Learning and skill development
│   ├── skills/
│   ├── progress/
│   └── goals/
│
├── 07-inbox/                  # Unprocessed notes
│   └── .gitkeep
│
└── daily/                     # Daily notes
    ├── 2024-01-15.md
    ├── 2024-01-16.md
    └── daily-template.md
```

---

## Naming Conventions

### Note Naming

| Type | Format | Example |
|------|--------|---------|
| Session | `YYYY-MM-DD-session-XXX.md` | `2024-01-15-session-001.md` |
| Daily | `YYYY-MM-DD.md` | `2024-01-15.md` |
| Task | `task-{id}-{type}.md` | `task-123-security-audit.md` |
| Concept | `concept-{slug}.md` | `concept-dependency-injection.md` |
| Pattern | `pattern-{name}.md` | `pattern-observer.md` |
| Mode-specific | `{mode}-{context}.md` | `guardian-auth-vuln-2024-01.md` |

### Frontmatter Schema

```yaml
---
id: unique-id
type: session | task | concept | pattern | artifact | daily
mode: guardian | mentor | consultant | architect | professor | researcher | null
status: active | completed | archived
created: YYYY-MM-DDTHH:mm:ssZ
updated: YYYY-MM-DDTHH:mm:ssZ
tags: [tag1, tag2]
links: [note-id-1, note-id-2]
---

# Note Content
```

---

## Directory Purposes

### 00-meta/

Vault-level configuration and overview notes. Contains:
- `vault-config.md`: Documents the vault structure and conventions
- `index.md`: Auto-generated index of all notes
- `graph-overview.md`: High-level visualization of knowledge graph

### 01-sessions/

Agent session logs that capture:
- Mode activation/deactivation
- Tasks executed
- Decisions made
- Context at session start
- Key outcomes

### 02-modes/

Mode-specific memory organized by:
- Primary focus area (security-audits, career-paths, etc.)
- Temporal subdivisions for related notes
- Cross-linked to shared knowledge

### 03-knowledge/

Shared knowledge base:
- `concepts/`: Fundamental ideas and definitions
- `patterns/`: Design patterns with GoF/GRASP categorization
- `practices/`: Best practices and guidelines
- `references/`: Links to external documentation

### 04-tasks/

Task execution tracking:
- Links to full task artifacts
- Execution metadata (duration, success, mode)
- Error information for failed tasks

### 05-artifacts/

Generated content:
- Code snippets and files
- Configuration files
- Documentation
- Reports (security, analysis, etc.)

### 06-learning/

Skill development tracking:
- Skills acquired and proficiency levels
- Learning goals and progress
- Resource recommendations

### 07-inbox/

Temporary storage for notes requiring processing:
- Ideas that need development
- Notes awaiting categorization
- Captured thoughts

### daily/

Daily notes for:
- Day-level context and planning
- Cross-mode daily summaries
- Time-based reflection

---

## Dataview Queries

### Find All Notes for a Mode

```dataview
TABLE mode, status, created
FROM "02-modes"
WHERE mode = "guardian"
SORT created DESC
```

### Find Recent Sessions

```dataview
TABLE mode, length(file.tasks) as tasks
FROM "01-sessions"
WHERE date(created) >= date(today) - dur(7 days)
SORT created DESC
```

### Find Completed Tasks

```dataview
TABLE mode, status, file.ctime as completed
FROM "04-tasks"
WHERE status = "completed"
SORT file.ctime DESC
LIMIT 20
```

### Knowledge Graph Stats

```dataview
TABLE length(file.outlinks) as outgoing, length(file.inlinks) as incoming
FROM "03-knowledge"
SORT incoming DESC
LIMIT 10
```

---

## Sync Configuration

```yaml
obsidian:
  vault_path: ./Obsidian
  sync:
    interval_seconds: 60
    batch_size: 50
    include:
      - "01-sessions/**"
      - "02-modes/**"
      - "03-knowledge/**"
      - "04-tasks/**"
      - "05-artifacts/**"
      - "06-learning/**"
    exclude:
      - "07-inbox/**"
      - "daily/**"
      - "**/.obsidian/**"
      - "**/*.tmp"
```

---

## Consequences

### Positive

- **Clear Organization**: Each type of content has a defined home
- **Mode Isolation**: Modes can work independently without collision
- **Efficient Queries**: Dataview can quickly filter by directory
- **Scalable**: Numbering prefix maintains order as vault grows
- **Flexible**: inbox/ allows capture without immediate organization

### Negative

- **Depth**: Some paths are deep (e.g., `02-modes/guardian/security-audits/`)
- **Learning Curve**: New users must understand the structure
- **Migration**: Moving notes between directories requires path updates

### Neutral

- Directory structure is convention-based, not enforced
- Agents can operate with partial vault understanding

---

## Alternatives Considered

### Option 1: Flat Structure with Tags

All notes in root, tagged for organization.

**Pros**: Simple, easy to add notes

**Cons**: Becomes unwieldy at scale, poor Dataview performance

**Decision**: Rejected - loses organizational benefits.

### Option 2: Mode-Only Hierarchy

Only `/{mode}/` directories without sub-categorization.

**Pros**: Simpler, mode-focused

**Cons**: Too much mixing of note types within modes

**Decision**: Rejected - lacks organization within modes.

### Option 3: Temporal + Type Hybrid

Organized by year/month then by type.

**Pros**: Natural time-based browsing

**Cons**: Hard to find related notes across time periods

**Decision**: Rejected - breaks concept relationships.

---

## References

- [ADR-001: ADRs Introduction](./adr-001-adr-introduction.md)
- [ADR-002: Mode Orchestration](./adr-002-mode-orchestration.md)
- [docs/obsidian-integration.md](../../docs/obsidian-integration.md)
- [docs/memory-system.md](../../docs/memory-system.md)
