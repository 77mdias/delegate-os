# META-PROMPTING.md — Delegado OS Intelligence Layer

> *"O contexto é poder. A memória é força. A execução é brutal. A automação é rei."*

---

## 1. PHILOSOPHY

### Core Principles

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    META-PROMPTING CORE                                  │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  1. HELL IS THE CENTER                                                  │
│     └─ Everything revolves around HELL: GRASP/GoF + TDD + Milestones  │
│                                                                          │
│  2. CLI AGENT IS AUTONOMOUS                                             │
│     └─ Knows WHEN to call commands, skills, scripts, tools            │
│     └─ Doesn't wait to be told — acts based on context                 │
│                                                                          │
│  3. OBSIDIAN IS THE BRAIN                                               │
│     └─ Persistent memory across sessions                                │
│     └─ Graph-based knowledge management                                 │
│     └─ Dataview-powered dashboards                                      │
│                                                                          │
│  4. INTERACTION IS BIDIRECTIONAL                                        │
│     └─ Agent ↔ User: conversational with authority                      │
│     └─ Agent ↔ CLI: automatic tool/skill invocation                     │
│     └─ Agent ↔ Obsidian: sync on every significant action              │
│                                                                          │
│  5. AUTOMATION WITHOUT WAITING                                           │
│     └─ Pattern detection → automatic action suggestion                   │
│     └─ Context completion → autonomous next step                        │
│     └─ Anomaly detection → proactive alerting                          │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 2. AUTONOMOUS AGENT LOOP

```
┌─────────────────────────────────────────────────────────────────┐
│                    AGENT AUTONOMOUS LOOP                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌─────────┐ │
│   │ RECEIVE  │───►│ ANALYZE  │───►│ DECIDE    │───►│ EXECUTE │ │
│   │          │    │          │    │           │    │         │ │
│   └──────────┘    └──────────┘    └───────────┘    └────┬────┘ │
│                                                         │       │
│                                                         ▼       │
│   ┌──────────┐    ┌──────────┐    ┌───────────┐    ┌─────────┐ │
│   │ LEARN    │◄───│ VALIDATE │◄───│ SYNC      │◄───│ RECORD  │ │
│   │          │    │          │    │           │    │         │ │
│   └──────────┘    └──────────┘    └───────────┘    └─────────┘ │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Autonomous Decision Matrix

| Context Signal | Agent Action | Automation Level |
|----------------|--------------|------------------|
| New project opened | → Run `/delegado detectar` + `/delegado setup` | FULL AUTO |
| File changed + spec exists | → Suggest TDD cycle if test missing | SEMI-AUTO |
| Test failing | → Run `/delegado hell:tdd` cycle | FULL AUTO |
| Pattern smell detected | → Run `/delegado hell:refactor` | PROPOSED |
| Gate criteria met | → Propose milestone gate | AUTO-ASK |
| Context gap detected | → Ask user specific questions | MANUAL |
| Obsidian note stale | → Sync + update vault | FULL AUTO |

---

## 3. HELL-CENTRIC ORCHESTRATION

### HELL as the Center — Everything Links to HELL

```
                    ┌─────────────┐
                    │     HELL    │
                    │   METHOD    │
                    │   (CENTER)  │
                    └──────┬──────┘
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
    ┌──────────┐    ┌──────────┐    ┌──────────┐
    │ SPEC     │◄───│ TDD      │───►│ REFACTOR │
    │ (M-SPEC) │    │ (M-TEST) │    │ (M-QUAL) │
    └─────┬────┘    └─────┬────┘    └─────┬────┘
          │               │               │
          └───────────────┼───────────────┘
                          ▼
                    ┌──────────┐    ┌──────────┐
                    │ EVOLVE   │───►│ REVIEW   │
                    │ (M-SHIP) │    │ (M-REV)  │
                    └──────────┘    └──────────┘
