# Sistema Operacional — Delegado das Trevas

> *"O Delegado não é um agent. É um sistema operacional para agents."*

---

## Arquitetura Geral

```
┌─────────────────────────────────────────────────────────────────┐
│                    AGENT OS - DELEGADO                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │    CLI       │  │   KERNEL    │  │   MEMORY    │         │
│  │  Interface   │  │   Engine     │  │   System     │         │
│  │  Terminal   │  │  + Personality│  │  Persistent  │         │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘         │
│         │                 │                 │                  │
│         └─────────────────┼─────────────────┘                  │
│                           ↓                                    │
│  ┌─────────────────────────────────────────────────────┐      │
│  │              CONTEXT ENGINE                          │      │
│  │  - XML Metadata                                     │      │
│  │  - Markdown Templates                                │      │
│  │  - Workflow Orchestration                            │      │
│  └─────────────────────────────────────────────────────┘      │
│                           ↓                                    │
│  ┌─────────────────────────────────────────────────────┐      │
│  │              SKILLS ENGINE                           │      │
│  │  - ANALISE (Analysis)                               │      │
│  │  - EXECUCAO (Execution)                             │      │
│  │  - PLANEJAMENTO (Planning)                         │      │
│  │  - QUALIDADE (Quality)                              │      │
│  └─────────────────────────────────────────────────────┘      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Componentes

### 1. CLI Interface

```bash
delegado.sh [comando]

# Menu interativo
delegado.sh menu

# Setup
delegado.sh setup

# Detectar stack
delegado.sh detectar

# Aprender
delegado.sh aprender "preferência"

# Ver memória
delegado.sh memoria
```

### 2. Kernel Engine

O cérebro do sistema:

```
┌────────────────────────────────────────────────────────┐
│                    KERNEL                               │
├────────────────────────────────────────────────────────┤
│                                                         │
│  PERSONALIDADE (DELEGADO.md)                           │
│  - Tom de voz                                          │
│  - Regras de comunicação                               │
│  - Manifesto                                           │
│                                                         │
│  CONTEXT ENGINE                                        │
│  - Gera XML de contexto                               │
│  - Extrai informação de markdown                       │
│  - Orquestra workflows                                │
│                                                         │
│  LEARNING LOOP                                        │
│  - Captura feedback                                   │
│  - Atualiza memória                                   │
│  - Adapta comportamento                               │
│                                                         │
└────────────────────────────────────────────────────────┘
```

### 3. Memory System

Camadas persistentes:

```typescript
interface MemoryLayers {
  episodic: string[];    // Conversa atual
  semantic: ProjectInfo; // Info do projeto
  procedural: Rule[];    // Regras aprendidas
  source: FileSystem;    // Arquivos .md
}
```

### 4. Skills Engine

Skills especializados:

```
skills/
├── ANALISE/        # Análise de código, requisitos
├── EXECUCAO/       # Execução de tarefas
├── PLANEJAMENTO/   # Decomposição, roadmap
└── QUALIDADE/      # Review, testes, validação
```

---

## Workflow Engine (GSD-Inspired)

### Estrutura de Fase

```xml
<fase id="1">
  <nome>Briefing</nome>
  <objetivo>Entender completamente a tarefa</objetivo>
  <tarefas>
    <tarefa>
      <nome>Questionar contexto</nome>
      <tipo>atomic</tipo>
      <estado>pending</estado>
    </tarefa>
  </tarefas>
</fase>
```

### Fluxo Principal

```
BRIEFING ──────► ANÁLISE ──────► DECOMPOSIÇÃO
    │               │               │
    ↓               ↓               ↓
  Questions      Deep dive      Atomic
  Context       Evidence       Tasks
    │               │               │
    └───────────────┴───────────────┘
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

---

## Contexto XML

### Template Principal

```xml
<?xml version="1.0" encoding="UTF-8"?>
<delegado_context version="1.0">

  <metadata>
    <generated>2024-01-15T10:30:00Z</generated>
    <mode>dark_analyst</mode>
    <language>pt-BR</language>
  </metadata>

  <project>
    <name><![CDATA[project-name]]></name>
    <stack>
      <language><![CDATA[typescript]]></language>
      <framework><![CDATA[nextjs]]></framework>
      <orm><![CDATA[prisma]]></orm>
    </stack>
    <structure>
      <src>/src</src>
      <tests>/tests</tests>
    </structure>
    <conventions>
      <naming>
        <components>PascalCase</components>
        <utils>camelCase</utils>
      </naming>
    </conventions>
  </project>

  <user>
    <name><![CDATA[user-name]]></name>
    <preferences>
      <pr_size>small</pr_size>
      <tdd>true</tdd>
      <coverage>80</coverage>
    </preferences>
    <learned_rules>
      <rule id="1">PRs &lt; 300 lines</rule>
      <rule id="2">Always TDD</rule>
    </learned_rules>
  </user>

  <task>
    <type>feature</type>
    <scope>backend</scope>
    <description><![CDATA[task description]]></description>
    <complexity>medium</complexity>
    <deadline><![CDATA[2024-01-20]]></deadline>
  </task>

  <session>
    <id>session-uuid</id>
    <context_summary>summary of current context</context_summary>
    <active_files>
      <file>src/server/auth.ts</file>
    </active_files>
  </session>

</delegado_context>
```

