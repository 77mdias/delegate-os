# Delegado OS

> *"O contexto é poder. A memória é força. A execução é brutal."*

**AI Agent Operating System** — Meta-prompting framework para desenvolvimento de software assistido por IA, integrando workflows metodológicos (BMAD, OpenSpec, GSD, HELL) com memória persistente e contexto de engenharia.

---

## Supported Agents

| Agent       | Status | Installation                           |
|-------------|--------|----------------------------------------|
| Claude Code |   ✅   | `npm install -g @delegado/os-delegate` |
| Codex       |   ✅   | `npm install -g @delegado/os-delegate` |
| Cursor      |   ✅   | `npm install -g @delegado/os-delegate` |
| Bun         |   ✅   | `bun install @delegado/os-delegate`    |

---

## Workflows

### BMAD — 4-Fase Method

```
┌──────────┐    ┌──────────┐    ┌─────────────┐    ┌──────────────┐
│ ANALYSIS │───►│ PLANNING │───►│ SOLUTIONING  │───►│IMPLEMENTATION│
│  #FF6B6B │    │  #4ECDC4 │    │   #45B7D1   │    │   #96CEB4    │
└──────────┘    └──────────┘    └─────────────┘    └──────────────┘
```

| Fase | Artefatos | Propósito |
|------|-----------|-----------|
| ANALYSIS | `proposal.md` | Descoberta de contexto e scoping |
| PLANNING | `prd.md`, `specs.md` | Requisitos e especificação |
| SOLUTIONING | `architecture.md` | Design técnico |
| IMPLEMENTATION | `tasks.md`, código | Execução e entrega |

### OpenSpec — Spec-Driven

```
proposal ──► specs ──► design ──► tasks ──► implement
```

### GSD — Get Shit Done

```
BRIEFING ──── ANÁLISE ──── DECOMPOSIÇÃO ──── EXECUÇÃO ──── VALIDAÇÃO
```

### HELL — GRASP/GoF + TDD

```
SPEC ──► TDD ──► REFACTOR ──► EVOLVE
  │        │          │           │
 Gate    Gate       Gate        Gate
 REQ     TEST      AUDIT      DEPLOY
```

---

## HELL Method Commands

> *"Alta Coesão. Baixo Acoplamento. Sem piedade."*

| Comando | Função |
|---------|--------|
| `/dos-hell:spec` | Especificação GRASP + domain model |
| `/dos-hell:tdd` | Ciclo Red/Green/Refactor |
| `/dos-hell:refactor` | GoF refactoring + smell detection |
| `/dos-hell:evolve` | CI/CD + tech debt tracking |
| `/dos-hell:review` | Review + sugestão de features/specs |
| `/dos-hell:audit` | Auditoria GRASP/GoF compliance |
| `/dos-hell:milestone` | Gate de checkpoint |
| `/dos-hell:debt` | Tech debt backlog |
| `/dos-hell:status` | Dashboard do ciclo |

---

## Obsidian Integration

Sistema completo de **memória persistente do agente** integrado com Obsidian Vault:

```
┌─────────────────────────────────────────────────────────────┐
│                  HELL OBSIDIAN AGENT                         │
├─────────────────────────────────────────────────────────────┤
│  dos-hell:obsidian-memory  │  dos-hell:obsidian-notes       │
│  dos-hell:obsidian-tasks   │  dos-hell:obsidian-search       │
│  dos-hell:obsidian-graph   │  dos-hell:obsidian-sync         │
│  dos-hell:obsidian-init    │                                │
└─────────────────────────────────────────────────────────────┘
```

### Obsidian Sub-Skills

| Skill | Função |
|-------|--------|
| `dos-hell:obsidian-memory` | Memórias persistentes do agente |
| `dos-hell:obsidian-notes` | CRUD de notas com templates |
| `dos-hell:obsidian-tasks` | Gestão de tarefas via checklist |
| `dos-hell:obsidian-search` | Busca full-text e queries graph |
| `dos-hell:obsidian-graph` | Analytics do vault, orphans |
| `dos-hell:obsidian-sync` | Sincronização contexto ↔ vault |
| `dos-hell:obsidian-init` | Criar vault HELL completo |

### Criar Vault HELL

