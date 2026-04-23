# 🧠 Sistema de Memória — Delegado OS

> *"Eu não peço perdão por lembrar. Memória é poder."*

---

## Arquitetura

```
┌─────────────────────────────────────────────────┐
│              CAMADAS DE MEMÓRIA                   │
├─────────────────────────────────────────────────┤
│                                                   │
│  Episódica (Session) — Conversa atual, volátil    │
│         ↓                                         │
│  Semântica (Projeto) — Stack, estrutura, config   │
│         ↓                                         │
│  Procedural (Regras) — Preferências aprendidas    │
│         ↓                                         │
│  Fonte (Arquivos) — .md persistentes              │
│                                                   │
└─────────────────────────────────────────────────┘
```

---

## Arquivos de Memória

```
memory/
├── PROJETO.md        # Stack, estrutura, configurações
├── CONVENIOS.md      # Convenções aprendidas (naming, imports)
├── REGRAS.md         # Regras e preferências do usuário
├── FEEDBACK.md       # Histórico de feedback
├── CONTEXTOS.md      # Contextos de projetos passados
├── APRENDIZADO.md    # Coisas aprendidas
└── hell-tech-debt.md # Tech debt backlog (HELL)
```

---

## Freshness

| Camada | Freshness | Atualização |
|--------|-----------|-------------|
| Projeto | Permanente | Raramente (mudança de stack) |
| Convenções | Semi-permanente | Quando convenções mudam |
| Regras | Evolutivo | Constantemente (feedback) |
| Feedback | Acumulativo | Nunca deletado |
| Tech Debt | Dinâmico | A cada review/audit |

---

## Comandos

| Comando | Função |
|---------|--------|
| `/dos-memory` | Ver memória atual |
| `/dos-learn [rule]` | Ensinar nova regra |
| `/dos-feedback [text]` | Registrar feedback |
| `/dos-context` | Carregar contexto do projeto |
| `/dos-hell:debt` | Tech debt backlog |

---

## Protocolo de Aprendizado

```
RECEBER → CLASSIFICAR → EXTRAIR → ARMAZENAR → INDEXAR → APLICAR
```

1. **Receber** — Feedback ou regra do usuário
2. **Classificar** — Tipo: preferência, regra, convenção, feedback
3. **Extrair** — Padrões e keywords
4. **Armazenar** — No arquivo correto em `memory/`
5. **Indexar** — Para busca rápida
6. **Aplicar** — Ajustar comportamento futuro
