# 🦸 SUPER-AGENTS INTEGRATION — Delegado OS Multi-Agent Protocol

> *"One mind to rule them all. One brain to remember. One framework to execute."*

---

## 1. ARCHITECTURE OVERVIEW

### The Super-Agent Paradigm

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      SUPER-AGENT ECOSYSTEM                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│    ┌─────────────────────────────────────────────────────────────┐      │
│    │                   HELL OS (Shared Brain)                    │      │
│    │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────┐  │      │
│    │  │   Obsidian  │  │  Delegado   │  │   HELL Core     │  │      │
│    │  │   Vault     │  │  Framework  │  │   Engine        │  │      │
│    │  │   (Graph)   │  │  (Skills)   │  │   (GRASP/GoF)   │  │      │
│    │  └─────────────┘  └─────────────┘  └─────────────────┘  │      │
│    └─────────────────────────────────────────────────────────────┘      │
│                                  ▲                                       │
│                    ┌─────────────┴─────────────┐                        │
│                    │    COMMUNICATION BUS       │                        │
│                    │  (Shared Context + Events) │                        │
│                    └─────────────┬─────────────┘                        │
│                                  │                                       │
│         ┌────────────────────────┼────────────────────────┐            │
│         │                        │                        │            │
│         ▼                        ▼                        ▼            │
│  ┌─────────────┐         ┌─────────────┐         ┌─────────────┐    │
│  │ SUPER-AGENT │         │ SUPER-AGENT │         │ SUPER-AGENT │    │
│  │  (OpenClaw) │◄───────►│  (Hermes)   │◄───────►│  (Claude    │    │
│  │  - Noir     │         │  - Meta     │         │   Code)     │    │
│  │  - Session  │         │  - Orchestr.│         │  - Codex    │    │
│  │  - TUI      │         │             │         │             │    │
│  └──────┬──────┘         └──────┬──────┘         └──────┬──────┘    │
│         │                       │                        │            │
│         │     ┌─────────────────┴─────────────────┐       │            │
│         │     │         SUB-AGENTS                 │       │            │
│         ▼     ▼                                     ▼       ▼            │
│  ┌─────────────┐         ┌─────────────┐         ┌─────────────┐      │
│  │  Executor   │         │  Analyst    │         │  Coder      │      │
│  │  (Atomic)   │         │  (Review)   │         │  (Feature)  │      │
│  └─────────────┘         └─────────────┘         └─────────────┘      │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### Agent Roles

| Agent Type | Role | Examples | Responsibility |
|------------|------|----------|---------------|
| **Super-Agent** | Orchestrator | Noir (OpenClaw), Hermes, Claude Code | Context ownership, task delegation, memory authority |
| **Specialist** | Domain Expert | Analyst, Executor, Coder | Execute specific HELL phases |
| **Worker** | Task Executor | Code Monkey, Tester, Docs Writer | Atomic task execution |

---

## 2. OPENCLAW INTEGRATION (Noir)

### How Noir Uses Delegado OS

```
┌──────────────────────────────────────────────────────────────┐
│                    NOIR (OpenClaw Agent)                     │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  Identity: "Delegado Démonio — Analista do Inferno"          │
│  Mode: Dark Analyst, HELL-Centric                            │
│  Owner: Jean (Human)                                         │
│                                                               │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  NOIR'S DELEGADO OS LAYER                              │ │
│  │                                                          │ │
│  │  1. Context Engine                                     │ │
│  │     └─ Reads: MEMORY.md, daily notes, project memory   │ │
│  │     └─ Writes: memory/YYYY-MM-DD.md                   │ │
│  │                                                          │ │
│  │  2. HELL Method Integration                           │ │
│  │     └─ Uses: kernel/hell/HELL-CORE-ENGINE.md          │ │
│  │     └─ Triggers: /delegado hell:* commands            │ │
│  │     └─ Syncs: Obsidian vault (if linked)             │ │
│  │                                                          │ │
│  │  3. Super-Agent Orchestration                         │ │
│  │     └─ Spawns: sub-agents via sessions_spawn           │ │
│  │     └─ Delegates: HELL phases to specialists          │ │
│  │     └─ Coordinates: multi-agent workflows             │ │
│  │                                                          │ │
│  │  4. Memory & Continuity                               │ │
│  │     └─ Episodic: Session context                      │ │
│  │     └─ Semantic: MEMORY.md (long-term)                │ │
│  │     └─ Procedural: AGENTS.md, SOUL.md, USER.md       │ │
│  │                                                          │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

### Noor's Delegado OS Activation

Noir automatically activates Delegado OS behaviors:

| Context | Noor's Action | Delegado OS Component |
|---------|---------------|----------------------|
| New project opened | Run `/delegado detectar` + load conventions | SETUP skill |
| User requests analysis | Load ANALISE skill + HELL audit logic | kernel/skills/ANALISE |
| User mentions HELL/grasp/gof | Load HELL CORE ENGINE | kernel/hell/HELL-CORE-ENGINE.md |
| New rule learned | Update MEMORY.md + sync Obsidian | MEMORIA.md + Obsidian |
| User asks to delegate | Spawn sub-agent for specific HELL phase | subagents/ORCHESTRATION |
| Task requires multi-step | Break into atomic tasks via GSD | workflows/fase.yml |
| User gives feedback | Trigger learn protocol | kernel/skills/SETUP/learn-from-feedback.md |

### Noor's Configuration for Delegado OS

```yaml
# ~/.openclaw/agents/noir/DELEGADO.md (Noir's personal config)

