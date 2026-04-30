# Delegado OS CLI Reference

## delegate.sh

Main orchestrator script for Delegado OS.

### Usage

```bash
./scripts/delegate.sh <command> [options]
```

### Commands

#### Mode Management

```bash
# Activate a mode
./scripts/delegate.sh activate <MODE>

# List all available modes
./scripts/delegate.sh modes

# Show mode information
./scripts/delegate.sh info <MODE>

# Deactivate current mode
./scripts/delegate.sh deactivate
```

#### Obsidian Integration

```bash
# Sync content to Obsidian
./scripts/delegate.sh sync <file> [title]

# Create new Obsidian note
./scripts/delegate.sh note <MODE> <title>

# Open vault
./scripts/delegate.sh open-vault
```

#### Context7 Search

```bash
# Search documentation
./scripts/delegate.sh search <query>

# Search with Context7 API
./scripts/delegate.sh context7 <query>

# List recent searches
./scripts/delegate.sh search-history
```

#### Workflows

```bash
# Run a workflow
./scripts/delegate.sh run-workflow <workflow.yaml>

# List available workflows
./scripts/delegate.sh list-workflows

# Show workflow info
./scripts/delegate.sh workflow-info <workflow.yaml>
```

#### Development

```bash
# Create new mode
./scripts/delegate.sh create-mode <NAME>

# Generate hooks for mode
./scripts/delegate.sh create-hooks <MODE>

# Run tests
./scripts/delegate.sh test

# Self-improve
./scripts/delegate.sh improve
```

#### HELL Framework

```bash
# Start HELL session
./scripts/delegate.sh hell

# Resume HELL session
./scripts/delegate.sh hell --resume

# Show HELL status
./scripts/delegate.sh hell --status

# Jump to phase
./scripts/delegate.sh hell --phase <H|E|L|L>
```

### Options

```bash
--help, -h          Show this help
--verbose, -v        Verbose output
--debug             Debug mode
--config <file>     Use custom config
--vault <path>      Use custom vault path
```

### Examples

```bash
# Basic usage
./scripts/delegate.sh activate PROFESSOR
./scripts/delegate.sh modes
./scripts/delegate.sh info DEBUGGER

# With Context7
./scripts/delegate.sh search "fastapi best practices"
./scripts/delegate.sh context7 "react state management patterns"

# Workflows
./scripts/delegate.sh run-workflow workflows/workflow-code-review.yaml

# Development
./scripts/delegate.sh create-mode AUDITOR
./scripts/delegate.sh create-hooks AUDITOR
./scripts/delegate.sh improve

# HELL
./scripts/delegate.sh hell --phase educate
./scripts/delegate.sh hell --resume m2_education
```

---

## auto_improve.sh

Self-analysis and improvement script.

### Usage

```bash
./scripts/auto_improve.sh <command> [options]
```

### Commands

```bash
# Run all analysis
./scripts/auto_improve.sh all

# Analyze mode performance
./scripts/auto_improve.sh analyze --mode <MODE>

# Generate reports
./scripts/auto_improve.sh report --type <skills|links|prompts>

# Show statistics
./scripts/auto_improve.sh stats

# Diagnose issues
./scripts/auto_improve.sh diagnose
```

### Options

```bash
--mode <MODE>       Specific mode to analyze
--type <type>        Report type: skills, links, prompts, all
--output <file>      Output file (default: stdout)
--verbose, -v        Verbose output
```

### Examples

```bash
# Full analysis
./scripts/auto_improve.sh all

# Analyze specific mode
./scripts/auto_improve.sh analyze --mode PROFESSOR

# Generate all reports
./scripts/auto_improve.sh report --type all

# Show stats
./scripts/auto_improve.sh stats
```

---

## generate_docs.sh

Documentation generator.

### Usage

```bash
./scripts/generate_docs.sh [options]
```

### Options

```bash
--modes              Generate mode documentation
--plugins            Generate plugin documentation
--workflows          Generate workflow documentation
--all                Generate all documentation
--output <dir>       Output directory
--index              Update index file
```

### Examples

```bash
# Generate all docs
./scripts/generate_docs.sh --all

# Generate mode docs only
./scripts/generate_docs.sh --modes

# Update index
./scripts/generate_docs.sh --index
```

---

## context7_search.sh

Context7 API search utility.

### Usage

```bash
./scripts/context7_search.sh [options] <query>
```

### Options

```bash
-v, --verbose        Verbose output
-l, --limit <n>      Limit results (default: 5)
-f, --format <fmt>   Output format: markdown, json, text
-o, --output <file>  Output file
```

### Examples

```bash
# Basic search
./scripts/context7_search.sh "python testing patterns"

# With limit
./scripts/context7_search.sh --limit 10 "typescript decorators"

# JSON output
./scripts/context7_search.sh --format json "rust async"
```

---

## mode_selector.sh

Interactive mode selector.

### Usage

```bash
./scripts/mode_selector.sh [options]
```

### Options

```bash
-i, --interactive    Interactive mode
-l, --list           List modes only
-d, --describe       Show mode descriptions
```

### Examples

```bash
# Interactive selection
./scripts/mode_selector.sh -i

# List with descriptions
./scripts/mode_selector.sh -l -d
```

---

## setup_obsidian_vault.sh

Obsidian vault setup utility.

### Usage

```bash
./scripts/setup_obsidian_vault.sh [vault_path]
```

### Examples

```bash
# Setup with default path
./scripts/setup_obsidian_vault.sh

# Setup custom vault
./scripts/setup_obsidian_vault.sh ~/my-projects/vault

# With env var
OBSIDIAN_VAULT=~/vault ./scripts/setup_obsidian_vault.sh
```

---

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DELEGADO_HOME` | Delegado OS installation path | `/root/projects/delegate-os` |
| `OBSIDIAN_VAULT` | Obsidian vault path | `~/obsidian-vault` |
| `CONTEXT7_API_KEY` | Context7 API key | - |
| `DELEGADO_CONFIG` | Config file path | `.delegado/config` |
| `DELEGADO_LOG_LEVEL` | Log level | `INFO` |

---

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 2 | Invalid arguments |
| 3 | Mode not found |
| 4 | Configuration error |
| 5 | Hook failed |
| 6 | Obsidian sync failed |
