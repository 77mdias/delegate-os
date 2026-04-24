# Delegado OS - README

<div align="center">

![Delegado OS](https://img.shields.io/badge/Delegado-OS-blue?style=for-the-badge)
![Version](https://img.shields.io/badge/version-1.0.0-green?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-purple?style=for-the-badge)

**Meta-Prompting Agent System** — 24/7 autonomous development assistant

*“HELL is the center, Obsidian is the brain, automation is key”*

</div>

---

## 🎯 What is Delegado OS?

Delegado OS is a **meta-prompting framework** that transforms a base LLM into a specialized multi-agent system. Instead of one general-purpose AI, you get a team of expert agents, each optimized for a specific development task.

### Core Philosophy

```
┌─────────────────────────────────────────────────────────┐
│                    HELL FRAMEWORK                       │
│                                                          │
│   H = Hook (Trigger, Context)                           │
│   E = Educate (Learn, Analyze)                           │
│   L = Link (Connect, Synthesize)                         │
│   L = Loop (Iterate, Verify)                             │
│                                                          │
│   Obsidian = The Brain (Memory, Knowledge Base)          │
└─────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/your-org/delegado-os.git
cd delegado-os

# Activate PROFESSOR mode
./scripts/delegate.sh activate PROFESSOR

# Ask a question
> "Explain dependency injection in TypeScript"
```

## 👥 Agent Modes

| Mode | Purpose | Best For |
|------|---------|----------|
| **PROFESSOR** | Teaching & Learning | Learning new concepts, tutorials |
| **ARCHITECT** | System Design | Architecture proposals, patterns |
| **DEBUGGER** | Problem Solving | Bug analysis, root cause |
| **GUARDIAN** | Security | Security audits, OWASP compliance |
| **RESEARCHER** | Investigation | Tech comparisons, benchmarks |
| **MENTOR** | Career Growth | Career planning, skill development |
| **CONSULTANT** | Business Analysis | Feasibility, ROI, proposals |
| **ORCHESTRATION** | Multi-Agent | Complex, multi-phase tasks |

## 📁 Project Structure

```
delegado-os/
├── subagents/           # Agent mode definitions
│   ├── PROFESSOR/
│   ├── ARCHITECT/
│   ├── DEBUGGER/
│   ├── GUARDIAN/
│   ├── RESEARCHER/
│   ├── MENTOR/
│   ├── CONSULTANT/
│   └── ORCHESTRATION/
├── plugins/             # Extensibility system
│   ├── cicd/
│   ├── monitoring/
│   ├── obsidian-sync/
│   └── [custom plugins]
├── scripts/             # Automation scripts
│   ├── delegate.sh      # Main orchestrator
│   ├── hooks.d/         # Pre/post hooks
│   └── auto_improve.sh  # Self-analysis
├── workflows/           # Multi-mode workflows
├── templates/           # Obsidian templates
├── docs/                # Documentation
└── .delegado/           # Runtime data
```

## 🔌 Plugin System

Extend Delegado OS with plugins:

```yaml
# plugins/my-plugin/manifest.yaml
name: my-plugin
version: 1.0.0
hooks:
  pre_build:
    script: hooks/pre_build.sh
  post_build:
    script: hooks/post_build.sh
```

## 📚 Documentation

- [Quick Start](docs/QUICKSTART.md)
- [Agent Modes](AGENT-MODES.md)
- [HELL Integration](docs/HELL-INTEGRATION.md)
- [Best Practices](docs/BEST-PRACTICES.md)
- [Advanced Prompting](docs/ADVANCED-PROMPTING.md)
- [Mode Comparison](docs/MODE-COMPARISON.md)
- [Metrics Guide](docs/METRICS.md)

## 🔧 Configuration

### Environment Variables

```bash
export DELEGADO_HOME=/path/to/delegado-os
export OBSIDIAN_VAULT=~/obsidian-vault
export CONTEXT7_API_KEY=your-api-key
```

### Obsidian Setup

```bash
# Auto-setup vault structure
./scripts/setup_obsidian_vault.sh ~/my-vault

# Or manually configure in .delegado/config
echo "OBSIDIAN_VAULT=~/my-vault" > .delegado/config
```

## ⚡ Usage Examples

### Teaching Mode
```bash
./scripts/delegate.sh activate PROFESSOR
> "Teach me about microservices patterns"
```

### Debugging Mode
```bash
./scripts/delegate.sh activate DEBUGGER
> "This login flow is failing intermittently"
```

### Security Audit
```bash
./scripts/delegate.sh activate GUARDIAN
> "Review the authentication module for OWASP compliance"
```

### Multi-Agent Orchestration
```bash
./scripts/delegate.sh activate ORCHESTRATION
> "Design and implement a secure user auth system"
# → RESEARCHER (tech research)
# → ARCHITECT (design)
# → GUARDIAN (security)
# → CODER (implement)
```

## 🛠️ Development

### Creating a New Mode

```bash
# 1. Create mode directory
mkdir -p subagents/MYMODE

# 2. Create SKILL.md
cat > subagents/MYMODE/SKILL.md << 'EOF'
---
name: MYMODE
type: agent-mode
---

# MYMODE Mode

## Identity
You are [description]

## When Activated
Keywords: ["trigger", "keywords"]

## Responsibilities
1. ...
EOF

# 3. Create hooks
./scripts/delegate.sh create-hooks MYMODE

# 4. Test
./scripts/delegate.sh activate MYMODE
```

### Running Tests

```bash
# Self-analysis
./scripts/auto_improve.sh all

# Generate documentation
./scripts/generate_docs.sh

# Mode-specific analysis
./scripts/auto_improve.sh analyze --mode PROFESSOR
```

## 📊 Metrics

Track agent performance:

```bash
# View metrics dashboard
cat .delegado/metrics/sessions.jsonl | jq .

# Mode usage stats
./scripts/auto_improve.sh stats
```

## 🤝 Contributing

1. Fork the repository
2. Create your mode (`git checkout -b feature/mymode`)
3. Commit your changes (`git commit -m 'feat: add MYMODE'`)
4. Push to the branch (`git push origin feature/mymode`)
5. Open a Pull Request

## 📝 License

MIT License - see [LICENSE](LICENSE) file.

## 🙏 Acknowledgments

- HELL Framework: Hyper-Extreme Learning Loop methodology
- Obsidian: Knowledge base integration
- Context7: Documentation search
- All contributing developers

---

<div align="center">

**Built with 🔥 by developers, for developers**

*Delegado OS — Your 24/7 Development Team*

</div>