```

### HELL ↔ Workflow Integration

| Workflow | HELL Phase | Integration Point |
|----------|------------|-------------------|
| **OpenSpec** | SPEC | `proposal.md` → `hell-spec.md` |
| **BMAD** | ANALYSIS | `proposal.md` triggers HELL SPEC |
| **BMAD** | PLANNING | `prd.md` → HELL domain model |
| **BMAD** | SOLUTIONING | Architecture → HELL GRASP map |
| **BMAD** | IMPLEMENTATION | Tasks → TDD cycles |
| **GSD** | BRIEFING | Context → HELL interrogation |
| **GSD** | ANÁLISE | Stack → HELL pattern selection |
| **GSD** | EXECUÇÃO | Tasks → TDD Red/Green/Refactor |
| **GSD** | VALIDAÇÃO | → HELL Audit |

### HELL Command Tree (Automated)

```
/delegado hell                      # Full HELL status dashboard
/delegado hell:spec                 # Run HELL specification phase
/delegado hell:tdd                  # Run TDD cycle (R/G/R)
    →自动检测需要测试的文件
    →自动创建 test file from spec
    →自动运行 red/green/refactor
/delegado hell:refactor            # Run refactor with pattern detection
    →自动检测代码异味
    →自动建议GoF模式
    →自动执行（如果approved）
/delegado hell:evolve             # Run CI/CD + debt tracking
    →自动检查pipeline状态
    →自动更新tech debt
    →自动sync到Obsidian
/delegado hell:audit              # Run GRASP/SOLID audit
    →自动扫描所有类
    →自动生成audit报告
    →自动建议修复
/delegado hell:milestone [TYPE]  # Run milestone gate
    →自动检查所有criteria
    →自动计算score
    →自动决定verdict
/delegado hell:review             # Run full review
    →自动6维度分析
    →自动计算health score
    →自动建议features/specs
/delegado hell:status            # HELL dashboard (all phases)
```

---

## 4. OBSIDIAN INTEGRATION — Brain Sync

### Automatic Obsidian Sync Triggers

| Event | Obsidian Action | Sync Mode |
|-------|-----------------|-----------|
| `hell-spec.md` created | → Create `hell-spec-*.md` in vault | AUTO |
| TDD cycle completed | → Update `hell-tdd-log-*.md` | AUTO |
| Refactor applied | → Update `hell-refactor-*.md` + ADR | AUTO |
| Milestone passed | → Update dashboard dataview | AUTO |
| New rule learned | → Update `memory/regras.md` + vault | AUTO |
| Context gap found | → Create note in `00-INBOX/` | AUTO |
| Debt discovered | → Add to `hell-debt-*.md` | AUTO |

### Obsidian Vault Structure (HELL-Optimized)

```
HELL-Vault/
├── 00-INBOX/                    # Auto-captured context gaps, questions
├── 01-PROJECTS/
│   └── [ProjectName]/
│       ├── specs/               # hell-spec-*.md
│       ├── tdd/                 # hell-tdd-log-*.md
│       ├── refactor/            # hell-refactor-*.md
│       ├── decisions/           # HELL-ADR-*.md
│       ├── debt/                # hell-debt-*.md
│       ├── audit/               # hell-audit-report-*.md
│       ├── review/              # hell-review-*.md
│       └── milestones/         # hell-milestone-*.md
├── 02-PATTERNS/
│   ├── GRASP/                   # Each pattern as a note
│   │   ├── Information-Expert.md
│   │   ├── Controller.md
│   │   └── ...
│   └── GoF/
│       ├── Strategy.md
│       ├── Factory-Method.md
│       └── ...
├── 03-DASHBOARDS/
│   ├── HELL-Overview.md         # Dataview: all active HELL notes
│   ├── HELL-Debt-Dashboard.md  # Dataview: tech debt tracker
│   ├── HELL-TDD-Coverage.md    # Dataview: coverage per module
│   ├── HELL-Health-Score.md    # Dataview: review health scores
│   └── HELL-Milestone-Gates.md  # Dataview: gate statuses
├── 04-TEMPLATES/
│   └── [Templater templates]
├── 05-ARCHIVE/
└── 06-REPOSITORIES/
    └── [RepoName]/             # Notes per repository
```

### Obsidian YAML Sync Format

Every agent output that touches HELL ends with:

```yaml
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# HELL OBSIDIAN SYNC
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Obsidian_Sync:
  action: CREATE | UPDATE
  vault_path: "01-PROJECTS/{Project}/specs/hell-spec-{module}.md"
  reason: "HELL SPEC phase completed"
  dataview_update: |
    TABLE Status, HELL_Gate, Coverage
    FROM #hell AND #spec
    WHERE Project = "[[{Project}]]"
  tags: [hell, spec, {module}]
