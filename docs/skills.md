# 🧩 Skills — Catálogo Delegado OS

> Cada skill é um módulo autocontido com SKILL.md.

---

## Estrutura de um Skill

Todo skill segue o formato:

```markdown
---
name: skill-name
description: "What this skill does"
argument-hint: "[args]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
What this skill achieves.
</objective>

<context>
Background information, tables, references.
</context>

<process>
Step-by-step execution process.
</process>
```

---

## Skills Tree

```
skills/
└── dos/
    ├── SKILL.md           → /dos (router)
    ├── help/SKILL.md      → /dos-help
    ├── bmad/SKILL.md      → /dos-bmad
    ├── propose/SKILL.md   → /dos-propose
    ├── specs/SKILL.md     → /dos-specs
    ├── design/SKILL.md    → /dos-design
    ├── tasks/SKILL.md     → /dos-tasks
    ├── apply/SKILL.md     → /dos-apply
    ├── verify/SKILL.md    → /dos-verify
    ├── context/SKILL.md   → /dos-context
    ├── memory/SKILL.md    → /dos-memory
    ├── learn/SKILL.md     → /dos-learn
    ├── feedback/SKILL.md  → /dos-feedback
    └── hell/              → 💀 HELL Method
        ├── SKILL.md       → /dos-hell (router)
        ├── spec/SKILL.md  → /dos-hell:spec
        ├── tdd/SKILL.md   → /dos-hell:tdd
        ├── refactor/SKILL.md → /dos-hell:refactor
        ├── evolve/SKILL.md   → /dos-hell:evolve
        ├── review/SKILL.md   → /dos-hell:review
        ├── audit/SKILL.md    → /dos-hell:audit
        ├── milestone/SKILL.md → /dos-hell:milestone
        ├── debt/SKILL.md     → /dos-hell:debt
        └── status/SKILL.md   → /dos-hell:status
```

---

## Catálogo por Categoria

### Workflow Skills

| Skill | Comando | Artefato |
|-------|---------|----------|
| **bmad** | `/dos-bmad [1\|2\|3\|4]` | proposal.md, prd.md, specs.md, architecture.md, tasks.md |
| **propose** | `/dos-propose [name]` | `changes/[name]/proposal.md` |
| **specs** | `/dos-specs` | `specs.md` |
| **design** | `/dos-design` | `design.md`, `architecture.md` |
| **tasks** | `/dos-tasks` | `tasks.md` |
| **apply** | `/dos-apply` | (updates tasks.md status) |
| **verify** | `/dos-verify` | Verification report |

### Context & Memory Skills

| Skill | Comando | Função |
|-------|---------|--------|
| **context** | `/dos-context` | Carregar contexto XML do projeto |
| **memory** | `/dos-memory` | Exibir memória persistente |
| **learn** | `/dos-learn [rule]` | Ensinar nova regra/preferência |
| **feedback** | `/dos-feedback [text]` | Registrar feedback |

### 💀 HELL Method Skills

| Skill | Comando | Função |
|-------|---------|--------|
| **hell** | `/dos-hell` | Router + help |
| **hell:spec** | `/dos-hell:spec` | Especificação GRASP + domain model |
| **hell:tdd** | `/dos-hell:tdd` | TDD Red/Green/Refactor |
| **hell:refactor** | `/dos-hell:refactor` | Smell detection + GoF patterns |
| **hell:evolve** | `/dos-hell:evolve` | CI/CD + tech debt + doc sync |
| **hell:review** | `/dos-hell:review` | Deep review + feature suggestions |
| **hell:audit** | `/dos-hell:audit` | GRASP/GoF/SOLID compliance audit |
| **hell:milestone** | `/dos-hell:milestone` | Workflow checkpoint gate |
| **hell:debt** | `/dos-hell:debt` | Tech debt backlog |
| **hell:status** | `/dos-hell:status` | Cycle status dashboard |

### Kernel Skills

| Skill | Localização | Função |
|-------|------------|--------|
| ANALISE | `kernel/skills/ANALISE/` | Análise profunda de código |
| EXECUCAO | `kernel/skills/EXECUCAO/` | Execução de tarefas atômicas |
| PLANEJAMENTO | `kernel/skills/PLANEJAMENTO/` | Decomposição e planejamento |
| QUALIDADE | `kernel/skills/QUALIDADE/` | Review e validação |
| SETUP | `kernel/skills/SETUP/` | Onboarding e detecção |
| DEVELOPMENT | `kernel/skills/DEVELOPMENT/` | Bugfix, feature, refactor, TDD |

---

## Criando um Novo Skill

```bash
# 1. Criar diretório
mkdir skills/dos/my-skill

# 2. Criar SKILL.md
cat > skills/dos/my-skill/SKILL.md << 'EOF'
---
name: dos-my-skill
description: "What this skill does"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
What this skill achieves.
</objective>

<context>
Background info.
</context>

<process>
1. Step one
2. Step two
3. Step three
</process>
EOF

# 3. Registrar no router (skills/dos/SKILL.md)
# Adicionar na tabela de comandos e no bloco <process>
```

→ Guia completo: [extending.md](extending.md)
