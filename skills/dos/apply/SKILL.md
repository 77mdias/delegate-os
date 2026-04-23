---
name: dos-apply
description: "Execute pending tasks from tasks.md"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
Execute pending tasks from the current tasks.md file.
</objective>

<context>
## Apply

Executar tasks uma por uma:
- Marcar como complete quando done
- Executar com validação
- Documentar blockers
- Atualizar progresso
</context>

<process>
1. Read tasks.md from current proposal
2. Show pending tasks list
3. Execute each task sequentially:
   - Mark in progress
   - Execute implementation
   - Run tests/validation
   - Mark complete
4. Report progress and blockers
</process>
