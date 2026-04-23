---
name: dos-hell:obsidian-notes
description: "Note CRUD and structured authoring in Obsidian | /dos-hell:obsidian-notes [create|read|update|append|link|template]"
argument-hint: "[create|read|update|append|link|template]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Obsidian Notes — Structured Note Management

"Notes are the building blocks of knowledge. Structure them well."

Provides note operations with templates, linking, and organized storage.
</objective>

<context>
## Note Types

| Type | Path | Purpose |
|------|------|---------|
| daily | notes/daily/YYYY-MM-DD.md | Daily session notes |
| spec | notes/specs/ | Specification documents |
| backlog | notes/backlog/ | Feature/backlog items |
| meeting | notes/meetings/ | Meeting notes |
| reference | notes/refs/ | Reference materials |

## Note Templates

### Daily Note Template
```markdown
---
created: $ISO_DATE
tags: [daily, agent, session]
---

# Daily Note: $DATE

## Session Start
- Time: $TIME
- Context: $CONTEXT

## Tasks
- [ ]

## Notes


## Session End
- Summary: $SUMMARY
```

### Spec Note Template
```markdown
---
created: $ISO_DATE
updated: $ISO_DATE
type: spec
status: draft|review|approved
tags: [spec, $CATEGORY]
---

# $SPEC_NAME

## Overview
$OVERVIEW

## Requirements
-

## Design
$TODOS

## Implementation
- [ ]

## Verification
-
```

## Operations

### Create Note
```bash
obsidian create name="notes/$TYPE/$NAME" content="$TEMPLATE" silent
obsidian create name="notes/daily/$(date +%Y-%m-%d)" content="$DAILY_TEMPLATE" template="DailyNote" silent
```

### Append to Note
```bash
obsidian append file="$NOTE" content="
## $SECTION
$CONTENT"
```

### Link Notes
```bash
obsidian property:set name="links" value="[[noteA]], [[noteB]]" file="$NOTE"
```
</context>

<process>
Route to appropriate sub-operation:

- create → Create new note with template
- read → Read note content
- update → Update note (replace content)
- append → Append to existing note
- link → Create backlinks between notes
- template → Create/update note templates

## HELL Logic Gate

1. **Information Expert** — Where should this note live?
2. **Pure Fabrication** — Which template applies?
3. **Protected Variations** — How to ensure findability?
4. **Indirection** — Link to related notes?
5. **Polymorphism** — Type-specific handling?
</process>

<rules>
- Use descriptive filenames with date prefixes when applicable
- Always add frontmatter with created, tags, status
- Apply appropriate template based on note type
- Create backlinks to related notes
- Use consistent tag taxonomy
- Clean up empty notes weekly
</rules>