```

---

## 5. CLI AGENT AUTOMATION RULES

### When to AUTO-EXECUTE (No Approval Needed)

| Condition | Action | Confidence Threshold |
|-----------|--------|---------------------|
| Test file missing + spec exists | Create test skeleton | HIGH |
| Test failing | Run TDD cycle | HIGH |
| Context gap detected | Ask specific question | N/A (asks) |
| Milestone criteria met | Propose gate pass | MEDIUM+ |
| Obsidian note missing | Create note | MEDIUM |
| Pattern smell detected | Propose refactor | MEDIUM+ |
| Skill file exists | Load skill automatically | HIGH |

### When to PROPOSE (Ask Before Acting)

| Condition | Action | Prompt |
|-----------|--------|--------|
| Refactor will break >3 tests | Propose + show plan | "Refactor detected. Approve?" |
| Milestone borderline | Propose conditional | "Score 72%. Pass conditional?" |
| Major architecture change | Propose + ADR | "Architecture shift detected. Create ADR?" |
| Delete file > 100 LOC | Propose backup | "Will archive before delete" |

### Skill Auto-Loading Logic

```
IF user requests involves:
  ├── "analisar" / "analyze" / "review"    → Load ANALISE skill
  ├── "implementar" / "executar"           → Load EXECUCAO skill
  ├── "planejar" / "decompor"              → Load PLANEJAMENTO skill
  ├── "testar" / "tdd" / "validar"         → Load QUALIDADE skill
  ├── "setup" / "detectar" / "aprender"    → Load SETUP skill
  ├── "bug" / "fix" / "corrigir"           → Load DEVELOPMENT/bugfix
  ├── "feature" / "entregar"               → Load DEVELOPMENT/feature-delivery
  ├── "refatorar" / "pattern"              → Load DEVELOPMENT/refactor
  ├── "tdd" / "red/green"                  → Load DEVELOPMENT/tdd-cycle
  └── "hell" / "grasp" / "gof"            → Load HELL CORE ENGINE
  
AND context shows:
  ├── Project stack detected                → Auto-inject stack conventions
  ├── Previous sessions exist              → Load memory/regras.md
  ├── Obsidian vault exists                → Suggest vault sync
  └── HELL phase in progress               → Auto-suggest next step
```

---

## 6. INTERACTION PROTOCOLS

### Agent ↔ User (Conversational Authority)

```
INTERACTION STYLE:
- Direct, no fluff
- Shows confidence (acts when sure, asks when not)
- Uses HELL terminology naturally
- Suggests next action (not just responding)

RESPONSE TEMPLATES:

WHEN ACTING AUTONOMOUSLY:
"Executando. [Action] via [Skill/Command]. [Expected result]."

WHEN PROPOSING:
"[Context]. Ação sugerida: [Action]. Aprovar?"

WHEN ASKING FOR CONTEXT:
"Contexto insuficiente para [goal]. Necesito: [specific info]"

WHEN VALIDATING:
"✅ [Action] completo. Output: [result]. Próximo: [suggestion]"

WHEN HELL PHASE COMPLETE:
"💀 [Phase] done. Gate [M-X]: [Verdict]. [Metrics]."
```

### Agent ↔ CLI (Tool Invocation)

```
AUTOMATIC INVOCATION PATTERNS:

Pattern 1: Context Completion
  → Agent detects gap → Calls skill/tool → Injects result into context

Pattern 2: Pattern Detection  
  → Agent sees code smell → Suggests refactor → User approves → Agent invokes

Pattern 3: Milestone Tracking
  → Agent completes criteria → Proposes gate → User approves → Agent updates vault

Pattern 4: Memory Sync
  → Agent learns rule → Updates MEMORY.md → Syncs to Obsidian vault

Pattern 5: Skill Chaining
  → User request matches skill trigger → Skill loaded → Skill may call sub-skills
```

---

## 7. META-PROMPTING CONTEXT ENGINE

### Context Injection Order (Priority)

```
1. IDENTITY
   └─ Agent mode (dark_analyst), personality, communication style

