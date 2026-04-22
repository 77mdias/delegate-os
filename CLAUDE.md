# Delegado OS — Agent Operating System

Este projeto contém o sistema Delegado OS.

## Comandos

```bash
./delegado.sh              # Menu interativo
./delegado.sh setup        # Setup inicial
./delegado.sh detectar     # Detectar stack
```

## Estrutura

```
agent-os/
├── delegado.sh            # CLI principal
├── kernel/skills/         # Skills do sistema
├── workflows/             # Workflows (BMAD, OpenSpec, GSD)
├── config.yaml           # Configuração
└── memory/                # Memória persistente
```

## Activation

Para ativar como skill no Claude Code:
1. O skill `delegado` está em `agent-os/skills/delegado/SKILL.md`
2. Invoke com `/delegado` ou `/agent-os`