---

## Skills — Manifesto

### ANALISE

> *"Analiso antes de executar. Desconstruo antes de construir."*

```markdown
## ANALISE
- Análise de requisitos
- Análise de código
- Análise de risco
- Análise de contexto
```

### EXECUCAO

> *"Execução é brutal. Sem pause, sem desculpas."*

```markdown
## EXECUCAO
- Implementação atômica
- Tarefas sequenciais
- Sem task paralysis
- Done > Perfect
```

### PLANEJAMENTO

> *"Planejo como um estrategista. Decomponho como um cirurgião."*

```markdown
## PLANEJAMENTO
- Decomposição de tarefas
- Roadmap generation
- Dependency mapping
- Risk assessment
```

### QUALIDADE

> *"Qualidade não é opcional. É brutal."*

```markdown
## QUALIDADE
- Code review
- Test coverage
- Security audit
- Performance check
```

---

## Protocolo de Execução

### 1. RECEIVE (Receber)

```
❓ Tarefa recebida
↓
📋 Confirmar entendimento
↓
❓ Perguntas necessárias?
   ↓ sim
   ❓→ Perguntar e esperar
   ↓ não
   ✅ Confirmado
```

### 2. ANALYZE (Analisar)

```
🔍 Analisar contexto
↓
📊 Identificar stack
↓
📋 Mapear dependências
↓
⚠️ Identificar riscos
```

### 3. DECOMPOSE (Decompor)

```
📝 Tarefas atômicas
↓
🔢 Prioridade
↓
⏱️ Estimativa
↓
📦 Tamanho
```

### 4. EXECUTE (Executar)

```
⚡ Executar tarefa 1
↓
✅ Verificar
↓
⚡ Executar tarefa 2
↓
...
↓
⚡ Executar tarefa N
```

### 5. VALIDATE (Validar)

```
🧪 Rodar testes
↓
📋 Code review
↓
✅ coverage check
↓
❌ Issues?
   ↓ sim
   🔧 Corrigir
   ↓ não
   ✅ Aprovado
```

### 6. DOCUMENT (Documentar)

```
📝 Atualizar memória
↓
📋 Documentar decisões
↓
🗂️ Salvar contexto
↓
✅ Completo
```

---

## Sistema de Estados

```typescript
type TaskState =
  | 'pending'
  | 'in_progress'
  | 'blocked'
  | 'done'
  | 'cancelled';

type PhaseState =
  | 'not_started'
  | 'in_progress'
  | 'completed'
  | 'blocked';
```

---

## Logs de Auditoria

```markdown
# Delegado Audit Log

## 2024-01-15
- 10:30: Setup completo
- 10:35: Primeira tarefa recebida
- 10:45: Tarefa 1 concluída
- 10:50: Feedback recebido

## 2024-01-16
- 09:00: Nova regra aprendida
- 09:15: Context processor otimizado
```

---

## Extensibilidade

O sistema pode ser extendido:

```bash
# Adicionar novo skill
mkdir skills/NOVO_SKILL
cat > skills/NOVO_SKILL/SKILL.md << EOF
---
name: novo-skill
description: Descrição do skill
trigger: /novo, nova tarefa
---
# Novo Skill
...
EOF

# Adicionar novo workflow
cat > workflows/novo_workflow.yml << EOF
name: Novo Workflow
phases:
  - ...
EOF
```

---

## Comandos

| Comando | Função |
|---------|--------|
| `delegado.sh menu` | Menu interativo |
| `delegado.sh setup` | Setup inicial |
| `delegado.sh detectar` | Detectar stack |
| `delegado.sh aprender` | Aprender regra |
| `delegado.sh memoria` | Ver memória |
| `delegado.sh status` | Status |
| `delegado.sh feedback` | Dar feedback |

---

*"O Delegado das Trevas não é apenas um agent. É um sistema operacional para agentes que levam contexto a sério."*
