---
name: dos-hell:spec
description: "HELL Specification — Extract requirements, domain model, variation points"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Specification Phase — Extração bruta de requisitos com GRASP Analysis.

Zero ambiguidade. Zero suposição. Se requisitos estão vagos, INTERROGUE.
</objective>

<context>
## HELL Spec Process

```
INTERROGATÓRIO ──► DOMAIN MAP ──► VARIATION POINTS ──► GATE
```

## Artifacts Generated

- `hell-spec.md` — Requirements + Domain Model + Variation Points
- Updates existing `specs.md` if present (OpenSpec integration)

## GRASP Analysis Required

| Pattern | Question |
|---------|----------|
| Information Expert | Quem detém cada dado? |
| Creator | Quem cria cada entidade? |
| Protected Variations | O que pode mudar? |
| Controller | Quem orquestra cada use case? |

## Reference
Full process: `kernel/hell/HELL-WORKFLOW-STEPS.md` → FASE 1
</context>

<process>
1. **LOCATE** the current change proposal in `changes/`
   - If no proposal exists, warn: "Execute /dos-propose primeiro."

2. **INTERROGATE** requirements:
   - Functional: Atores, Casos de uso (Ator → Ação → Resultado), Edge cases
   - Non-Functional: Performance, Segurança, Escalabilidade
   - Constraints: Stack obrigatória, Budget, Regulatório
   - If ANY requirement is vague → STOP and ask: "Requisitos insuficientes. Defina [X], [Y], [Z]."

3. **MAP DOMAIN** using GRASP:
   - Identify Entities, Value Objects, Aggregates
   - Apply Information Expert: assign responsibility to data owner
   - Apply Creator: define who creates each entity
   - Build Ubiquitous Language glossary

4. **IDENTIFY VARIATION POINTS** (Protected Variations):
   - What can change? → Define protective interface
   - What is stable? → Mark as concrete

5. **GENERATE** `hell-spec.md` in `changes/[proposal]/`:
   ```markdown
   ---
   Project: [[PROJECT]]
   HELL_Phase: Requisitos
   Status: 🔥 ACTIVE
   Patterns_Used: [Information_Expert, Creator, Protected_Variations]
   ---
   # HELL Specification: [Feature]
   ## Requisitos Funcionais
   ## Requisitos Não-Funcionais
   ## Domain Model (GRASP)
   ## Variation Points
   ## Ubiquitous Language
   ```

6. **GATE CHECK**:
   - [ ] All requirements have priority (MUST/SHOULD/COULD/WONT)
   - [ ] Domain modeled with Entities, VOs, Aggregates
   - [ ] Variation points identified with interfaces
   - [ ] Glossary documented
   - Report gate status
</process>