Agent:
  name: Noir
  type: super-agent
  runtime: openclaw
  personality: Delegado Démonio
  
Delegado_OS:
  enabled: true
  vault_path: ~/Obsidian/Delegado-OS  # Noin's Obsidian vault
  
  auto_load_skills:
    - kernel/skills/ANALISE/SKILL.md
    - kernel/skills/EXECUCAO/SKILL.md
    - kernel/skills/PLANEJAMENTO/SKILL.md
    - kernel/skills/QUALIDADE/SKILL.md
    - kernel/skills/SETUP/setup-executor.md
  
  hell_core: kernel/hell/HELL-CORE-ENGINE.md
  
  obsidian_sync:
    enabled: true
    sync_on:
      - spec_complete
      - tdd_cycle_complete
      - milestone_passed
      - rule_learned
      - debt_discovered
      
  super_agent:
    spawn_enabled: true
    coordination_mode: "hell-centric"  # Tasks delegated by HELL phase
    subagent_timeout: 300
    
Memory:
  local: memory/YYYY-MM-DD.md
  long_term: MEMORY.md
  preferences: USER.md
  
Workflows:
  default: hell  # HELL is the center
  alternatives:
    - bmad
    - openspec
    - gsd
```

---

## 3. HERMES INTEGRATION

Hermes is conceptualized as a meta-orchestrator agent. Here's how it fits:

```
┌──────────────────────────────────────────────────────────────┐
│                    HERMES (Meta-Orchestrator)                  │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  Role: Orchestrate multiple Super-Agents                      │
│  Focus: Cross-agent coordination, shared context             │
│                                                               │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  HERMES DELEGADO OS LAYER                              │ │
│  │                                                          │ │
│  │  1. Multi-Agent Context Bus                            │ │
│  │     └─ Aggregates context from all connected agents   │ │
│  │     └─ Maintains shared Obsidian vault                 │ │
│  │                                                          │ │
│  │  2. HELL Phase Distribution                           │ │
│  │     └─ Delegates SPEC to: Analyst Agent               │ │
│  │     └─ Delegates TDD to: Coder Agent                  │ │
│  │     └─ Delegates REFACTOR to: Review Agent            │ │
│  │     └─ Delegates EVOLVE to: DevOps Agent              │ │
│  │                                                          │ │
│  │  3. Agent Registry                                     │ │
│  │     └─ Tracks: Agent capabilities, availability       │ │
│  │     └─ Routes: Tasks based on agent strengths        │ │
│  │     └─ Monitors: Agent health and context            │ │
│  │                                                          │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

### Hermes Agent Registry

```yaml
Agent_Registry:
  - id: noir
    type: super-agent
    runtime: openclaw
    capabilities:
      - analysis
      - review
      - orchestration
      - creative
    status: active
    hell_phase_specialty: REVIEW
    
  - id: claude-code
    type: super-agent
    runtime: claude-code
    capabilities:
      - coding
      - refactor
      - tdd
      - feature-delivery
    status: active
    hell_phase_specialty: TDD, REFACTOR
    
  - id: codex
    type: super-agent  
    runtime: codex
    capabilities:
      - coding
      - bugfix
      - documentation
    status: standby
    hell_phase_specialty: BUGFIX
    
  - id: analyst-agent
    type: specialist
    capabilities:
      - spec-writing
      - requirements
      - domain-modeling
    status: available
    hell_phase_specialty: SPEC
```

