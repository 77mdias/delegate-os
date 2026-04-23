---
name: dos-hell:obsidian-tasks
description: "Task management via Obsidian checklist/tasks plugin | /dos-hell:obsidian-tasks [create|list|done|block|recurring]"
argument-hint: "[create|list|done|block|recurring]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Obsidian Tasks — Task Management System

"Tasks are commitments. Track them with rigor."

Manages tasks via Obsidian daily notes, checklist plugins, and task views.
</objective>

<context>
## Task Structure

```markdown
- [ ] Task description #tag @context ⏰$DATE
- [x] Completed task ✓ $COMPLETED_DATE
```

## Task Types

| Type | Storage | Purpose |
|------|---------|---------|
| daily | Daily note task list | Today's commitments |
| milestone | tasks/milestones/ | Major checkpoints |
| recurring | tasks/recurring/ | Repeating tasks |
| backlog | notes/backlog/ | Future work |
| blocked | tasks/blocked/ | Waiting on something |

## Operations

### Create Task (Daily)
```bash
obsidian daily:append content="- [ ] $TASK_DESCRIPTION #agent ⏰$DATE"
```

### Create Task (Specific)
```bash
obsidian create name="tasks/active/$(date +%Y%m%d)-$TASK_ID.md" content="$TASK_TEMPLATE" silent
obsidian append file="tasks/active/tasks.md" content="- [ ] $TASK"
```

### List Tasks
```bash
obsidian tasks daily
obsidian search query="tag:#task #active" limit=50
```

### Complete Task
```bash
obsidian eval code="
const file = app.vault.getAbstractFileByPath('tasks.md');
const content = await app.vault.read(file);
content = content.replace('- [ ] $TASK', '- [x] $TASK ✓ $(date +%Y-%m-%d)');
await app.vault.modify(file, content);
"
```

### Blocked Tasks
```bash
obsidian create name="tasks/blocked/$TASK_ID.md" content="# Blocked: $TASK\nBlocking: $BLOCKER\nSince: $DATE" silent
```
</context>

<process>
Route to appropriate sub-operation:

- create → Create new task (daily or specific)
- list → List active tasks
- done → Mark task complete
- block → Mark task as blocked
- recurring → Setup recurring task

## HELL Logic Gate

1. **Information Expert** — Daily or project task?
2. **Pure Fabrication** — Task template?
3. **Protected Variations** — Due date, priority?
4. **Indirection** — Blocked by what?
5. **Polymorphism** — Recurring vs one-time?
</process>

<rules>
- All tasks must have at least one tag: #task, #agent, #milestone
- Use ⏰ for due date, 🔴 for priority
- Daily tasks go in daily note
- Milestone tasks go in tasks/milestones/
- Blocked tasks must reference blocker
- Review and clean weekly
</rules>