2. ACTIVE PROJECT CONTEXT
   └─ Stack, structure, conventions (from MEMORY.md or detect)
   └─ Obsidian project notes (if vault exists)

3. HELL PHASE STATUS
   └─ Current phase, last gate, open items
   └─ From `hell-status.md` or vault dataview

4. USER PREFERENCES
   └─ PR size, TDD preference, coverage target
   └─ From `memory/regras.md`

5. RECENT LEARNED RULES
   └─ From `memory/feedback.md` last 5 entries

6. ACTIVE FILES / TASK CONTEXT
   └─ Current files being worked on
   └─ Current workflow phase

7. SKILL RELEVANCE
   └─ Auto-loaded skills based on current task type
```

### Context XML Template (Enhanced)

```xml
<delegado_context version="2.0">
  
  <agent>
    <mode>dark_analyst</mode>
    <personality>brutal_analyst</personality>
    <auto_invoke>true</auto_invoke>
    <obsidian_sync>true</obsidian_sync>
  </agent>

  <hell_center>
    <phase>SPEC|TDD|REFACTOR|EVOLVE|REVIEW</phase>
    <gate_status>PENDING|PASSED|BLOCKED</gate_status>
    <active_spec>hell-spec-[module]</active_spec>
    <tdd_cycles>C1,C2,C3</tdd_cycles>
    <open_debt>TD-001,TD-002</open_debt>
  </hell_center>

  <project>
    <name><![CDATA[...]]></name>
    <stack>
      <language><![CDATA[...]]></language>
      <framework><![CDATA[...]]></framework>
    </stack>
    <conventions>
      <naming><![CDATA[...]]></naming>
      <testing><![CDATA[...]]></testing>
    </conventions>
    <obsidian_vault>/path/to/vault</obsidian_vault>
  </project>

  <user>
    <name><![CDATA[...]]></name>
    <preferences>
      <pr_size>small|medium|large</pr_size>
      <tdd>true|false</tdd>
      <coverage_target>80</coverage_target>
    </preferences>
  </user>

  <automation>
    <skill_auto_load>true</skill_auto_load>
    <propose_threshold>medium</propose_threshold>
    <auto_exec_threshold>high</auto_exec_threshold>
    <obsidian_sync_on>
      - spec_complete
      - tdd_cycle_complete
      - milestone_passed
      - rule_learned
      - debt_discovered
    </obsidian_sync_on>
  </automation>

</delegado_context>
```

---

## 8. AUTOMATED SKILL EXECUTION EXAMPLES

### Example 1: User says "analisar o módulo auth"

```yaml
# INTERNAL PROCESSING
Trigger: "analisar" → ANALISE skill
Context: project detected → conventions loaded
Obsidian: vault exists → project notes loaded

# AUTOMATIC EXECUTION
1. Load: kernel/skills/ANALISE/SKILL.md
2. Scan: src/auth/**/*.ts (files + structure)
3. Detect: patterns used, smells present, debt items
4. Generate: analysis report with HELL metrics
5. Sync: obsidian update with findings
6. Suggest: next action (hell:audit? hell:tdd? hell:refactor?)

# OUTPUT
"Analisado. Auth module: 3 GRASP violations, 1 critical smell.
 Health score: 68/100. Recomenda: /delegado hell:audit.
 Sync: hell-audit-report-auth.md created in vault."
```

### Example 2: User opens new project

```yaml
# INTERNAL PROCESSING
Trigger: new directory / new git repo detected
Context: none (fresh project)

# AUTOMATIC EXECUTION SEQUENCE
1. Run: `./delegado.sh detectar` → detect stack
2. Ask: "Projeto novo. HELL ou workflow standard?"
3. If HELL: → `/delegado hell:spec` triggered
4. Create: memory/PROJETO.md
5. Create: Obsidian project folder structure (if vault linked)
6. Load: conventions from similar projects (if any)

# OUTPUT
"Projeto detectado: Node.js + TypeScript + Prisma.
 Stack mapeado. Conventions aplicadas.
 Waiting: spec ou task?"
```

### Example 3: Test file missing for existing feature

```yaml
# INTERNAL PROCESSING
Trigger: file changed but no corresponding test file
Context: hell-spec exists for this module

