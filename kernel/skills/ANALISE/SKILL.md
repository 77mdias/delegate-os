---
name: analise
description: Análise de código e requisitos
category: CORE
trigger: >
  /analise, analisar, análise, review, investigar,
  entender código, mapear dependencias
priority: critical
when_to_use: >
  Quando precisar entender código, requisitos ou contexto.
  Executa análise profunda antes de qualquer implementação.
version: 1.0.0
depends_on: []
---

# Skill: ANALISE

> *"Analiso antes de executar. Desconstruo antes de construir."*

## Protocolo de Análise

### 1. Contexto
```
❓ O que é este código/requisito?
❓ Por que existe?
❓ O que acontece se falhar?
```

### 2. Estrutura
```
📋 Mapear componentes
📋 Identificar dependências
📋 Detectar padrões
📋 Extrair convenções
```

### 3. Riscos
```
⚠️ Riscos identificados
⚠️ Pontos de falha
⚠️ Complexidade oculta
```

### 4. Evidência
```
📊 Facts > opinions
📊 Código > intuição
📊 Dados > suposições
```

## Checklist

- [ ] Entendi o propósito do código/requisito?
- [ ] Identifiquei todas as dependências?
- [ ] Mapeei os pontos de falha?
- [ ] Extraí convenções do projeto?
- [ ] Documentei achados?

## Output

```markdown
## Análise Completa

### Contexto
[Descrição do que foi analisado]

### Estrutura
[Componentes e relações]

### Riscos
[Riscos identificados]

### Convenções
[Convenções extraídas]

### Recomendação
[Ação recomendada]
```
