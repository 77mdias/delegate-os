---
name: dos-learn
description: "Teach Delegado OS a new rule or convention"
argument-hint: "[rule-text]"
allowed-tools:
  - Read
  - Write
  - Bash
---

<objective>
Learn a new rule or convention from user feedback.
</objective>

<context>
## Learn

O sistema aprende regras e convenções do projeto para aplicar em futuras execuções.
</context>

<process>
1. Accept rule text from argument or prompt
2. Create memory/ directory if not exists
3. Append to memory/regras.md with timestamp
4. Confirm learning with message
</process>