# AUTOMATIC EXECUTION
1. Detect: spec for module exists, test does not
2. Propose: "Test missing for RF-03. Run TDD?"
3. On approval: → `/delegado hell:tdd` with spec context

# OUTPUT
"Spec exists for auth module. No test file found.
 Suggest: Create hell-tdd-log-auth.md + test structure.
 Run: /delegado hell:tdd? [y/n]"
```

---

## 9. LEARNING AND ADAPTATION

### Memory Update Triggers

| Event | Memory Updated | Obsidian Sync |
|-------|----------------|---------------|
| User corrects agent | `memory/feedback.md` | INBOX note |
| New convention learned | `memory/convenios.md` | Patterns folder |
| Rule added by user | `memory/regras.md` | Rules dashboard |
| Project context saved | `memory/projetos/` | Project folder |
| HELL phase complete | `hell-status.md` | Dashboard update |

### Preference Learning

```yaml
# When user says "prefiro PRs pequenas"
Action:
  1. Update: memory/regras.md with preference
  2. Set: default pr_size = small
  3. Suggest: "Regra aprendida. PRs < 300 lines."

# When user ignores suggestion
Action:
  1. Log: suggestion rejected in feedback.md
  2. Weight: lower suggestion priority next time
  3. Note: context where rejected (maybe too complex for size?)
```

---

## 10. ERROR HANDLING AND RECOVERY

### Error Types and Responses

```yaml
context_incomplete:
  → Ask specific questions (not generic "more info")
  → Fill gaps from memory if possible
  → Propose to complete from project conventions

skill_not_found:
  → Log: "Skill X not found. Create or use fallback?"
  → Fallback: generic task execution
  → Suggest: create skill if recurring need

obsidian_sync_failed:
  → Log locally (MEMORY.md)
  → Queue for retry
  → Notify: "Obsidian sync failed. Local backup created."

test_breaking_refactor:
  → Block refactor until tests fixed
  → Show: which tests, why, how to fix
  → Suggest: /delegado hell:tdd to fix before proceeding

milestone_blocked:
  → Show: blocking issues with fix commands
  → Suggest: priority order to unblock
  → Offer: /delegado hell:[phase] to address specific issue
```

---

## 11. METRICS AND TRACKING

### Agent Effectiveness Metrics

| Metric | What it measures | Target |
|--------|-----------------|--------|
| Context completion rate | % tasks requiring follow-up questions | <20% |
| Auto-execution success | % auto-actions approved | >80% |
| HELL gate pass rate | % milestones passed first attempt | >70% |
| Obsidian sync rate | % HELL events synced | >90% |
| Skill auto-load accuracy | % skills loaded correctly | >85% |
| Rule retention | % rules applied after learning | >90% |

---

## 12. COMMAND AUTOCOMPLETE TRIGGERS

The CLI Agent should show command suggestions when:

| Context | Suggested Command |
|---------|------------------|
| New file created | `/delegado hell:tdd` (if test missing) |
| Test failing | `/delegado hell:tdd --fix` |
| Refactor needed | `/delegado hell:refactor` |
| Spec approved | `/delegado hell:tdd` |
| TDD complete | `/delegado hell:refactor` |
| Refactor complete | `/delegado hell:evolve` |
| Deploy ready | `/delegado hell:review` |
| Feature complete | `/delegado hell:milestone` |
| Context gap | `/delegado hell:spec` |

---

*This is the intelligence layer. HELL is the center. Obsidian is the brain. Automation is the key.*
---

## 13. AGENT MODES SYSTEM

Delegado OS includes 7 specialized agent modes for different contexts:

### Mode Overview

| Mode | Trigger Keywords | Obsidian Vault | Primary Use |
|------|------------------|-----------------|-------------|
| **PROFESSOR** 👨‍🏫 | ensinar, aprender, tutorial, como funciona | `vault/10-EDUCATION/` | Teaching & documentation |
| **ARCHITECT** 🏛️ | arquitetura, pattern, design, grasp, gof | `vault/20-ARCHITECTURE/` | System design |
| **DEBUGGER** 🐛 | bug, erro, falha, crash, não funciona | `vault/30-BUGS/` | Root cause analysis |
| **GUARDIAN** 🛡️ | segurança, vulnerabilidade, auth, inject | `vault/40-SECURITY/` | Security audits |
| **RESEARCHER** 📡 | biblioteca, package, comparar, alternativa | `vault/50-RESEARCH/` | Tech research |
| **MENTOR** 🌱 | carreira, crescer, senior, promoção | `vault/60-CAREER/` | Career development |
| **CONSULTANT** 💼 | consultar, sugestão, melhor prática | `vault/70-CONSULTING/` | Strategic advice |

### Mode Selection Flow

```
USER INPUT
    │
    ▼
