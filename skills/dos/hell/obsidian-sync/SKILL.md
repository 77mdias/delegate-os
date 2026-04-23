---
name: dos-hell:obsidian-sync
description: "Sync agent context with Obsidian vault | /dos-hell:obsidian-sync [push|pull|snapshot|restore|sessions]"
argument-hint: "[push|pull|snapshot|restore|sessions]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Obsidian Sync — Agent Context Synchronization

"Keep agent and vault in harmony. Context never lost."

Synchronizes agent session context with Obsidian vault for persistence and recovery.
</objective>

<context>
## Sync Operations

### Push (Agent → Obsidian)
```bash
# Push current session context to memory
obsidian create name="memory/sessions/$(date +%Y)/session-$(date +%Y%m%d-%H%M%S).md" content="$CONTEXT" silent

# Push learned patterns
obsidian append file="memory/learnings/patterns.md" content="

## $PATTERN
$DESCRIPTION
Captured: $DATE
"
```

### Pull (Obsidian → Agent)
```bash
# Load recent session context
obsidian search query="tag:#memory #session" limit=5

# Load user preferences
obsidian read path="memory/user/preferences.md"
```

### Snapshot
```bash
# Create full vault snapshot
obsidian eval code="
const files = app.vault.getFiles();
const snapshot = files.map(f => ({
  name: f.name,
  path: f.path,
  content: await app.vault.read(f),
  mtime: f.modifiedTime
}));
require('fs').writeFileSync('snapshot.json', JSON.stringify(snapshot));
"
```

### Restore
```bash
# Restore from snapshot
obsidian eval code="
const snapshot = JSON.parse(require('fs').readFileSync('snapshot.json'));
for (const f of snapshot) {
  const existing = app.vault.getAbstractFileByPath(f.path);
  if (existing) {
    await app.vault.modify(existing, f.content);
  } else {
    await app.vault.create(f.path, f.content);
  }
}
"
```

## Session Sync Protocol

1. **Session Start:** Pull latest session memory
2. **Milestone:** Push context snapshot
3. **Session End:** Push final summary to memory
4. **Weekly:** Full vault snapshot

## Sync Strategy

| Trigger | Action | Target |
|---------|--------|--------|
| /session-start | Pull last session | memory/sessions/ |
| /milestone | Push snapshot | memory/snapshots/ |
| /session-end | Push summary | memory/sessions/ |
| /weekly-sync | Full backup | memory/backups/ |
</context>

<process>
Route to appropriate sub-operation:

- push → Push agent state to vault
- pull → Load vault state to agent
- snapshot → Full vault snapshot
- restore → Restore from snapshot
- sessions → Session history management

## HELL Logic Gate

1. **Information Expert** — What state to sync?
2. **Pure Fabrication** — Snapshot format?
3. **Protected Variations** — Incremental or full?
4. **Indirection** — File or memory?
5. **Polymorphism** — Push or pull?
</process>

<rules>
- Sync at session start, milestones, and end
- Always push to timestamped session files
- Keep memory/snapshots/ for recovery
- Incremental sync for large vaults
- Verify sync success with confirmation
- Backup before major operations
</rules>