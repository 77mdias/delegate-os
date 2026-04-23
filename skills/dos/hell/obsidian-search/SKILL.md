---
name: dos-hell:obsidian-search
description: "Vault search — full-text, graph queries, backlinks | /dos-hell:obsidian-search [find|graph|links|tags|recent]"
argument-hint: "[find|graph|links|tags|recent]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Obsidian Search — Vault Intelligence

"Find knowledge before creating it. Connect before isolating."

Provides advanced search capabilities: full-text, graph queries, backlinks.
</objective>

<context>
## Search Operations

### Full-Text Search
```bash
obsidian search query="$TERM" limit=50
obsidian search query="#concept AND #tutorial" limit=20
```

### Tag-Based Search
```bash
obsidian tags sort=count counts
obsidian search query="tag:#$TAG" limit=30
```

### Backlink Search
```bash
obsidian backlinks file="$NOTE"
obsidian search query="[[$NOTE]]" limit=50
```

### Recent Files
```bash
obsidian list limit=50 sort=modified
```

## Graph Query Patterns

| Pattern | Query | Purpose |
|---------|-------|---------|
| Concept cluster | tag:#concept | Find all concept notes |
| Task trail | #task #active | Active task network |
| Memory chain | #memory #session | Session history |
| Project context | #project #$NAME | Project knowledge |

## Obsidian CLI Search

```bash
# Basic search
obsidian search query="brainstorm" limit=20

# Tag search
obsidian search query="tag:#agent" limit=30

# Path search
obsidian search query="path:memory/" limit=20

# Combined
obsidian search query="#concept AND #tutorial" limit=20
```
</context>

<process>
Route to appropriate sub-operation:

- find → Full-text search
- graph → Graph-based queries
- links → Backlink analysis
- tags → Tag taxonomy queries
- recent → Recently modified files

## HELL Logic Gate

1. **Information Expert** — What type of knowledge?
2. **Pure Fabrication** — Search index or direct?
3. **Protected Variations** — Exact or fuzzy?
4. **Indirection** — Tag or content?
5. **Polymorphism** — Single or multi-result?
</process>

<rules>
- Always search before creating to avoid duplicates
- Use tag-based search for concept retrieval
- Use content search for specific terms
- Build backlink chains for related knowledge
- Archive old searches in memory/ folder
- Tag new content with appropriate taxonomy
</rules>