# Delegado OS Best Practices

## Writing Effective Mode Prompts

### 1. Be Specific About Role and Context

**Good:**
```markdown
You are PROFESSOR mode, specializing in teaching TypeScript decorators.
Your student has 2 years of JavaScript experience but is new to decorators.
Focus on practical examples they can use in their React project.
```

**Bad:**
```markdown
You are a teacher. Teach me about decorators.
```

### 2. Include Output Format Expectations

**Good:**
```markdown
Output format:
- Concept explanation (100 words)
- 3 code examples (simple → complex)
- Common pitfalls (bullet list)
- Practice exercise
```

**Bad:**
```markdown
Explain decorators thoroughly.
```

### 3. Set Appropriate Constraints

```markdown
Constraints:
- Assume Node.js 18+
- No experimental features
- Focus on Angular use cases
- Keep explanations beginner-friendly
```

### 4. Provide Example Triggers

For each mode, document what activates it:

```markdown
## Triggers
- "me ensina...", "como funciona..."
- "explica o conceito de..."
- "tutorial sobre..."
- User is in learning phase, not implementation
```

## Structuring Your Obsidian Vault

### Recommended Folder Structure

```
vault/
├── 00-HELL/              # HELL framework data
│   ├── contexts/         # Saved contexts
│   ├── milestones/        # Milestone tracking
│   └── loops/            # Loop iterations
├── 00-PROFESSOR/         # Learning materials
│   ├── lessons/          # Lesson notes
│   ├── examples/         # Code examples
│   └── exercises/        # Practice problems
├── 00-ARCHITECT/         # Architecture docs
│   ├── proposals/        # Architecture proposals
│   ├── patterns/        # Pattern decisions (ADRs)
│   └── diagrams/        # Architecture diagrams
├── 00-DEBUGGER/         # Bug knowledge base
│   ├── bugs/            # Bug analyses
│   ├── fixes/           # Applied fixes
│   └── patterns/        # Recurring issues
├── 00-GUARDIAN/         # Security
│   ├── audits/          # Security audits
│   ├── vulnerabilities/  # Found issues
│   └── compliance/      # OWASP, GDPR, etc.
├── 00-RESEARCHER/        # Research
│   ├── tech-reviews/    # Technology evaluations
│   ├── benchmarks/      # Performance data
│   └── comparisons/     # Comparison reports
├── 00-MENTOR/           # Career
│   ├── sessions/        # Mentoring sessions
│   ├── learning/        # Learning paths
│   └── goals/          # Career goals
├── 00-CONSULTANT/       # Consulting
│   ├── proposals/       # Proposals
│   ├── feasibility/    # Feasibility studies
│   └── rfp/            # RFP responses
└── 00-ORCHESTRATION/    # Multi-agent
    ├── sessions/       # Orchestrated sessions
    └── results/        # Combined outputs
```

### Vault Configuration

Add to `.obsidian/workspace.json`:

```json
{
  "delegado-os": {
    "modes": ["PROFESSOR", "ARCHITECT", "DEBUGGER", "GUARDIAN", 
              "RESEARCHER", "MENTOR", "CONSULTANT", "ORCHESTRATION"],
    "sync_enabled": true,
    "auto_tag": true
  }
}
```

### Essential Vault Plugins

- **Templater**: For auto-generating session templates
- **Dataview**: For querying mode-specific notes
- **Tag Wrangler**: For managing tags
- **QuickAdd**: For quick session starts

## Creating New Modes

### Step 1: Define the Mode

Create `subagents/{MODE}/SKILL.md`:

```markdown
---
name: NEWMODE
type: agent-mode
version: 1.0.0
---

# NEWMODE Mode

## Identity
You are the [description].

## When Activated
Keywords: "..."

## Responsibilities
1. ...
2. ...

## Guidelines
[Detailed instructions]

## Obsidian Sync
Path: vault/00-NEWMODE/
```

### Step 2: Create Supporting Files

