# 🚀 Getting Started — Delegado OS

> Guia rápido para instalar, configurar e começar a usar o Delegado OS.

---

## Pré-Requisitos

| Requisito | Versão Mínima |
|-----------|---------------|
| Node.js | 18+ |
| npm ou bun | 8+ / 1.0+ |
| Git | 2.30+ |
| Agent compatível | Claude Code, Codex, Cursor |

---

## Instalação

### Via npm (recomendado)

```bash
npm install -g @delegado/os-delegate
```

### Via Bun

```bash
bun install -g @delegado/os-delegate
```

### Verificação

```bash
delegado --version
# Output: delegado-os 1.0.0
```

O script `postinstall` detecta e vincula automaticamente a skill nos diretórios de Claude Code, Codex e Cursor.

---

## Primeiro Uso

### 1. Ativar no Agent

Dentro do Claude Code (ou agent compatível):

```
/delegado
```

Isso exibe o menu de comandos disponíveis.

### 2. Setup Inicial (CLI)

```bash
# Menu interativo
./delegado.sh menu

# Setup automático — detecta stack e configura memória
./delegado.sh setup

# Detectar stack do projeto atual
./delegado.sh detectar
```

### 3. Primeiro Workflow

**OpenSpec** — o fluxo mais direto:

```bash
# 1. Criar uma proposta de mudança
/dos-propose minha-feature

# 2. Detalhar especificações
/dos-specs

# 3. Criar design técnico
/dos-design

# 4. Gerar tarefas atômicas
/dos-tasks

# 5. Executar tarefas
/dos-apply

# 6. Verificar implementação
/dos-verify
```

**BMAD** — para projetos mais complexos:

```bash
/dos-bmad       # Visão geral do método
/dos-bmad 1     # Fase 1: Analysis
/dos-bmad 2     # Fase 2: Planning
/dos-bmad 3     # Fase 3: Solutioning
/dos-bmad 4     # Fase 4: Implementation
```

**HELL Method** — para projetos com alta exigência arquitetural:

```bash
/dos-hell:spec      # Especificação GRASP
/dos-hell:tdd       # Ciclo TDD
/dos-hell:refactor  # Refatoração GoF
/dos-hell:evolve    # CI/CD + debt
/dos-hell:review    # Review profundo
/dos-hell:milestone # Gate de qualidade
```

---

## Configuração

O arquivo `config.yaml` na raiz do projeto controla o comportamento:

```yaml
schema: spec-driven        # Workflow padrão

workflows:
  - id: especificacao
  - id: bmad
  - id: fase
  - id: hell-milestone     # HELL milestone gates

defaults:
  pr_size: medium
  coverage: 80
  tdd: true
```

---

## Estrutura de Diretórios

```
agent-os-delegate/
├── SKILL.md              ← Entry point (skill manifest)
├── SYSTEM.md             ← Visão geral do sistema
├── config.yaml           ← Configuração
├── delegado.sh           ← CLI executável
├── kernel/               ← Cérebro do sistema
│   ├── SISTEMA.md        ← Arquitetura técnica
│   ├── DELEGADO.md       ← Personalidade
│   ├── MEMORIA.md        ← Sistema de memória
│   └── hell/             ← HELL Method engine
├── skills/               ← Skills (SKILL.md each)
│   └── dos/              ← Delegado OS skills
│       ├── hell/         ← HELL sub-skills (9 skills)
│       ├── bmad/         ← BMAD workflow
│       ├── propose/      ← Change proposals
│       └── ...
├── workflows/            ← Workflow definitions
├── memory/               ← Memória persistente
├── templates/            ← Templates markdown
├── docs/                 ← 📍 Você está aqui
└── changes/              ← Propostas ativas
```

---

## Próximos Passos

| O que fazer | Documento |
|-------------|-----------|
| Entender a arquitetura | [architecture.md](architecture.md) |
| Ver todos os comandos | [commands.md](commands.md) |
| Aprender o HELL Method | [hell-method.md](hell-method.md) |
| Configurar Obsidian | [obsidian-integration.md](obsidian-integration.md) |
