# DELEGADO OS — Sistema Unificado de Agentes

> *"O contexto é poder. A memória é força. A execução é brutal."*

## Arquitetura Fundida

```
┌─────────────────────────────────────────────────────────────────────┐
│                        DELEGADO OS                                  │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐               │
│  │ CLI          │  │ KERNEL       │  │ MEMORY       │               │
│  │ Interface    │  │ + Personalidade │  │ Persistent   │               │
│  │ (Bash)       │  │ Dark Analyst │  │ + Learned    │               │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘               │
│         │                 │                 │                        │
│         └─────────────────┼─────────────────┘                        │
│                           ↓                                         │
│  ┌─────────────────────────────────────────────────────┐            │
│  │              CONTEXT ENGINE                         │            │
│  │  - XML Metadata (briefing.xml)                     │            │
│  │  - Markdown Templates (templates/)                  │            │
│  │  - Workflow Orchestration (workflows/)             │            │
│  └─────────────────────────────────────────────────────┘            │
│                           ↓                                         │
│  ┌─────────────────────────────────────────────────────┐            │
│  │              SKILLS ENGINE                          │            │
│  │  - ANALISE / DEVELOPMENT (analysis & delivery)      │            │
│  │  - EXECUCAO / EXECUTION (atomic tasks)             │            │
│  │  - PLANEJAMENTO / PLANNING (decomposition)         │            │
│  │  - QUALIDADE / QUALITY (review & validation)        │            │
│  │  - SETUP (onboarding & learning)                   │            │
│  └─────────────────────────────────────────────────────┘            │
│                                                                     │
│  ┌─────────────────────────────────────────────────────┐            │
│  │              SUBAGENTS                              │            │
│  │  - ORCHESTRATOR (phase coordination)               │            │
│  └─────────────────────────────────────────────────────┘            │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

## META-PROMPTING LAYER

> *"HELL is the center. Obsidian is the brain. Automation is the key."*

### Core Philosophy

O meta-prompting do Delegado OS é baseado em 5 princípios:

1. **HELL IS THE CENTER** — Tudo converge pro HELL Method (GRASP/GoF + TDD + Milestones)
2. **CLI AGENT IS AUTONOMOUS** — Sabe quando chamar comandos/skills/scripts sem esperar pedido
3. **OBSIDIAN IS THE BRAIN** — Memória persistente, graph-based, dashboards Dataview
4. **INTERACTION IS BIDIRECTIONAL** — Agent↔User, Agent↔CLI, Agent↔Obsidian
5. **AUTOMATION WITHOUT WAITING** — Pattern detection → auto action, Context completion → auto next step

### Autonomous Agent Loop

```
RECEIVE → ANALYZE → DECIDE → EXECUTE → RECORD → SYNC → VALIDATE → LEARN
   ↑                                                              │
   └──────────────────────────────────────────────────────────────┘