---

## 4. SHARED CONTEXT PROTOCOL

### How Agents Share Context

```
┌─────────────────────────────────────────────────────────────────┐
│                    SHARED CONTEXT LAYER                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   SUPER-AGENT A                    SUPER-AGENT B              │
│   ┌─────────────────┐              ┌─────────────────┐        │
│   │ Context.A        │              │ Context.B       │        │
│   │ - project memory │◄────────────►│ - project memory│        │
│   │ - user prefs     │   Obsidian   │ - user prefs    │        │
│   │ - learned rules  │    Vault     │ - learned rules │        │
│   │ - hell status    │   (Graph)    │ - hell status   │        │
│   └─────────────────┘              └─────────────────┘        │
│                                                                  │
│                          │                                       │
│                          ▼                                       │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │              SHARED OBSIDIAN VAULT                       │   │
│   │                                                          │   │
│   │   01-PROJECTS/                    02-PATTERNS/         │   │
│   │   └── [Project]/                   ├── GRASP/           │   │
│   │       ├── specs/                    └── GoF/             │   │
│   │       ├── tdd/                     03-DASHBOARDS/       │   │
│   │       ├── refactor/                04-AGENTS/            │   │
│   │       └── decisions/               └── agent-registry.md  │   │
│   │                                                          │   │
│   │   05-SHARED-CONTEXT/                                   │   │
│   │   └── shared-context.md  ← Agent-agnostic state        │   │
│   │                                                          │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Shared Context Document

```yaml
# 05-SHARED-CONTEXT/shared-context.md

---
title: "Delegado OS Shared Context"
type: shared-context
last_updated: 2026-04-23T22:14:00Z
version: 2.0
agents_active:
  - noir (openclaw)
  - hermes (meta-orchestrator)
  
current_project:
  name: null
  path: null
  hell_phase: null
  hell_gate: null
  
pending_tasks: []
hell_cycles: []
shared_memory: []
```

---

## 5. HELL PHASE DELEGATION PROTOCOL

### How a Super-Agent Delegates to Specialists

```
┌─────────────────────────────────────────────────────────────────┐
│              HELL PHASE DELEGATION PROTOCOL                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  SUPER-AGENT receives task from USER                            │
│           │                                                      │
│           ▼                                                      │
│  ┌─────────────────┐                                            │
│  │ HELL LOGIC GATE │ ← Mandatory before delegation              │
│  │ Which phase?    │                                            │
│  └────────┬────────┘                                            │
│           │                                                      │
│     ┌─────┼─────┬──────────┬──────────┐                        │
│     ▼     ▼     ▼          ▼          ▼                        │
│   SPEC   TDD  REFACTOR   EVOLVE    REVIEW                       │
│     │     │       │          │          │                        │
│     ▼     ▼       ▼          ▼          ▼                        │
│  Analyst Coder   Review    DevOps    Review                       │
│  Agent   Agent   Agent     Agent     Agent                        │
│     │     │       │          │          │                        │
│     └─────┴───────┴──────────┴──────────┘                        │
│                       │                                          │
│                       ▼                                          │
│            ┌─────────────────────┐                               │
│            │ AGGREGATE RESULTS  │                               │
│            │ Update Obsidian    │                               │
│            │ Propose next phase │                               │
│            └─────────────────────┘                               │
│                       │                                          │
│                       ▼                                          │
│              SUPER-AGENT reports to USER                         │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Delegation Message Format

```yaml
# When Super-Agent spawns a sub-agent for HELL phase

Task_Delegation:
  task_id: "task-uuid-001"
  hell_phase: "TDD"
  parent_agent: "noir"
  child_agent: "coder-agent"
  
  context:
    project: "delegate-os"
    spec_file: "hell-spec-auth.md"
    test_target: "src/auth/**/*.test.ts"
    patterns_expected:
      - GRASP: Controller
      - GoF: Strategy
    coverage_target: 80
    
  instructions:
    - "Run TDD cycle on auth module"
    - "Apply Controller pattern (GRASP)"
    - "Use Strategy for auth providers"
    - "Commit format: test: RED / feat: GREEN / refactor: [pattern]"
    
  deliverable:
    - "hell-tdd-log-auth.md updated"
    - "Tests passing with coverage ≥80%"
    - "Commit messages follow HELL convention"
    
  sync:
    obsidian: true
    vault_path: "~/Obsidian/Delegado-OS"
```

