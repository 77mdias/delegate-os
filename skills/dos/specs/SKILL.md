---
name: dos-specs
description: "Create or edit specifications for a change proposal"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
Create or edit specifications (specs.md) for the current change proposal.
</objective>

<context>
## OpenSpec Workflow
proposal → specs → design → tasks → implement

## Specs

O specs.md deve conter:
- Funcionalidades detalhadas
- User stories
- Acceptance criteria
- Dependencies
- Constraints
</context>

<process>
1. Find current proposal in changes/
2. Create or edit specs.md with:
   - # Specifications
   - ## Funcionalidades
   - ## User Stories
   - ## Acceptance Criteria
   - ## Dependencies
   - ## Constraints
3. Show artifact path
</process>
