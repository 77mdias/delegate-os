# ❓ FAQ — Delegado OS

> Frequently Asked Questions about Delegado OS.

---

## General

### What is Delegado OS?

Delegado OS is an Agent Operating System — a multi-agent orchestration framework with a meta-prompting intelligence layer. It coordinates specialized agents (Professor, Architect, Debugger, Guardian, Researcher, Mentor) to handle different task types.

### What is the difference between Delegado OS and a single agent?

Single agents handle one task at a time with one personality. Delegado OS:
- **Automatically selects** the best mode for each task
- **Maintains persistent memory** via Obsidian integration
- **Uses structured workflows** (GSD, HELL, OpenSpec, BMAD)
- **Hooks into lifecycle events** via plugins for extensibility

### What is meta-prompting?

Meta-prompting is the intelligence layer that optimizes agent prompts based on:
- Current mode (Professor, Architect, etc.)
- Context (conversation history, project state)
- Learned patterns from previous sessions
- Task complexity and requirements

See `META-PROMPTING.md` for details.

---

## Installation & Setup

### How do I install Delegado OS?

```bash
git clone https://github.com/delegado-os/delegado-os.git
cd delegado-os
make install
make test
```

For Docker:
```bash
docker build -t delegado-os:latest .
docker run -d --name delegado-os -p 8080:8080 delegado-os:latest
```

### What are the system requirements?

- **OS**: Linux, macOS, or Windows (WSL2)
- **Runtime**: Bash 5.0+, Python 3.8+ (optional)
- **Memory**: 4GB minimum, 8GB recommended
- **Storage**: 1GB for base installation
- **Optional**: Docker/Podman, Kubernetes, Obsidian vault

### How do I configure environment variables?

```bash
cp configs/sample.config .env
nano .env
```

Key variables:
- `DELEGADO_MODE` — Default mode (e.g., `ORCHESTRATION`)
- `OBSIDIAN_VAULT_PATH` — Path to your Obsidian vault
- `SECRET_PROVIDER` — Secret manager backend (`env`, `vault`, `aws`)

---

## Modes & Personas

### How many modes are there?

Six primary modes:

| Mode | When to Use |
|------|-------------|
| **Professor** | Learning, teaching, explaining concepts |
| **Architect** | System design, pattern selection, ADRs |
| **Debugger** | Bug analysis, root cause, error investigation |
| **Guardian** | Security audits, compliance, access control |
| **Researcher** | Technology evaluation, widget search, code investigation |
| **Mentor** | Career advice, skill gaps, learning paths |

### How does the Mode Orchestrator work?

The Mode Orchestrator:
1. Analyzes user input (keywords, intent, stack)
2. Calculates task complexity
3. Matches against mode capabilities
4. Loads appropriate skills and context
5. Activates the mode

See `MODE-ORCHESTRATOR.md` for details.

### Can I force a specific mode?

Yes. Prefix your message with the mode name:
```
[ARCHITECT] Design a cache layer for our API
```

---

## Workflows

### Which workflow should I use?

| Workflow | Best For |
|----------|----------|
| **GSD** | Quick tasks, bug fixes, small features |
| **HELL** | New features requiring TDD and design patterns |
| **OpenSpec** | Large projects with formal specs |
| **BMAD** | Creative/brainstorming phases before formal development |

### What is the HELL Method?

HELL = High-level Engineering with LLM Logic:
1. **SPEC** — Define what to build
2. **TDD** — Write tests first
3. **REFACTOR** — Apply GRASP/GoF patterns
4. **EVOLVE** — Iterate based on feedback

Each phase has milestone gates that block progress until criteria are met.

### How do I create a custom workflow?

1. Create `workflows/myworkflow.yml` with phase definitions
2. Define artifacts, gates, and color scheme
3. Workflow is automatically available via CLI

---

## Plugins

### What plugins are available?

See `PLUGINS.md` for the full list. Key plugins:

| Plugin | Purpose |
|--------|---------|
| `container` | Docker/Podman management |
| `kubernetes` | K8s deployment and scaling |
| `analytics` | Usage metrics and reporting |
| `observability` | Metrics, logs, traces |
| `secret-manager` | Secure credential storage |
| `cicd` | Build and deployment automation |
| `backup` | Data backup and recovery |

### How do I enable/disable plugins?

Edit `config.yaml`:

```yaml
plugins:
  container:
    enabled: true
  kubernetes:
    enabled: false
```

### How do plugin hooks work?

Hooks are scripts triggered at lifecycle events:

```yaml
# In manifest.yaml
hooks:
  pre_deploy:
    script: hooks/pre_deploy.sh
  post_deploy:
    script: hooks/post_deploy.sh
```

The script receives environment variables and context about the event.

---

## Obsidian Integration

### Why does Delegado OS use Obsidian?

Obsidian provides:
- **Persistent memory** — Graph-based knowledge base
- **Dataview queries** — Dynamic dashboards
- **Links** — Automatic relationship mapping
- **Vault sync** — Access across devices

### How do I set up the Obsidian vault?

```bash
./scripts/setup_obsidian_vault.sh ~/my-vault
```

### What does Delegado OS sync to Obsidian?

- Session summaries
- Mode transitions
- Task completions
- Learning paths progress
- Metrics and analytics

---

## Troubleshooting

### "Command not found: delegado"

```bash
# Add to PATH
export PATH="$PATH:/path/to/delegado-os"

# Or use absolute path
./delegado.sh
```

### Docker container won't start

```bash
# Check logs
docker logs delegado-os

# Check resource limits
docker stats delegado-os

# Verify volume mounts exist
ls -la ~/obsidian-vault ~/.delegado
```

### Mode Orchestrator selecting wrong mode

1. Check keywords in your request
2. Explicitly prefix the mode: `[GUARDIAN] audit this code`
3. Review mode matching rules in `AGENT-MODES.md`

### Plugin hooks not firing

1. Verify plugin is enabled in `config.yaml`
2. Check script has execute permission: `chmod +x hooks/*.sh`
3. Review hook logs in `~/.delegado/logs/`

### Obsidian sync failing

```bash
# Check vault path
echo $OBSIDIAN_VAULT_PATH

# Verify write permissions
ls -la $OBSIDIAN_VAULT_PATH

# Run sync manually
./scripts/sync_obsidian.sh
```

---

## Contributing & Development

### How do I create a new plugin?

1. Copy `plugins/plugin_template` as a base
2. Define `manifest.yaml` with metadata and hooks
3. Implement hook scripts in `hooks/`
4. Add configuration defaults in `configs/`
5. Submit via pull request

### How do I add a new mode?

1. Create `modes/mymode/SKILL.md` with mode definition
2. Add mode to `AGENT-MODES.md` architecture diagram
3. Register in `MODE-ORCHESTRATOR.md` matching rules
4. Create example prompts in `examples/mymode/`

### How do I run tests?

```bash
make test          # Run all tests
make test PLUGIN=container  # Test specific plugin
./scripts/test.sh --watch  # Watch mode
```

---

## Performance & Optimization

### How can I improve response times?

1. **Enable caching** — Set `CACHE_ENABLED=true`
2. **Limit context** — Use `/context:compact` for long conversations
3. **Use local models** — For simpler tasks
4. **Disable unused plugins** — Reduce startup overhead

### What's the best resource configuration for Docker?

```yaml
deploy:
  resources:
    limits:
      cpus: '2'
      memory: 4G
    reservations:
      cpus: '1'
      memory: 2G
```

---

## Security

### How are secrets managed?

The `secret-manager` plugin supports:
- **env** — Environment variables (default, simple)
- **Vault** — HashiCorp Vault (production)
- **AWS** — AWS Secrets Manager
- **GCP** — GCP Secret Manager

### How do I audit my codebase?

Use Guardian mode:
```
[GUARDIAN] Full security audit of this codebase
```

Or run the HELL audit:
```
/dos-hell:audit
```