```bash
~/.claude/skills/dos-hell/obsidian-init/scripts/create-vault.sh HELL-Vault ~/Obsidian
```

**Estrutura do vault:**
- `00-INBOX/` — Notas não processadas
- `01-PROJECTS/` — Projetos (specs/, tdd/, refactor/, decisions/, debt/)
- `02-PATTERNS/` — Catálogo GRASP + GoF
- `03-DASHBOARDS/` — Dataview dashboards + HELL-Dashboard.base
- `04-TEMPLATES/` — Templater templates (Spec, TDD, ADR, Debt, Daily, Refactor)
- `05-ARCHIVE/` — Notas arquivadas

---

## DOS Commands

### Workflows

| Comando | Descrição |
|---------|-----------|
| `/dos bmad` | BMAD 4-phase method |
| `/dos propose [nome]` | Criar change proposal |
| `/dos specs` | Criar/editar especificações |
| `/dos design` | Criar design técnico |
| `/dos tasks` | Gerar tarefas atômicas |
| `/dos apply` | Executar tarefas pendentes |
| `/dos verify` | Verificar implementação |

### Context & Memory

| Comando | Descrição |
|---------|-----------|
| `/dos context` | Carregar contexto atual |
| `/dos memory` | Ver memória atual |
| `/dos learn [regra]` | Ensinar nova regra |
| `/dos feedback [texto]` | Registrar feedback |

### Help

| Comando | Descrição |
|---------|-----------|
| `/dos help` | Help geral |
| `/dos-hell` | HELL Method help |
| `/delegado` | Comandos do sistema |

---

## Installation

### Via npm (recomendado)

```bash
npm install -g @delegado/os-delegate
```

O script `postinstall` detecta e linka automaticamente para Claude Code, Codex e Cursor.

### Via Bun

```bash
bun install -g @delegado/os-delegate
```

### Verificação

```bash
delegado --version
# Output: delegado-os 1.1.1
```

### Ativação

```
/delegado          # Menu interativo
/delegado bmad     # Ativar BMAD
/delegado hell     # HELL Method
/delegado obsidian # Obsidian integration
```

---

## Estrutura de Diretórios

```
delegado-os/
├── SKILL.md                    # Entry point para agents
├── CLAUDE.md                   # Instruções Claude Code
├── SYSTEM.md                   # Arquitetura + manifesto
├── README.md                   # Este arquivo
├── delegado.sh                 # CLI principal
├── config.yaml                 # Configuração de workflows
├── kernel/                     # Core system (personalidade, memória)
├── skills/
│   ├── delegado/              # Entry skill
│   └── dos/                   # Command tree
│       ├── hell/              # HELL Method
│       │   ├── obsidian/      # Obsidian integration hub
│       │   ├── obsidian-memory/
│       │   ├── obsidian-notes/
│       │   ├── obsidian-tasks/
│       │   ├── obsidian-search/
│       │   ├── obsidian-graph/
│       │   ├── obsidian-sync/
│       │   └── obsidian-init/
│       └── [bmad, propose, specs, ...]
├── workflows/                 # BMAD, OpenSpec, GSD, HELL
├── subagents/                 # Orchestrator
├── memory/                    # Memória aprendida
├── docs/                      # Documentation
└── scripts/
    └── postinstall.js         # Auto-link installer
```

---

## Configuration

O sistema procura configuração em `.delegado/config.yaml`:

```yaml
schema: spec-driven
workflows:
  - id: especificacao
  - id: bmad
  - id: fase
defaults:
  pr_size: medium
  coverage: 80
  tdd: true
```

---

## CLI

```bash
# Interactive menu
delegado

# Show version
delegado --version

# Initial setup
delegado setup

# Detect stack
delegado detectar
```

---

## Frameworks de Origem

| Framework | Influência | Conceito Principal |
|-----------|------------|-------------------|
| GSD | agente-os kernel | Tarefas atômicas, fases, workflow |
| Superpowers | agents-setup-os | Skills com SKILL.md, plugin system |
| Ship Shit Dev | agents-setup-os cli | CLI tools, 100+ skills |
| HELL Method | GRASP/GoF + TDD | High cohesion, low coupling |

---

## License

MIT