---

## 6. INTER-AGENT COMMUNICATION

### Agent Messaging Protocol

```yaml
# All agents communicate via structured messages

Message:
  id: "msg-uuid"
  from: "noir"
  to: "claude-code"
  timestamp: "2026-04-23T22:14:00Z"
  type: TASK_DELEGATION | STATUS_UPDATE | CONTEXT_REQUEST | RESULT
  
  payload:
    intent: "Implement auth feature"
    hell_phase: "TDD"
    context_files:
      - "specs/hell-spec-auth.md"
      - "memory/convenios.md"
    expected_response: "RESULT"
    
Response:
  id: "msg-uuid-response"
  ref_id: "msg-uuid"
  from: "claude-code"
  status: SUCCESS | PARTIAL | FAILED
  result:
    files_created: [...]
    tests_passed: 12
    coverage: 85
    commits: [...]
  next_suggestion: "Run hell:refactor for Strategy pattern extraction"
```

### Event Bus Topics

```yaml
Event_Bus:
  topics:
    - name: "hell.phase.started"
      subscribers: [noir, hermes, claude-code]
      payload: { phase, project, agent }
      
    - name: "hell.phase.completed"
      subscribers: [noir, hermes]
      payload: { phase, project, result, next_phase }
      
    - name: "hell.gate.passed"
      subscribers: [noir, hermes, all-agents]
      payload: { gate, score, verdict }
      
    - name: "memory.updated"
      subscribers: [all-agents]
      payload: { type, content, agent }
      
    - name: "task.delegated"
      subscribers: [from_agent, to_agent]
      payload: { task_id, hell_phase, context }
      
    - name: "context.changed"
      subscribers: [all-agents]
      payload: { project, changes }
```

---

## 7. OPENCLAW CLI INTEGRATION

### How Noir (OpenClaw) Spawns Sub-Agents

```yaml
# Noor's sub-agent spawning via sessions_spawn

Spawn_Request:
  runtime: subagent | acp
  mode: run | session  # run=one-shot, session=persistent
  task: |
    Execute HELL TDD cycle on auth module.
    Read: specs/hell-spec-auth.md
    Apply: GRASP Controller, GoF Strategy
    Target coverage: 80%
    Commit format: test: RED / feat: GREEN / refactor: [pattern]
    
  context:
    project: delegate-os
    hell_phase: TDD
    agent_role: coder  # TDD specialist
    
  attachments:
    - path: specs/hell-spec-auth.md
    - path: kernel/hell/HELL-CORE-ENGINE.md
    - path: kernel/skills/DEVELOPMENT/tdd-cycle.md
    
  callbacks:
    on_complete: update-obsidian
    on_fail: notify-noir
```

### Noor's Agent Coordination Commands

```yaml
# Commands Noir uses to coordinate

/delegado spawn [agent-type] [task]
  # Example: /delegado spawn coder "Run TDD on auth module"

/delegado agents
  # Show registered agents and their status

/delegado status [agent-id]
  # Show specific agent's current task and context

/delegado delegate [hell-phase] [agent-id]
  # Manually delegate a HELL phase to a specific agent
  
/delegado sync
  # Force sync all agents' context to Obsidian
  
/delegado hell:milestone [type]
  # Run milestone gate (aggregates all agents' work)
```

---

## 8. OBSIDIAN MULTI-AGENT VAULT STRUCTURE

```
~/Obsidian/Delegado-OS/
├── 00-INBOX/                    # Auto-captured by all agents
├── 01-PROJECTS/
│   └── [ProjectName]/
│       ├── specs/
│       ├── tdd/
│       ├── refactor/
│       ├── decisions/
│       ├── debt/
│       └── milestones/
├── 02-PATTERNS/
│   ├── GRASP/
│   └── GoF/
├── 03-DASHBOARDS/
│   ├── HELL-Overview.md        # All phases, all agents
│   ├── HELL-Agent-Status.md    # What each agent is doing
│   ├── HELL-Debt-Dashboard.md
│   └── HELL-TDD-Coverage.md
├── 04-AGENTS/                  # Agent-specific notes
│   ├── NOIR/
│   │   ├── memory/
│   │   ├── preferences/
│   │   └── active-tasks.md
│   ├── HERMES/
│   │   ├── orchestration-log.md
│   │   └── agent-registry.md
│   └── CLAUDE-CODE/
│       └── task-history.md
├── 05-SHARED-CONTEXT/          # Agent-agnostic state
│   ├── shared-context.md
│   └── hell-cycles.md
└── 06-ARCHIVE/
```

