---
name: dos-hell:review
description: "HELL Review — Deep codebase analysis, feature suggestions, new spec proposals, pattern compliance"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Review — Análise profunda do codebase com geração de insights:

- Avaliação de compliance GRASP/GoF
- Sugestão de novas features baseadas em padrões detectados
- Proposta de novas specs para gaps encontrados
- Health score do projeto
- Alimenta o próximo ciclo HELL Specification

"Review não é opcional. É o feedback loop que mantém o sistema vivo."
</objective>

<context>
## Review Dimensions

| Dimensão | O que Analisa | Output |
|----------|--------------|--------|
| **Architecture** | Camadas, dependências, acoplamento | Compliance score |
| **Patterns** | GRASP/GoF aplicados vs ausentes | Pattern map |
| **Coverage** | Testes existentes vs gaps | Coverage report |
| **Debt** | Smells, TODOs, hacks | Debt items |
| **Features** | Oportunidades de melhoria | Feature proposals |
| **Security** | Vulnerabilidades, auth gaps | Security findings |

## Review Types

- **full** — Análise completa (todas as dimensões)
- **patterns** — Apenas compliance GRASP/GoF
- **features** — Apenas sugestão de features
- **security** — Apenas análise de segurança
- **quick** — Health score rápido (2 min)
</context>

<process>
## 1. SCAN — Reconhecimento do Terreno

1. Detect project stack (language, framework, structure)
2. Map directory structure and dependency graph
3. Identify entry points, controllers, services, repositories
4. Count total files, LOC, test files

## 2. ANALYZE — Análise por Dimensão

### Architecture Analysis
- Verify layer separation (Presentation → Application → Domain → Infrastructure)
- Check dependency direction (outer depends on inner, NEVER reverse)
- Flag violations: UI importing infrastructure, domain importing framework
- Score: 0-100

### Pattern Analysis (GRASP/GoF)
- **Applied patterns:** List patterns detected in codebase
- **Missing patterns:** Where patterns SHOULD be but aren't:
  - Conditional chains without Strategy
  - Direct coupling without Indirection
  - Mixed responsibilities without Controller separation
  - Hardcoded dependencies without Protected Variations
- **Anti-patterns detected:**
  - God Class
  - Feature Envy
  - Shotgun Surgery
  - Inappropriate Intimacy

### Coverage Analysis
- Map tested vs untested modules
- Identify critical paths without tests
- Flag: business logic without assertions

### Feature Suggestion Engine
Based on detected patterns and gaps, suggest:
- **Missing capabilities** the codebase SHOULD have
- **Extension points** that patterns enable
- **Refactor opportunities** that unlock new features
- **Performance improvements** based on measured bottlenecks

### Security Scan
- Hardcoded secrets/keys
- Missing input validation
- Auth/authz gaps
- Dependency vulnerabilities

## 3. GENERATE — Deliverables

Generate `hell-review.md` in `changes/[proposal]/` (or project root if no proposal):

```markdown
---
Project: [[PROJECT]]
HELL_Phase: Review
Status: 🔥 ACTIVE
Review_Type: full
---

# HELL Review Report

## Health Score: [0-100] [🟢🟡🔴]

## Architecture Compliance
- Layer separation: [score]
- Dependency direction: [score]
- Violations: [list]

## Pattern Map
### Applied
| Pattern | Where | Quality |
### Missing
| Pattern | Where it Should Be | Impact |
### Anti-Patterns
| Anti-Pattern | Location | Severity |

## Coverage Gaps
| Module | Coverage | Critical? |

## Feature Suggestions
| ID | Feature | Based On | Priority | Effort |
| FS-01 | [suggestion] | [pattern/gap] | HIGH | M |

## New Spec Proposals
| ID | Spec Title | Motivation | Link |
| SP-01 | [title] | [why] | → /dos-propose [name] |

## Security Findings
| Severity | Finding | Location |

## Tech Debt Discovered
| ID | Severity | Description |

## Recommended Next Actions
1. [action] → `/dos-hell:[command]`
2. [action] → `/dos-hell:[command]`
3. [action] → `/dos-hell:[command]`
```

## 4. LINK — Feed Forward

- For each Feature Suggestion → Propose command: `/dos-propose [feature-name]`
- For each Spec Gap → Link to: `/dos-hell:spec`
- For each Debt Item → Add to: `memory/hell-tech-debt.md`
- For each Pattern Gap → Link to: `/dos-hell:refactor`
- Update milestone status if active: `/dos-hell:milestone`
</process>
