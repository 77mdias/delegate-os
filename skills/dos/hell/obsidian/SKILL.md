---
name: dos-hell:obsidian
description: "HELL-Obsidian Integration — Agent memory system with Obsidian vault | /dos-hell:obsidian [memory|notes|tasks|search|graph|sync]"
argument-hint: "[memory|notes|tasks|search|graph|sync]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL-Obsidian Integration — Sistema de Memória de Agente com Vault Obsidian

"Memória Persistente. Conhecimento Estruturado. Agent Awarness."

Integração completa do agent com Obsidian para gerenciamento de memórias,
notas, tasks e graph knowledge. Baseado no HELL Method.
</objective>

<context>
## Obsidian Integration Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    HELL OBSIDIAN AGENT                       │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐      │
│  │ memory   │  │ notes    │  │ tasks    │  │ search   │      │
│  │ /obs-mem │  │ /obs-note│  │ /obs-task│  │ /obs-find│      │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘      │
│       │             │             │             │            │
│  ┌────┴─────────────┴─────────────┴─────────────┴────┐      │
│  │              OBSIDIAN CLI + MCP                    │      │
│  └────┬─────────────┬─────────────┬─────────────┬────┘      │
│       │             │             │             │            │
│  ┌────┴─────────────┴─────────────┴─────────────┴────┐      │
│  │              OBSIDIAN VAULT                       │      │
│  │   /memory/    /notes/    /tasks/    /graph/       │      │
│  └────────────────────────────────────────────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

## Skills Hierarchy

| Skill | Purpose |
|-------|---------|
| /dos-hell:obsidian-memory | Persistent agent memories with semantic tagging |
| /dos-hell:obsidian-notes | Note CRUD and structured authoring |
| /dos-hell:obsidian-tasks | Task management via Obsidian checklist/tasks |
| /dos-hell:obsidian-search | Graph queries and full-text search |
| /dos-hell:obsidian-graph | Vault analytics and backlink analysis |
| /dos-hell:obsidian-sync | Sync agent context with vault |

## Vault Structure

```
vault/
├── memory/                    # Agent persistent memories
│   ├── sessions/             # Session logs
│   ├── projects/             # Project context
│   ├── user/                 # User profiles/preferences
│   └── learnings/            # Captured learnings
├── notes/                    # Working notes
│   ├── daily/               # Daily notes
│   ├── specs/               # Specifications
│   └── backlog/             # Backlog items
├── tasks/                    # Task management
│   ├── active/              # Active tasks
│   ├── done/                # Completed
│   └── recurring/           # Recurring tasks
└── graph/                    # Knowledge graph data
    ├── backlinks/           # Backlink index
    └── tags/                # Tag taxonomy
```

## Obsidian CLI Integration

```bash
# Create memory note
obsidian create name="memory/$(date +%Y)/session-$(date +%Y%m%d-%H%M%S)" content="$CONTENT" silent

# Search vault
obsidian search query="$QUERY" limit=20

# Task operations
obsidian tasks daily
obsidian daily:append content="- [ ] $TASK"
```
</context>

<process>
Route to appropriate sub-skill based on argument:

- memory → /dos-hell:obsidian-memory (Agent memory management)
- notes → /dos-hell:obsidian-notes (Note operations)
- tasks → /dos-hell:obsidian-tasks (Task management)
- search → /dos-hell:obsidian-search (Search and find)
- graph → /dos-hell:obsidian-graph (Graph analytics)
- sync → /dos-hell:obsidian-sync (Context sync)

Or display this help if no argument.

## HELL Logic Gate (execute before ANY memory operation)

1. **Information Expert** — Where should this knowledge live?
2. **Pure Fabrication** — Does it need a structured template?
3. **Protected Variations** — How to ensure retrieval?
4. **Indirection** — Link or embed?
5. **Polymorphism** — Tag-based or folder-based?
</process>

<rules>
- Always tag notes with #agent, #context, #memory
- Use YYYY/MM folder structure for time-series memories
- Embed backlinks for cross-referencing
- Use frontmatter for metadata (created, updated, tags, status)
- Daily notes template for session logging
- Search before creating to avoid duplicates
</rules>