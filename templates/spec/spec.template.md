---
title: "[Nome da Especificação]"
type: spec
mode: specification
status: draft
version: 1.0.0
author: "{{author}}"
date: "{{date}}"
related-docs: ["proposal/{{proposal-link}}.md"]
based-on: "{{proposal-id}}"
---

# Especificação: [Nome]

## 1. Meta Information

| Campo | Valor |
| :--- | :--- |
| **Versão** | {{version}} |
| **Autor** | {{author}} |
| **Data** | {{date}} |
| **Status** | 🔵 Em Elaboração |
| **Proposta Base** | [Link] |

---

## 2. Visão Geral

[Descreva o que esta especificação cobre e seu propósito no contexto do projeto]

---

## 3. Design Detalhado

### 3.1 Arquitetura de Componentes

```
[Diagrama ASCII ou descrição estrutural]

Componente A → Componente B → Componente C
```

### 3.2 Interfaces e Contratos

#### Interface: [Nome]
```typescript
interface IExample {
  method(param: Type): ReturnType;
}
```

### 3.3 Fluxo de Dados

```
[Fluxo: Input → Processamento → Output]
```

### 3.4 Estados e Transições

| Estado | Descrição | Transições |
| :--- | :--- | :--- |
| [State A] | ... | A → B |
| [State B] | ... | B → C |

---

## 4. Requisitos Funcionais

### RF-01: [Título]
**Descrição:** [Descrição clara]
**Critério de Aceite:** [Testável]

### RF-02: [Título]
**Descrição:** [Descrição clara]
**Critério de Aceite:** [Testável]

---

## 5. Requisitos Não Funcionais

| Requisito | Meta | Verificação |
| :--- | :--- | :--- |
| Performance | < [X]ms | [Métrica] |
| Disponibilidade | [X]% | [Métrica] |
| Segurança | [Nível] | [Verificação] |

---

## 6. Mudanças (Changelog)

| Versão | Data | Autor | Mudanças |
| :--- | :--- | :--- | :--- |
| 0.1.0 | YYYY-MM-DD | autor | Criação inicial |
| 1.0.0 | YYYY-MM-DD | autor | [Mudança] |

---

## 7. Decisões de Design

| Decisão | Rationale | Alternativas Consideradas |
| :--- | :--- | :--- |
| [DEC-01] | [Por que] | [O que foi descartado] |

---

## 8. Anexos

- [Diagrama de API](link)
- [Wireframes/Mockups](link)
- [Referências](link)