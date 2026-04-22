# Delegado OS

> *"O contexto é poder. A memória é força. A execução é brutal."*

**AI Agent Operating System** — A meta-prompting framework for AI-assisted software development, integrating methodological workflows (BMAD, OpenSpec, GSD) with persistent memory and context engineering.

## Supported Agents

| Agent | Status | Installation |
|-------|--------|-------------|
| Claude Code | ✅ | `npm install -g @delegado/os-delegate` |
| GitHub Codex | ✅ | `npm install -g @delegado/os-delegate` |
| Cursor | ✅ | `npm install -g @delegado/os-delegate` |
| Bun | ✅ | `bun install @delegado/os-delegate` |

## Installation

### Via npm (recommended)

```bash
npm install -g @delegado/os-delegate
```

The `postinstall` script automatically detects and links the skill to Claude Code, Codex, and Cursor skills directories.

### Via Bun

```bash
bun install -g @delegado/os-delegate
```

### Verification

```bash
delegado --version
# Output: delegado-os 1.0.0
```

### Activation in Claude Code

After installation, type:

```
/delegado
```

## Quick Start

```bash
# Interactive menu
delegado

# Activate BMAD workflow
/delegado bmad

# Create proposal
/delegado propose my-feature

# View memory
/delegado memory
```

## Workflows

### BMAD (4 Phases)

4-phase method for structured development:

| Phase | Color | Artifacts |
|-------|-------|----------|
| ANALYSIS | #FF6B6B | proposal.md |
| PLANNING | #4ECDC4 | prd.md, specs.md |
| SOLUTIONING | #45B7D1 | architecture.md |
| IMPLEMENTATION | #96CEB4 | tasks.md, code |

### OpenSpec (Spec-Driven)

Spec-driven workflow from concept to implementation:

```
proposal ──► specs ──► design ──► tasks ──► implement
```

### GSD (Get Shit Done)

Atomic tasks and execution phases:

```
BRIEFING ──── ANALYSIS ──── DECOMPOSITION ──── EXECUTION ──── VALIDATION
```

## Commands

### Workflows

| Command | Description |
|---------|-------------|
| `/delegado bmad` | Activate BMAD Method |
| `/delegado propose [name]` | Create proposal |
| `/delegado specs` | Create specifications |
| `/delegado design` | Create design |
| `/delegado tasks` | Generate tasks |

### Memory

| Command | Description |
|---------|-------------|
| `/delegado memory` | View memory |
| `/delegado memory:rules` | View learned rules |
| `/delegado learn [rule]` | Teach new rule |
| `/delegado feedback [text]` | Register feedback |

### Context

| Command | Description |
|---------|-------------|
| `/delegado context` | Load context |
| `/delegado context:save` | Save context |
| `/delegado context:load` | Load context |

## Package Structure

```
@delegado/os-delegate/
├── SKILL.md              # Entry point for agents
├── CLAUDE.md            # Instructions for Claude Code
├── delegado.sh          # CLI executable
├── kernel/
│   ├── skills/         # Sub-skills (ANALISE, EXECUCAO, etc.)
│   └── ...
├── workflows/          # BMAD, OpenSpec, GSD
├── subagents/          # Orchestrator
├── memory/             # Persistent memory
└── scripts/
    └── postinstall.js   # Auto-link installer
```

## Configuration

The system looks for configuration in `.delegado/config.yaml`:

```yaml
schema: spec-driven
workflows:
  - id: especificacao
  - id: bmad
  - id: fase
defaults:
  pr_size: medium
  coverage: 80
  tdd: true
```

## CLI

```bash
# Interactive menu
delegado

# Show version
delegado --version

# Initial setup
delegado setup

# Detect stack
delegado detectar
```

## Public API

For programmatic use:

```javascript
import { execSync } from 'child_process';

// Check version
execSync('delegado --version', { stdio: 'inherit' });
```

## License

MIT
