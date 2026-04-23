---
name: dos-design
description: "Create technical design document"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
Create technical design document (design.md and architecture.md) for the current change.
</objective>

<context>
## Design

O design.md deve conter:
- Arquitetura técnica
- Data models
- API design
- Sequence diagrams
- Technology choices

O architecture.md deve conter:
- High-level architecture
- Component diagram
- Data flow
- External dependencies
</context>

<process>
1. Find current proposal in changes/
2. Create design.md with technical design
3. Create architecture.md with high-level architecture
4. Show artifact paths
</process>