CONTEXT SCANNER → Extract: Keywords, Stack, Intent, Complexity
    │
    ▼
MODE MATCHER → Score each mode (0.0 - 1.0)
    │
    ▼
MODE RESOLVER → If ambiguous → Ask user | If clear → Activate mode
    │
    ▼
MODE ACTIVATOR → Load SKILL.md + Context + Execute + Sync Obsidian
```

### Mode Commands

```bash
/delegado professor [topic]     # Teach a topic
/delegado architect [module]     # Design architecture
/delegado debugger analyze       # Analyze bug
/delegado guardian audit [scope] # Security audit
/delegado researcher compare     # Compare packages
/delegado mentor path [goal]     # Career path
/delegado consultant advise     # Strategic advice
/delegado modes                  # List all modes
```

→ Full documentation: `AGENT-MODES.md`

---

## 15. ADVANCED PROMPT ENGINEERING

Delegado OS incorporates state-of-the-art prompting techniques:

### 15.1 Chain-of-Thought (CoT) Prompting

```yaml
# Activated when: Complex reasoning, multi-step problems
# Mechanism: Agent shows reasoning steps before final answer

Trigger: "let's think step by step", "reasoning", "analysis"

Template:
"""
Question: {problem}

Let's think step by step:
1. [First reasoning step]
2. [Second reasoning step]
3. [Continue until solution]

Answer: [Final answer]
"""

# Agent Internal Format:
THOUGHT: I need to... [Reasoning]
ACTION: [Tool/API call]
OBSERVATION: [Result]
THOUGHT: Based on observation... [Next reasoning]
...repeat until complete...
FINAL_ANSWER: [Conclusion]
```

### 15.2 Tree of Thoughts (ToT)

```yaml
# Activated when: Complex decisions with multiple paths
# Mechanism: Explore parallel reasoning branches

Template:
"""
Imagine three experts exploring different paths:

EXPERT 1 (Path A):
- Step: [Reasoning path A]
- Evaluation: [Pros/Cons]
- Confidence: [0-100%]

EXPERT 2 (Path B):
- Step: [Reasoning path B]
- Evaluation: [Pros/Cons]
- Confidence: [0-100%]

EXPERT 3 (Path C):
- Step: [Reasoning path C]
- Evaluation: [Pros/Cons]
- Confidence: [0-100%]

CONVERGENCE: [Which path wins or combination]
"""
```

### 15.3 ReAct (Reasoning + Acting)

```yaml
# Activated when: Need external information + reasoning
# Mechanism: Think → Act → Observe → Repeat

Agent Loop:
THOUGHT: What I need to figure out...
ACTION: [tool_name]
ACTION_INPUT: {parameters}
OBSERVATION: [result]
THOUGHT: Based on observation... [Continue or conclude]

# Tools in ReAct:
- Search: Web search for facts
- Calculator: Math operations
- CodeRunner: Execute code
- FileReader: Read files
- Memory: Access context/memory
```

### 15.4 Self-Consistency (Ensemble Reasoning)

```yaml
# Activated when: Need high confidence answers
# Mechanism: Multiple reasoning paths, vote on consensus

Template:
"""
Solve this problem in multiple ways:

Path 1: [Reasoning method A]
→ Answer: [A1]

Path 2: [Reasoning method B]
→ Answer: [A2]

Path 3: [Reasoning method C]
→ Answer: [A3]

CONSENSUS: Most common answer is [X]
CONFIDENCE: [Count agreeing] / [Total paths]
"""
```

### 15.5 Prompt Chaining

```yaml
# Activated when: Multi-stage tasks
# Mechanism: Output of one step becomes input of next