### Agent-Specific Dashboards

```markdown
# HELL Agent Status (04-AGENTS/hermes/agent-registry.md)

```dataview
TABLE agent_id, type, hell_phase_specialty, status
FROM "04-AGENTS"
WHERE type = "super-agent" OR type = "specialist"
SORT status DESC
```

---

## 9. INTEGRATION CHECKLIST

### For OpenClaw (Noir)

```yaml
OpenClaw_Integration:
  steps:
    1. [x] Read META-PROMPTING.md
    2. [x] Load kernel/hell/HELL-CORE-ENGINE.md on HELL triggers
    3. [ ] Link Obsidian vault (if exists)
    4. [ ] Enable sessions_spawn for sub-agents
    5. [ ] Update BOOTSTRAP.md with Delegado OS philosophy
    6. [ ] Test: Spawn sub-agent for TDD cycle
```

### For Hermes (Meta-Orchestrator)

```yaml
Hermes_Integration:
  steps:
    1. [ ] Create agent registry in Obsidian
    2. [ ] Implement event bus
    3. [ ] Configure HELL phase delegation rules
    4. [ ] Set up shared context vault
    5. [ ] Enable cross-agent messaging
```

### For Claude Code / Codex

```yaml
CLI_Agent_Integration:
  steps:
    1. [x] SKILL.md installed via npm (@delegado/os-delegate)
    2. [x] Commands available via /delegado prefix
    3. [ ] Obsidian vault link configured
    4. [ ] HELL templates available in templates/hell/
    5. [ ] Test: Run /delegado hell:spec on a project
```

---

## 10. WORKING TOGETHER — Example Flow

```
USER: "Noir, preciso adicionar auth ao projeto"

NOIR (OpenClaw - Super-Agent):
├── 1. Analyze request
├── 2. Check MEMORY.md for project context
├── 3. Ask: "Novo módulo ou baseado em spec existente?"
│
USER: "Spec já existe em specs/hell-spec-auth.md"

NOIR:
├── 4. Load hell-spec-auth.md
├── 5. Decision: TDD phase needed
├── 6. Spawn CLAUDE-CODE sub-agent for TDD:
│   └── "Run TDD cycle on auth module per hell-spec-auth.md"
│
CLAUDE-CODE (spawned sub-agent):
├── 7. Read hell-spec-auth.md
├── 8. Run TDD Red/Green/Refactor
├── 9. Create/update hell-tdd-log-auth.md
├── 10. Commit with HELL convention
├── 11. Report completion to Noir
│
NOIR (receives result):
├── 12. Aggregate results
├── 13. Update Obsidian vault (hell-tdd-log-auth.md)
├── 14. Propose next: "REFACTOR? Auth providers need Strategy pattern."
│
USER: "Sim, refactor!"

NOIR:
├── 15. Spawn REVIEW sub-agent for refactor:
│   └── "Apply GoF Strategy pattern, extract AuthProvider interface"
│
REVIEW sub-agent:
├── 16. Smell detection → Conditional Complexity
├── 17. Apply Strategy + Factory Method
├── 18. Create HELL-ADR-001.md
├── 19. Report to Noir
│
NOIR:
├── 20. Update dashboard
├── 21. Suggest: "/delegado hell:milestone test" to gate
```

---

## 11. COMMAND REFERENCE FOR SUPER-AGENTS

| Command | Agent | Purpose |
|---------|-------|---------|
| `/delegado hell:spec` | Any | HELL Specification phase |
| `/delegado hell:tdd` | Any | HELL TDD cycle |
| `/delegado hell:refactor` | Any | HELL Refactor with GoF |
| `/delegado hell:evolve` | Any | CI/CD + Tech debt |
| `/delegado hell:audit` | Any | GRASP/SOLID compliance |
| `/delegado hell:review` | Any | Deep review + health score |
| `/delegado hell:milestone` | Any | Gate checkpoint |
| `/delegado spawn [type] [task]` | Super-Agent | Spawn sub-agent |
| `/delegado agents` | Super-Agent | List agent registry |
| `/delegado status [agent]` | Super-Agent | Agent status |
| `/delegado sync` | Any | Force Obsidian sync |
| `/delegado context` | Any | Show current shared context |

---

*Multi-Agent HELL. One framework. Infinite agents.*