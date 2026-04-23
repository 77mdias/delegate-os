---
name: dos-memory
description: "Show Delegado OS memory and learned rules"
argument-hint: "[rules|preferences|conventions|feedback]"
allowed-tools:
  - Read
  - Bash
  - Glob
---

<objective>
Display the Delegado OS memory including learned rules, preferences, conventions, and feedback.
</objective>

<context>
## Memory

O sistema mantém memória em:
- memory/regras.md — Regras aprendidas
- memory/preferencias.md — Preferências do usuário
- memory/conventions.md — Convenções do projeto
- memory/feedback.md — Feedback registrado
</context>

<process>
1. Check if memory/ directory exists
2. Display contents of each memory file:
   - Without argument: show all
   - /dos-memory rules: show regras.md
   - /dos-memory preferences: show preferencias.md
   - /dos-memory conventions: show conventions.md
   - /dos-memory feedback: show feedback.md
3. If no memory exists, show setup instructions
</process>