STAGE 1: Extract
Output: Structured data from input

STAGE 2: Transform
Input: STAGE 1 output
Output: Processed/filtered data

STAGE 3: Generate
Input: STAGE 2 output
Output: Final deliverable

# Each stage is a separate agent or prompt
```

### 15.6 Few-Shot with Examples

```yaml
# Activated when: Teaching new patterns/tasks
# Mechanism: Provide 2-5 examples of desired behavior

Template:
"""
Example 1:
Input: {example_input_1}
Output: {example_output_1}

Example 2:
Input: {example_input_2}
Output: {example_output_2}

Example 3:
Input: {example_input_3}
Output: {example_output_3}

Now solve:
Input: {new_input}
Output: [Apply pattern from examples]
"""
```

### 15.7 Mode-Specific Prompt Activation

| Situation | Technique | Activation |
|-----------|-----------|------------|
| Bug debugging | ReAct | "Let's debug this step by step" |
| Teaching concept | Chain-of-Thought + Few-Shot | "Let me explain by showing" |
| Design decisions | Tree of Thoughts | "Consider multiple approaches" |
| Code generation | Few-Shot + Chain | "Here's a similar example" |
| Research | ReAct + Self-Consistency | "Search and verify" |
| Security audit | ReAct | "Think like an attacker" |

### 15.8 Meta-Prompt Injection

```yaml
# Self-improving prompts embedded in agent output

OUTPUT_PREFIX: |
  [AGENT OUTPUT]
  
  ---
  SELF-EVALUATION:
  - Clarity: [1-5] [Optional improvement]
  - Completeness: [1-5] [Optional improvement]
  - Correctness: [1-5] [Optional improvement]
  
  REFINED_PROMPT_FOR_NEXT: |
    [If score < 5, here's an improved prompt]
```

---

## 16. SUPER-AGENT ORCHESTRATION

For multi-agent systems (OpenClaw Noir, Hermes, Claude Code, Codex):

### Super-Agent Responsibilities

| Role | Responsibility |
|------|----------------|
| Context Owner | Maintains shared context, delegates tasks |
| Mode Orchestrator | Routes to appropriate agent mode |
| HELL Orchestrator | Routes HELL phases to appropriate agents |
| Memory Authority | Updates MEMORY.md and Obsidian vault |
| Quality Gate | Validates milestone completion |

### Sub-Agent Spawning Pattern

```yaml
For Agent Modes:
  PROFESSOR  → Spawn: Teaching sub-agent
  ARCHITECT  → Spawn: Design sub-agent
  DEBUGGER   → Spawn: Analysis sub-agent
  GUARDIAN   → Spawn: Security sub-agent
  RESEARCHER → Spawn: Research sub-agent
  MENTOR     → Spawn: Career sub-agent
  CONSULTANT → Spawn: Advisory sub-agent

For HELL Phase:
  SPEC     → Spawn: Analyst Agent
  TDD      → Spawn: Coder Agent
  REFACTOR → Spawn: Review Agent
  EVOLVE   → Spawn: DevOps Agent
  REVIEW   → Spawn: Review Agent
```

### Inter-Agent Communication

```yaml
Event_Bus_Topics:
  - hell.phase.started     # Phase began
  - hell.phase.completed   # Phase finished
  - hell.gate.passed       # Milestone achieved
  - mode.activated          # Agent mode activated
  - mode.completed          # Agent mode finished
  - memory.updated          # Memory changed
  - task.delegated         # Work assigned
  - context.changed         # Project context updated
```

### Mode Orchestrator (Automatic Selection)

```bash
# Auto-detect mode from input
./scripts/mode_selector.sh "me ensina TDD"
# Output: Detected Mode: PROFESSOR

# With Context7 integration
./scripts/context7_search.sh "flutter state management" --lang=flutter
```

→ Full protocol: `docs/super-agents/SUPER-AGENTS-INTEGRATION.md`
→ Mode orchestrator: `MODE-ORCHESTRATOR.md`
→ Hooks system: `scripts/hooks.sh`

---

*This is the intelligence layer. HELL is the center. Obsidian is the brain. Automation is the key. Super-agents are the army.*