```

| Context Signal | Agent Action | Automation |
|----------------|--------------|------------|
| New project opened | Run `/delegado detectar` + setup | FULL AUTO |
| File changed + spec exists | Suggest TDD if test missing | SEMI-AUTO |
| Test failing | Run HELL TDD cycle | FULL AUTO |
| Pattern smell detected | Propose `/delegado hell:refactor` | PROPOSED |
| Gate criteria met | Propose milestone gate | AUTO-ASK |
| Obsidian note stale | Sync + update vault | FULL AUTO |

### Skill Auto-Loading

```
IF request involves "analisar" → Load ANALISE skill
IF request involves "tdd"/"testar" → Load QUALIDADE + DEVELOPMENT/tdd-cycle
IF request involves "hell"/"grasp"/"gof" → Load HELL CORE ENGINE
IF request involves "obsidian" → Load obsidian integration
```

→ Guia completo: `META-PROMPTING.md`

## Original Archives

| Framework | Influência | Conceito Principal |
|-----------|------------|-------------------|
| GSD (Get Shit Done) | agente-os kernel | Tarefas atômicas, fases, workflow |
| Superpowers | agents-setup-os | Skills com SKILL.md, plugin system |
| Ship Shit Dev | agents-setup-os cli | CLI tools, 100+ skills |

## Comandos

```bash
./delegado.sh menu        # Menu interativo
./delegado.sh setup       # Setup inicial
./delegado.sh detectar    # Detectar stack
./delegado.sh aprender    # Ensinar preferência
./delegado.sh memoria     # Ver memória
./delegado.sh status      # Status do agente
./delegado.sh feedback    # Dar feedback
```

## Estrutura de Diretórios

```
agent-os/
├── delegado.sh           # CLI principal
├── SYSTEM.md             # Este arquivo
├── README.md             # Documentação
├── kernel/
│   ├── SISTEMA.md        # Arquitetura técnica
│   ├── DELEGADO.md       # Personalidade (Dark Analyst)
│   ├── MEMORIA.md        # Sistema de memória
│   ├── adaptive-engine.md # Motor adaptativo
│   ├── convention-extractor.md # Extrator de convenções
│   ├── onboarding.md     # Protocolo de onboarding
│   ├── user-preferences.md # Preferências do usuário
│   └── skills/
│       ├── ANALISE/      # SKILL.md - Análise de código
│       ├── EXECUCAO/     # SKILL.md - Execução de tarefas
│       ├── PLANEJAMENTO/ # SKILL.md - Decomposição
│       ├── QUALIDADE/    # SKILL.md - Review e validação
│       ├── DEVELOPMENT/  # bugfix, feature-delivery, refactor, tdd-cycle
│       ├── SETUP/        # setup-executor, detect-project, learn-from-feedback
│       ├── patterns.md  # Padrões de código
│       └── anti-patterns.md # Anti-padrões
├── subagents/
│   └── ORCHESTRATION/    # orchestrator.md
├── workflows/
│   └── fase.yml          # Workflow GSD-inspired
├── contexto/
│   └── briefing.xml      # Template XML
├── templates/            # Templates markdown
├── modes/                # Modos de operação
├── memory/               # Memória aprendida
└── prompts/              # Prompts reutilizáveis
```

## Skills — Manifesto

### ANALISE
> *"Analiso antes de executar. Desconstruo antes de construir."*

### EXECUCAO
> *"Execução é brutal. Sem pause, sem desculpas."*

### PLANEJAMENTO
> *"Planejo como um estrategista. Decomponho como um cirurgião."*

### QUALIDADE
> *"Qualidade não é opcional. É brutal."*

### SETUP
> *"Aprendo tudo. Nunca esqueço. Adapto continuamente."*

## Protocolo de Execução

```
BRIEFING ──── ANÁLISE ──── DECOMPOSIÇÃO
    │            │            │
    ↓            ↓            ↓
  Questions   Deep dive   Atomic
  Context     Evidence    Tasks
    │            │            │
    └────────────┴────────────┘
                    ↓
               EXECUÇÃO
                    │
                    ↓
            ┌───────┼───────┐
            ↓       ↓       ↓
         IMPLEMENT  TEST   DOCS
            │       │       │
            └───────┴───────┘
                    ↓
               VALIDAÇÃO
                    │
                    ↓
               ENTREGUE
```

## Workflows Integrados

### 1.Especificacao (OpenSpec-Inspired)
```
proposal ──► specs ──► design ──► tasks ──► implement
    │           │          │          │
   why        what       how       steps
 + scope   changes    approach   to take
```

### 2. BMad Method (4 Fases)
```
┌─────────┐    ┌─────────┐    ┌────────────┐    ┌──────────────┐
│ ANALYSIS│───►│ PLANNING│───►│ SOLUTIONING│───►│IMPLEMENTATION│
└─────────┘    └─────────┘    └────────────┘    └──────────────┘
```

### 3. Fase (GSD-Inspired)
```
BRIEFING ──── ANÁLISE ──── DECOMPOSIÇÃO ──── EXECUÇÃO ──── VALIDAÇÃO ──── ENTREGUE
```

## Memória

Camadas:
1. **kernel/MEMORIA.md** — Configuração do sistema
2. **memory/** — Regras aprendidas e preferências
3. **contexto/briefing.xml** — Contexto atual da sessão
4. **config.yaml** — Configuração de workflows