---
name: dos-feedback
description: "Register feedback about Delegado OS performance"
argument-hint: "[feedback-text]"
allowed-tools:
  - Read
  - Write
  - Bash
---

<objective>
Register user feedback about Delegado OS performance and behavior.
</objective>

<context>
## Feedback

Feedback é usado para:
- Melhorar sugestões
- Corrigir comportamento
- Aprender preferências
</context>

<process>
1. Accept feedback text from argument or prompt
2. Create memory/ directory if not exists
3. Append to memory/feedback.md with timestamp
4. Confirm registration
</process>
