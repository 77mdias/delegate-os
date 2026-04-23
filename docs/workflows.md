# 🔄 Workflows — Delegado OS

> Guia de todos os workflows de desenvolvimento disponíveis.

---

## Visão Geral

```
┌──────────────────────────────────────────────────────────────┐
│                    WORKFLOWS DISPONÍVEIS                      │
├──────────────────────────────────────────────────────────────┤
│                                                                │
│  OpenSpec     proposal → specs → design → tasks → implement  │
│  BMAD         ANALYSIS → PLANNING → SOLUTIONING → IMPLEMENT │
│  GSD          BRIEFING → ANÁLISE → DECOMP → EXEC → VALID    │
│  HELL         SPEC → TDD → REFACTOR → EVOLVE + MILESTONES   │
│                                                                │
└──────────────────────────────────────────────────────────────┘
```

---

## 1. OpenSpec (Spec-Driven)

**Quando usar:** Projetos com requisitos claros que precisam de especificação antes de implementação.

```
proposal ──► specs ──► design ──► tasks ──► implement
    │           │          │          │
   why        what       how       steps
 + scope   changes    approach   to take
```

### Comandos

```bash
/dos-propose minha-feature    # 1. Criar proposta
/dos-specs                    # 2. Detalhar specs
/dos-design                   # 3. Design técnico
/dos-tasks                    # 4. Gerar tasks
/dos-apply                    # 5. Executar tasks
/dos-verify                   # 6. Verificar
```

### Artefatos

| Fase | Artefato | Conteúdo |
|------|----------|----------|
| Proposta | `proposal.md` | Problema, scope, contexto, critérios de sucesso |
| Specs | `specs.md` | Funcionalidades, user stories, acceptance criteria |
| Design | `design.md` | Arquitetura, data models, API design |
| Tasks | `tasks.md` | Tarefas atômicas com IDs e estimates |
| Verificação | Report | Passed/failed criteria |

---

## 2. BMAD (4 Fases)

**Quando usar:** Projetos complexos que precisam de análise profunda antes de implementação.

```
┌─────────┐    ┌─────────┐    ┌────────────┐    ┌──────────────┐
│ ANALYSIS│───►│ PLANNING│───►│ SOLUTIONING│───►│IMPLEMENTATION│
└─────────┘    └─────────┘    └────────────┘    └──────────────┘
     │               │               │                  │
     ▼               ▼               ▼                  ▼
  proposta       PRD/specs       arquitetura         tasks/código
```

### Comandos

```bash
/dos-bmad         # Visão geral
/dos-bmad 1       # Fase 1: Analysis → proposal.md
/dos-bmad 2       # Fase 2: Planning → prd.md, specs.md
/dos-bmad 3       # Fase 3: Solutioning → architecture.md, design.md
/dos-bmad 4       # Fase 4: Implementation → tasks.md, código
/dos-bmad status  # Status de todas as fases
```

### Princípios

1. **Contexto progressivo** — cada fase informa a próxima
2. **Artefatos como contratos** — não implementar sem spec
3. **Decisões documentadas** — ADR para escolhas técnicas
4. **Validação contínua** — testar a cada bloco

---

## 3. GSD (Get Shit Done)

**Quando usar:** Tasks atômicas e execução rápida sem cerimônia.

```
BRIEFING ──── ANÁLISE ──── DECOMPOSIÇÃO ──── EXECUÇÃO ──── VALIDAÇÃO ──── ENTREGUE
```

### Fases

| Fase | O que Faz |
|------|----------|
| Briefing | Entender a tarefa (4 perguntas-chave) |
| Análise | Identificar stack, mapear dependências, identificar riscos |
| Decomposição | Quebrar em tarefas atômicas testáveis |
| Execução | Implementar sequencialmente |
| Validação | Testes, review, coverage |
| Entrega | CHANGELOG, docs, memória |

---

## 4. 💀 HELL Method

**Quando usar:** Projetos com alta exigência arquitetural, compliance GRASP/GoF, TDD obrigatório.

```
SPEC ──► [M-SPEC] ──► TDD ──► [M-TEST] ──► REFACTOR ──► [M-QUALITY] ──► EVOLVE ──► [M-SHIP]
                                                                                        │
                                                                                    REVIEW
                                                                                        │
                                                                                   [M-REVIEW]
```

### Fases

| Fase | Comando | Gate |
|------|---------|------|
| Specification | `/dos-hell:spec` | M-SPEC: Requisitos completos, domínio modelado |
| TDD Cycle | `/dos-hell:tdd` | M-TEST: Coverage ≥80%, zero failures |
| Refactor | `/dos-hell:refactor` | M-QUALITY: Audit ≥70%, no critical smells |
| Evolution | `/dos-hell:evolve` | M-SHIP: Pipeline green, docs synced |
| Review | `/dos-hell:review` | M-REVIEW: Score ≥60, no blockers |

### Milestone Gates

Gates são checkpoints obrigatórios que bloqueiam progresso:

| Verdict | Condição | Ação |
|---------|----------|------|
| ✅ PASSED | Score ≥90% + zero critical | Prosseguir |
| ⚠️ CONDITIONAL | Score ≥70% + zero critical | Prosseguir com action items |
| ❌ BLOCKED | Score <70% ou critical failure | NÃO prosseguir. Fix and re-run. |

→ Guia completo: [hell-method.md](hell-method.md)

---

## Combinando Workflows

Os workflows podem ser combinados. Exemplo de projeto completo:

```
1. /dos-propose auth-system            # OpenSpec: proposta
2. /dos-specs                           # OpenSpec: specs
3. /dos-hell:spec                       # HELL: GRASP analysis
4. /dos-hell:milestone spec             # HELL: gate check
5. /dos-design                          # OpenSpec: design
6. /dos-hell:tdd                        # HELL: TDD cycles
7. /dos-hell:milestone test             # HELL: gate check
8. /dos-tasks                           # OpenSpec: tasks
9. /dos-apply                           # OpenSpec: execute
10. /dos-hell:refactor                  # HELL: GoF patterns
11. /dos-hell:milestone quality         # HELL: gate check
12. /dos-verify                         # OpenSpec: verify
13. /dos-hell:review                    # HELL: deep review
14. /dos-hell:milestone ship            # HELL: final gate
```
