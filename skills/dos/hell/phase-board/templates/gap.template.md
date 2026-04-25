---
title: "GAP-{{XXX}}: {{descrição}}"
type: gap
severity: {{🟢|🔵|🟡|🔴}}
status: {{OPEN|PROPOSED|IMPLEMENTED|WONTFIX}}
date: {{YYYY-MM-DD}}
analyst: "{{agent/user}}"
related-phases: [PHASE-XX]
related-specs: [SPEC-XXX]
---

# GAP-{{XXX}}: {{Título do Gap}}

**ID:** GAP-{{XXX}}
**Severidade:** {{🟢 MINOR|🔵 INFO|🟡 MAJOR|🔴 CRITICAL}}
**Status:** {{OPEN|PROPOSED|IMPLEMENTED|WONTFIX}}
**Data de Identificação:** {{YYYY-MM-DD}}
**Analista:** {{agent/user}}
**Fases Relacionadas:** {{PHASE-XX}}
**Specs Relacionadas:** {{SPEC-XXX}}

---

## Descrição

[Descrição clara e objetiva do gap]

## Impacto

**No Produto:**
[Impacto no produto final, usuário ou cliente]

**No Sistema:**
[Impacto técnico - performance, segurança, manutenibilidade]

**No Negócio:**
[Impacto no negócio, se aplicável]

---

## Evidência

**Localização:**
- `src/...` (código)
- `docs/...` (documentação)
- Fluxo: [descrição do fluxo afetado]

**Código/Fluxo Identificado:**
```markdown
[Trecho de código ou descrição do fluxo onde o gap foi identificado]
```

**Testes Relacionados:**
- [Teste 1] — Status: {{Passing|Failing|Missing}}

---

## Análise

### Causa Raiz
[Análise da causa raiz do gap]

### Riscos Associados
| Risco | Probabilidade | Impacto | Mitigação |
|-------|--------------|---------|-----------|
| [Risco 1] | {{Alta|Média|Baixa}} | {{Alto|Médio|Baixo}} | [Mitigação] |

---

## Proposta de Solução

### Solução Proposta
[Descrição da solução recomendada]

### Template Sugerido
- [ ] PRD: `templates/prd/prd.template.md`
- [ ] HELL Spec: `templates/hell/hell-spec.template.md`
- [ ] Phase Board: `templates/tasks/phase-board.template.md`

### Estimativa de Esforço
{{XS|S|M|L|XL|XXL}} ({{1h|4h|1d|2d|1w|2w}})

---

## Feature Associada

| Field | Value |
|-------|-------|
| ID | FEATURE-{{YYY}} |
| Título | {{título da feature}} |
| Status | {{PROPOSED|APPROVED|REJECTED|IMPLEMENTED}} |
| Phase Alvo | {{PHASE-XX}} |
| Template | [feature-YYY.md](./feature-YYY.md) |

---

## Status History

| Date | Status | Analyst | Notes |
|------|--------|---------|-------|
| {{YYYY-MM-DD}} | OPEN | {{agent}} | Identificado |
| {{YYYY-MM-DD}} | PROPOSED | {{agent}} | Feature criada |
| {{YYYY-MM-DD}} | APPROVED | {{stakeholder}} | Aprovado para sprint |
| {{YYYY-MM-DD}} | IMPLEMENTED | {{agent}} | Implementado |

---

## Critérios de Resolução

- [ ] Feature FEATURE-{{YYY}} implementada
- [ ] Tests adicionados
- [ ] Documentação atualizada
- [ ] Code review aprovado
- [ ] Gate M-{{X}} aprovado

---

## Notas

[Notas adicionais, observações, contexto]
