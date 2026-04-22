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

## Origens

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