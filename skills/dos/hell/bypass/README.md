# 🤖 HELL Bypass — Agente Autônomo v2.0

**Versão:** 2.0.0
**Status:** 🟢 ATIVO
**Princípio:** "Execute. Adapte. Evolua. Documente."

---

## 🎯 O que é?

O **HELL Bypass** é um agente autônomo que trabalha **sem supervisão constante**, utilizando todas as skills, MCPs, plugins, scripts e ferramentas disponíveis no ambiente.

## 🚀 Uso

```bash
/dos-hell:bypass <tarefa em linguagem natural>
```

Exemplos:
```
/dos-hell:bypass Criar phase board para nova feature
/dos-hell:bypass Implementar autenticação JWT completa
/dos-hell:bypass Fazer code review do módulo de payments
```

---

## 📁 Estrutura

```
skills/dos/hell/bypass/
├── SKILL.md                    # Skill principal (este arquivo)
├── README.md                   # Esta documentação
├── scripts/
│   ├── discover.sh            # Descobre todos os recursos
│   ├── checkpoint.sh          # Cria/gerencia checkpoints
│   ├── git-safe.sh            # Wrapper seguro para git
│   ├── docs-validate.sh       # Valida consistência de docs
│   └── skill-invoke.sh        # Helper para invocar skills
├── hooks/
│   ├── pre-execute.sh         # Hook pré-execução
│   ├── post-execute.sh        # Hook pós-execução
│   └── on-error.sh            # Hook de erro
├── memory/
│   ├── active-context.md      # Contexto atual
│   └── learned-patterns.md     # Padrões aprendidos
└── config/
    └── agent.yaml             # Configurações do agente
```

---

## 🔍 Recursos Disponíveis

### Skills HELL
| Skill | Propósito |
|-------|-----------|
| `phase_board` | Boards de fase detalhados |
| `spec` | Especificações técnicas |
| `tdd` | Test-driven development |
| `review` | Code review |
| `audit` | Auditoria de código |
| `refactor` | Refatoração |
| `debt` | Technical debt |
| `milestone` | Milestones |
| `brainstorm` | Brainstorming |
| `obsidian-*` | Integração Obsidian |

### Superpowers
- `brainstorming`, `executing-plans`, `test-driven-development`
- `code-review`, `writing-plans`, `verification-before-completion`

### GSD
- `gsd-plan-phase`, `gsd-execute-phase`, `gsd-verify-phase`
- `gsd-add-todo`, `gsd-add-phase`, `gsd-add-tests`

### MCPs
| MCP | Uso |
|-----|-----|
| Context7 | Documentação de libraries |
| Pencil | Design .pen files |
| Serena | Code intelligence |
| Playwright | Browser automation |
| Figma | Figma integration |

---

## 🛡️ Sistema de Segurança

### Checkpoints
```bash
./scripts/checkpoint.sh create    # Criar checkpoint
./scripts/checkpoint.sh list      # Listar checkpoints
./scripts/checkpoint.sh restore   # Restaurar último
./scripts/checkpoint.sh diff      # Ver diff desde checkpoint
```

### Git Safe
```bash
./scripts/git-safe.sh <comando>   # Wrapper seguro
# Exemplo:
./scripts/git-safe.sh push --force origin main  # Pedirá confirmação
```

### Validação de Docs
```bash
./scripts/docs-validate.sh        # Valida consistência
```

---

## 🧠 Memória do Agente

### Contexto Ativo
`memory/active-context.md` mantém o estado atual do agente.

### Padrões Aprendidos
`memory/learned-patterns.md` registra padrões de execução.

---

## ⚙️ Configuração

Edite `config/agent.yaml` para personalizar:

```yaml
agent:
  mode: "autonomous"  # autonomous | supervised | safe-mode

safety:
  enable-checkpoints: true
  enable-rollback: true

reporting:
  report-progress: true
  report-interval: 5  # minutos
```

---

## 📋 Fluxo de Execução

```
BOOTSTRAP → ANÁLISE → PLANEJAMENTO → EXECUÇÃO → VALIDAÇÃO
    ↓           ↓            ↓            ↓           ↓
 Carrega     Decompõe     Seleciona    Executa     Verifica
 memória     tarefa       abordagem    tasks       resultados
```

---

## 🎯 Regras de Ouro

1. **Execute primeiro** — Não pare para planejar demais
2. **Use skills** — Sempre procure skill antes de fazer manual
3. **Checkpoint** — Antes de operações perigosas
4. **Documente tudo** — Atualize boards, changelogs, specs
5. **Se blocker → pivote** — Encontre alternativa
6. **Subagentes são bons** — Não tenha medo de criar

---

## 🚫 Proibições

- ❌ Parar sem entregar resultado
- ❌ Operações destrutivas sem checkpoint
- ❌ Ignorar skills disponíveis
- ❌ Deixar docs desatualizados
- ❌ Ficar travado sem pedir help

---

## 🆘 Troubleshooting

### Agente Travado
1. Liste skills: `./scripts/skill-invoke.sh list`
2. Valide docs: `./scripts/docs-validate.sh`
3. Use checkpoint: `./scripts/checkpoint.sh restore`
4. reporte blocker

### Skill Não Funciona
1. Verifique se existe: `./scripts/skill-invoke.sh list`
2. Read skill file diretamente
3. Fallback: faça manualmente

### MCP Erro
1. Use Context7 → WebSearch como fallback
2. Use Pencil → Read direto

---

## 📜 Scripts

| Script | Função |
|--------|--------|
| `discover.sh` | Lista todos os recursos |
| `checkpoint.sh` | Checkpoints de segurança |
| `git-safe.sh` | Git com confirmações |
| `docs-validate.sh` | Valida documentação |
| `skill-invoke.sh` | Invoca skill manual |

---

**HELL Bypass v2.0** — Autonomia com segurança.
