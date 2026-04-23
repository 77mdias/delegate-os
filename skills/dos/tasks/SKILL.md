---
name: dos-tasks
description: "Generate atomic tasks from specifications"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
Generate atomic tasks from specifications for implementation.
</objective>

<context>
## Tasks

Tarefas atômicas devem ser:
- Small (1-4 horas)
- Testable
- Independentes
- Com acceptance criteria claros
</context>

<process>
1. Read specs from current proposal
2. Generate atomic tasks.md with:
   - # Tasks
   - Cada task com ID, descrição, tempo estimado, acceptance criteria
3. Group tasks by module/component
4. Show task count and artifact path
</process>
