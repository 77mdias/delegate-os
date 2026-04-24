# HELL-Obsidian Vault

Vault created by HELL Method + Obsidian integration.

## Structure

- `00-INBOX/` - Inbox for unprocessed notes
- `01-PROJECTS/` - Project-specific notes
- `02-PATTERNS/` - GRASP and GoF pattern catalog
- `03-DASHBOARDS/` - Dataview dashboards
- `04-TEMPLATES/` - Templater templates
- `05-ARCHIVE/` - Archived notes

## Required Plugins

- **Dataview** - For YAML queries
- **Templater** - For dynamic templates
- **Calendar** - For daily notes
- **QuickAdd** - Fast note creation

## Commands

```bash
# Create spec
obsidian create name="01-PROJECTS/MyApp/specs/hell-spec-auth" silent

# Create daily
obsidian daily:append content="- [ ] Task"

# Search
obsidian search query="tag:#hell #tdd" limit=20
```

## Links

- [HELL Method](kernel/hell/HELL-CORE-ENGINE.md)
- [Obsidian Integration](../docs/obsidian-integration.md)
