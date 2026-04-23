# 🔧 Extending — Como Extender o Delegado OS

> Guia para adicionar novos skills, workflows e integrações.

---

## 1. Criar Novo Skill

### Estrutura

```bash
mkdir -p skills/dos/my-skill
```

### SKILL.md Template

```markdown
---
name: dos-my-skill
description: "What this skill does"
argument-hint: "[optional-args]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
Clear statement of what this skill achieves.
</objective>

<context>
Background information, tables, references.
</context>

<process>
1. Step one — what to do
2. Step two — what to do  
3. Step three — what to do
</process>
```

### Registrar no Router

Adicionar em `skills/dos/SKILL.md`:

1. Na tabela de comandos:
```markdown
| /dos-my-skill | Description |
```

2. No bloco `<process>`:
```markdown
- my-skill → /dos-my-skill
```

---

## 2. Criar Novo Workflow

### Estrutura

Criar em `workflows/my-workflow.yml`:

```yaml
---
name: my-workflow
description: Description of the workflow
version: 1.0.0

artifacts:
  - id: phase-1
    generates: artifact-1.md
    requires: []
  - id: phase-2
    generates: artifact-2.md
    requires: [phase-1]
---

# Workflow: My Workflow

## Flow
phase-1 → phase-2 → phase-3
```

### Registrar no Config

Adicionar em `config.yaml`:

```yaml
workflows:
  - id: my-workflow
    name: My Workflow
    description: What it does
```

---

## 3. Criar Sub-Skill (Skill com filhos)

Exemplo: criar `my-method` com sub-commands:

```
skills/dos/my-method/
├── SKILL.md            ← Router (/dos-my-method)
├── step1/SKILL.md      ← /dos-my-method:step1
├── step2/SKILL.md      ← /dos-my-method:step2
└── step3/SKILL.md      ← /dos-my-method:step3
```

O `SKILL.md` pai atua como router, direcionando para sub-skills.

---

## 4. Adicionar ao Kernel

Para modules de baixo nível (engine, personality, memory):

```
kernel/
├── my-engine.md        ← Novo engine
└── skills/
    └── MY-SKILL/
        └── SKILL.md    ← Kernel-level skill
```

---

## 5. Convenções

| Item | Convenção |
|------|-----------|
| Skill name | `dos-[name]` (lowercase, hyphenated) |
| Sub-skill | `dos-[parent]-[child]` |
| Workflow file | `workflows/[name].yml` |
| Artifact | `changes/[proposal]/[artifact].md` |
| Memory file | `memory/[name].md` |
| Kernel doc | `kernel/[name].md` or `kernel/[name]/` |

---

## 6. Checklist de Novo Skill

- [ ] `SKILL.md` criado com `name`, `description`, `objective`, `context`, `process`
- [ ] Registrado no router pai (`skills/dos/SKILL.md`)
- [ ] Registrado no manifest raiz (`SKILL.md`) se top-level
- [ ] Documentado em `docs/skills.md`
- [ ] Testado: comando funciona no agent
