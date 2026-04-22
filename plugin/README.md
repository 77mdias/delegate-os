# Delegado OS — Plugin para Agentes CLI

Sistema operacional de agentes que integra **BMAD Method** + **OpenSpec** + **GSD workflows**.

## Instalação

### Claude Code

```bash
# Opção 1: Clone e link
git clone https://github.com/you/delegado-os.git ~/delegado-os
ln -s ~/delegado-os/skills/delegado ~/.claude/skills/delegado

# Opção 2: Copiar manualmente
cp -r delegado-os/skills/delegado ~/.claude/skills/
```

### Codex / Cursor

```bash
# Similar - copiar para ~/.codex/skills/ ou ~/.cursor/skills/
```

## Uso

```
/delegado              → Ativar menu
/delegado propose X    → Criar proposal (OpenSpec)
/delegado bmad         → Ativar BMad Method
/delegado analyze      → Executar análise
```

## Estrutura do Plugin

```
delegado-os/
├── skills/delegado/SKILL.md    # Skill principal
├── CLAUDE.md                   # Instruções para Claude
└── plugin/install/install.sh   # Instalador
```

## Skills Disponíveis

| Skill | Descrição |
|-------|-----------|
| `delegado` | Sistema principal |
| `especificacao` | Workflow OpenSpec |
| `bmad` | 4 fases BMAD |

## Integration

O `delegado` skill ativa automaticamente:
1. Context engine (XML metadata)
2. Skills engine (BMAD + OpenSpec)
3. Memory system (learned rules)

## Workflows

### OpenSpec
```
proposal → specs → design → tasks → implement
```

### BMAD
```
Analysis → Planning → Solutioning → Implementation
```
