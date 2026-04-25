---
title: "FEATURE-{{YYY}}: {{nome da feature}}"
type: feature-proposal
status: {{PROPOSED|APPROVED|REJECTED|IMPLEMENTED|DEFERRED}}
priority: {{🔴|🟡|🟢|🔵}}
severity: {{CRITICAL|MAJOR|MINOR|TRIVIAL}}
gates: {{M1|M2|M3|M4|M5}}
related-gap: GAP-{{XXX}}
related-specs: [SPEC-XXX, SPEC-YYY]
phase-target: {{PHASE-XX}}
date: {{YYYY-MM-DD}}
author: "{{agent/user}}"
estimated-effort: "{{XS|S|M|L|XL|XXL}}"
---

# FEATURE-{{YYY}}: {{Título da Feature}}

**ID:** FEATURE-{{YYY}}
**Status:** {{PROPOSED|APPROVED|REJECTED|IMPLEMENTED|DEFERRED}}
**Prioridade:** {{🔴 Crítica|🟡 Alta|🟢 Média|🔵 Baixa}}
**Gate Alvo:** {{M1|M2|M3|M4|M5}}
**Fase Alvo:** {{PHASE-XX}}
**Data de Criação:** {{YYYY-MM-DD}}
**Autor:** {{agent/user}}
**Estimativa:** {{XS|S|M|L|XL|XXL}} ({{1h|4h|1d|2d|1w|2w}})

---

## Resumo

[Uma frase descrevendo a feature]

## Problema que Resolve

[Descreva o problema ou gap que esta feature resolve]

**Gap Associado:** [GAP-{{XXX}}](./gap-XXX.md)

---

## Gaps que Resolve

| Gap ID | Título | Severidade |
|--------|--------|------------|
| GAP-{{XXX}} | {{título do gap}} | {{🟢|🔵|🟡|🔴}} |

---

## Escopo Proposto

### ✅ Incluído

- [Item 1]
- [Item 2]
- [Item 3]

### ❌ Fora do Escopo

- [Item 1]
- [Item 2]

---

## Templates Sugeridos

| Template | Status | Caminho |
|----------|--------|---------|
| PRD | {{⬜ Pendente|✅ Criado}} | `docs/development/SPECS/prd-YYY.md` |
| HELL Spec | {{⬜ Pendente|✅ Criado}} | `docs/development/SPECS/hell-spec-YYY.md` |
| Phase Board | {{⬜ Pendente|✅ Criado}} | `docs/development/PHASES/PHASE-XX/phase-board.md` |
| Sprint | {{⬜ Pendente|✅ Criado}} | `docs/development/SPRINTS/sprint-YY.md` |

---

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|------------|-------------------|
| REQ-01 | {{requisito}} | MUST | [critério] |
| REQ-02 | {{requisito}} | SHOULD | [critério] |
| REQ-03 | {{requisito}} | COULD | [critério] |

---

## Requisitos Não-Funcionais

| ID | Categoria | Métrica | Target |
|----|-----------|---------|--------|
| RNF-01 | Performance | Latência | <{{X}}ms |
| RNF-02 | Segurança | Auth | {{JWT/RBAC/etc}} |
| RNF-03 | Disponibilidade | Uptime | {{99.x%}} |

---

## Impacto

**Área de Impacto:**
- [Área 1]
- [Área 2]

**Arquivos/Áreas Afetadas:**
```
src/...
docs/...
tests/...
```

**Breaking Changes:**
- {{YES|NO}} — [Descrição se YES]

---

## Riscos

| Risco | Probabilidade | Impacto | Mitigação |
|-------|--------------|---------|-----------|
| [Risco 1] | {{Alta|Média|Baixa}} | {{Alto|Médio|Baixo}} | [Mitigação] |

---

## Critérios de Aceite

### Gate M-{{X}} (Spec)
- [ ] PRD criado
- [ ] HELL Spec criado
- [ ] Domain model completo
- [ ] GRASP assignments definidos

### Gate M-{{X}} (TDD)
- [ ] Tests escritos
- [ ] Coverage ≥80%
- [ ] Todos passing

### Gate M-{{X}} (Review)
- [ ] Code review aprovado
- [ ] No blocking findings
- [ ] Tech debt catalogado

### Gate M-{{X}} (Ship)
- [ ] Pipeline green
- [ ] Docs updated
- [ ] Changelog updated

---

## Status History

| Date | Status | Author | Notes |
|------|--------|--------|-------|
| {{YYYY-MM-DD}} | PROPOSED | {{agent}} | Gap identificado |
| {{YYYY-MM-DD}} | APPROVED | {{stakeholder}} | Aprovado |
| {{YYYY-MM-DD}} | IMPLEMENTED | {{agent}} | Feature completa |
| {{YYYY-MM-DD}} | SHIPPED | {{stakeholder}} | Em produção |

---

## Relacionamentos

**Especificações:**
- [SPEC-XXX](./SPEC-XXX.md) — {{relação}}
- [SPEC-YYY](./SPEC-YYY.md) — {{relação}}

**Tasks:**
- [TASK-XXX](./TASK-XXX.md) — {{relação}}
- [TASK-YYY](./TASK-YYY.md) — {{relação}}

**Propostas Relacionadas:**
- [PROPOSAL-XXX](./PROPOSAL-XXX.md) — {{relação}}

---

## Notas

[Notas adicionais, contexto, decisões técnicas]
