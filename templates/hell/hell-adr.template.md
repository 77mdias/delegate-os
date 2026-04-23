---
title: "HELL ADR-{{number}}: {{title}}"
type: hell-decision
mode: documentation
status: proposed
version: 1.0.0
author: "{{author}}"
date: "{{date}}"
adr-id: "ADR-{{number}}"
---

# 💀 HELL ADR-{{NUMBER}}: {{TITLE}}

```yaml
Project: "[[{{PROJECT}}]]"
HELL_Phase: Refactor
ADR_ID: "ADR-{{number}}"
ADR_Status: PROPOSED
Patterns_Applied:
  GRASP: []
  GoF: []
```

---

## Status

**PROPOSED** | ACCEPTED | DEPRECATED | SUPERSEDED by [ADR-XXX]

---

## Context

[Descreva o problema ou situação que levou a esta decisão. Inclua:
- O que está acontecendo no sistema
- Por que uma decisão é necessária
- Quais forças ou pressões existem]

---

## Decision

[Descreva a decisão tomada. Seja específico sobre:
- O que será feito
- Qual padrão/abordagem será usado
- Como será implementado]

**Pattern Applied:** {{GRASP/GoF pattern name}}
**Justificativa:** {{why THIS pattern and not another}}

---

## Consequences

### Positive ✅

- 
- 

### Negative ⚠️

- 
- 

### Trade-offs

- 

---

## Alternatives Rejected

| Alternative | Reason for Rejection |
|:-----------|:---------------------|
| | |
| | |

---

## Implementation

### Affected Files

| File | Change Type |
|:-----|:-----------|
| `lib/...` | CREATE / MODIFY / DELETE |
| `lib/...` | CREATE / MODIFY / DELETE |

### Before/After

**Before:**
```{{lang}}
// conceptual code before
```

**After:**
```{{lang}}
// conceptual code after
```

---

## Validation

- [ ] Tests updated to reflect decision
- [ ] No existing tests broken
- [ ] Class diagram updated
- [ ] Sequence diagram updated (if flow changed)
- [ ] Reviewed by team/user

---

## References

- Related ADR: [[HELL-ADR-XXX]]
- Related Spec: [[hell-spec-XXX]]
- External: [link]

---

## Revision History

| Date | Status | Author | Notes |
|:-----|:-------|:-------|:------|
| {{date}} | PROPOSED | {{author}} | Initial decision |
| | ACCEPTED | | |
