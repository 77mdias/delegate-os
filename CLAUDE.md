# Delegado OS — Agent Operating System

Este projeto contém o sistema Delegado OS.

## Meta-Prompting (Intelligence Layer)

**Consulte `META-PROMPTING.md` para a camada de inteligência.**

Princípios:
- **HELL é o centro** — Tudo converge para o HELL Method (GRASP/GoF + TDD)
- **CLI Agent é autônomo** — Sabe quando chamar comandos, skills, scripts automaticamente
- **Obsidian é o cérebro** — Memória persistente, graph-based, dashboards Dataview
- **Automação reativa** — Não espera ser perguntado, age baseado em contexto

## Comandos

```bash
./delegado.sh              # Menu interativo
./delegado.sh setup        # Setup inicial
./delegado.sh detectar     # Detectar stack
```

## Estrutura

```
delegate-os/
├── delegado.sh            # CLI principal
├── META-PROMPTING.md      # 🆕 Intelligence layer (AUTOMATION)
├── kernel/skills/         # Skills do sistema
├── kernel/hell/           # 🆕 HELL Core Engine (GRASP/GoF/TDD)
├── workflows/             # Workflows (BMAD, OpenSpec, GSD)
├── templates/hell/        # 🆕 HELL templates (spec, tdd, refactor, etc)
├── config.yaml           # Configuração
├── memory/                # Memória persistente
└── Obsidian/             # 🆕 Vault structure para integração
```

## Activation

Para ativar como skill no Claude Code:
1. O skill `delegado` está em `agent-os/skills/delegado/SKILL.md`
2. Invoke com `/delegado` ou `/agent-os`
