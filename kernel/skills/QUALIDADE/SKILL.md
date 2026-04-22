---
name: qualidade
description: Code review e validação
category: CORE
trigger: >
  /review, /validar, /testar, quality, coverage,
  code review, critique, CHECK
priority: high
when_to_use: >
  Após implementação, antes de entregar.
version: 1.0.0
depends_on: [EXECUCAO]
---

# Skill: QUALIDADE

> *"Qualidade não é opcional. É brutal."*

## Checklist de Qualidade

### Código
- [ ] Nenhum console.log
- [ ] Nenhum any implícito
- [ ] Nomes descritivos
- [ ] Funções pequenas (< 40 linhas)

### Testes
- [ ] Testes cobrindo caminhos críticos
- [ ] Nenhum teste commented out
- [ ] Coverage > 80%

### Review
- [ ] Lint passando
- [ ] Type-check passando
- [ ] Build passando
- [ ] Tests passando

## Output

```markdown
## Quality Report

### Código
✅ Passou / ❌ Falhou

### Testes
✅ [x] unitários
✅ [x] integração

### Coverage
[métrica]%

### Issues
- [ ] CRÍTICO: [x]
- [ ] WARN: [y]
- [ ] INFO: [z]

### Veredito
✅ APROVADO / ❌ REPROVADO
```
