---
name: dos-hell:obsidian-memory
description: "Agent memory persistence in Obsidian vault | /dos-hell:obsidian-memory [read|write|search|context]"
argument-hint: "[read|write|search|context]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Obsidian Memory — Persistent Agent Memory System

"Every interaction feeds memory. Every memory enables future intelligence."

Stores agent experiences, learnings, contexts, and user profiles in Obsidian vault.
</objective>

<context>
## Memory Types

| Type | Path | Purpose |
|------|------|---------|
| session | memory/sessions/YYYY/MM/ | Session logs and context |
| project | memory/projects/ | Project-specific context |
| user | memory/user/ | User profiles and preferences |
| learnings | memory/learnings/ | Captured patterns and insights |

## Memory Template

```markdown
---
created: $ISO_DATE
updated: $ISO_DATE
type: session|project|user|learning
tags: [agent, memory, $CONTEXT]
status: active|archived
---

# $TITLE

## Context
$CONTEXT

## Key Decisions
$DECISIONS

## Learnings
$LEARNINGS

## Related
- [[memory/sessions/...]]
- [[memory/user/...]]
```

## Operations

### Read Memory
```bash
obsidian search query="tag:#memory" limit=20
obsidian read path="memory/sessions/2025/04/session-20250423.md"
```

### Write Memory
```bash
obsidian create name="memory/sessions/$(date +%Y)/session-$(date +%Y%m%d-%H%M%S)" content="$TEMPLATE" silent
```

### Search Memory
```bash
obsidian search query="#agent AND #memory $TOPIC" limit=20
```
</context>

<process>
Route to appropriate sub-operation:

- read → Read from memory (search + fetch)
- write → Write new memory (create/update)
- search → Search memories (graph query)
- context → Load context for current session

## HELL Logic Gate

1. **Information Expert** — Which memory type?
2. **Pure Fabrication** — Standardized template?
3. **Protected Variations** — Tag-based retrieval?
4. **Indirection** — Link to related memories?
5. **Polymorphism** — Per-type handling?
</process>

<rules>
- Always use frontmatter with created/updated timestamps
- Tag with #agent and #memory plus context tags
- Link related memories using [[wikilinks]]
- Use daily folder structure: YYYY/MM/
- Archive stale memories after 90 days
- Search before creating to avoid duplicates
</rules>