```
subagents/NEWMODE/
├── SKILL.md           # Core mode definition
├── NEWMODE.md         # Detailed guide
└── TEMPLATE.md        # Obsidian template
```

### Step 3: Create Hooks

```bash
scripts/hooks.d/pre_NEWMODE.sh
scripts/hooks.d/post_NEWMODE.sh
```

### Step 4: Add to Orchestrator

Update `MODE-ORCHESTRATOR.md` to include keyword triggers for the new mode.

### Step 5: Test

```bash
./scripts/delegate.sh activate NEWMODE
```

## Debugging Mode Issues

### Mode Not Activating

1. Check keywords match user input
2. Verify SKILL.md exists and is valid YAML
3. Check pre-hook exists and is executable
4. Review MODE-ORCHESTRATOR.md logic

### Poor Mode Output

1. Improve prompt specificity
2. Add more examples
3. Add constraints
4. Include output format

### Context Lost Between Modes

1. Check context file permissions
2. Verify post-hook runs successfully
3. Ensure pre-hook loads previous context
4. Check OBSIDIAN_VAULT path

### Hook Script Failures

```bash
# Debug hook
bash -x ./scripts/hooks.d/pre_DEBUGGER.sh

# Check permissions
ls -la ./scripts/hooks.d/

# View hook output
tail -f /tmp/delegado-hooks.log
```

## Workflow Best Practices

### Use Workflow YAML Files

For complex tasks, create workflow YAML:

```yaml
name: My Workflow
modes:
  - RESEARCHER
  - ARCHITECT
  - CODER
phases:
  phase_1_research:
    mode: RESEARCHER
    tasks:
      - ...
```

### Chain Modes Effectively

```
Simple task → Single mode
Multi-aspect → ORCHESTRATION with chained modes
Learning → RESEARCHER → PROFESSOR
```

### Set Clear Exit Criteria

In each phase:
```yaml
phase_1:
  mode: RESEARCHER
  output: Technology recommendation
  gate: At least 3 options compared
```

## Performance Optimization

### Reduce Mode Switching Overhead

- Batch similar tasks in one mode
- Use ORCHESTRATION for complex, multi-mode tasks
- Minimize context switches

### Optimize Hook Scripts

```bash
# Bad: Complex computation in hook
./scripts/hooks.d/pre_DEBUGGER.sh  # 30 seconds

# Good: Lightweight hook, defer heavy work
./scripts/hooks.d/pre_DEBUGGER.sh  # 0.5 seconds
# Heavy work done in background
```

### Context File Management

```bash
# Clean old contexts weekly
find .delegado/sessions -mtime +7 -delete

# Archive important sessions to Obsidian
./scripts/delegate.sh sync session-xxx
```

## Security Best Practices

### Hook Permissions

```bash
# Only owner can execute hooks
chmod 700 scripts/hooks.d/*.sh

# Group can read
chmod 640 subagents/*/SKILL.md
```

### Obsidian Vault Security

```bash
# Don't sync vault to git
echo "vault/" >> .gitignore

# Backup vault regularly
./scripts/backup_vault.sh
```

## Continuous Improvement

### Review Mode Performance

```bash
# Run auto-analysis
./scripts/auto_improve.sh all

# Check metrics
cat .delegado/metrics/sessions.jsonl | jq '.mode' | sort | uniq -c
```

### Update Mode Prompts

Based on feedback:
1. Collect user feedback
2. Identify pain points
3. Update SKILL.md
4. Test with real tasks
5. Deploy update

### Expand Mode Coverage

When to add new modes:
- Repeated multi-mode patterns
- Clear expertise area not covered
- User requests specific focus

## Community Guidelines

### Contributing Modes

1. Fork the repo
2. Create mode in `subagents/`
3. Add hooks in `scripts/hooks.d/`
4. Create Obsidian template
5. Submit PR with mode description

### Documentation Standards

- All modes must have SKILL.md
- Include practical examples
- Document known limitations
- Provide troubleshooting tips
