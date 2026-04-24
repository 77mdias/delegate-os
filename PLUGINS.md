# Delegado OS - Plugin System

> Extensible plugin architecture for adding custom agent modes, hooks, and integrations.

## Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    DELEGADO OS PLUGIN SYSTEM                  │
│                                                              │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐     │
│  │   PLUGIN    │    │   PLUGIN    │    │   PLUGIN    │     │
│  │   loader    │───▶│   hooks     │───▶│   modes     │     │
│  │             │    │             │    │             │     │
│  └─────────────┘    └─────────────┘    └─────────────┘     │
│         │                                              │     │
│         ▼                                              ▼     │
│  ┌─────────────────────────────────────────────────────┐     │
│  │                    CORE SYSTEM                      │     │
│  │         (META-PROMPTING, HELL, Obsidian)           │     │
│  └─────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

## Plugin Structure

```
plugins/
├── my-plugin/           # Plugin directory
│   ├── plugin.json      # Plugin manifest
│   ├── hooks/           # Custom hooks
│   │   └── pre_custom.sh
│   ├── modes/           # Custom agent modes
│   │   └── CUSTOM/
│   │       └── SKILL.md
│   ├── scripts/         # Custom scripts
│   │   └── custom_tool.sh
│   └── README.md        # Plugin documentation
```

## Plugin Manifest (plugin.json)

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "Description of my plugin",
  "author": "Your Name",
  "delegado_version": ">=1.0.0",
  "hooks": ["pre_custom", "post_custom"],
  "modes": ["CUSTOM"],
  "dependencies": {
    "other-plugin": ">=1.0.0"
  }
}
```

## Hook Plugins

### Creating a Hook

```bash
# plugins/my-plugin/hooks.d/pre_my_hook.sh
#!/bin/bash
# Hook called before 'my' operations

echo "[PLUGIN] pre_my_hook: Setting up context..."
export MY_PLUGIN_VAR="custom_value"

# Return 0 to continue, non-zero to abort
[ $SOME_CHECK = "ok" ] && exit 0 || exit 1
```

### Hook Types

| Hook Type | When Called | Use Case |
|-----------|-------------|----------|
| `pre_*` | Before mode/action | Setup context, validate |
| `post_*` | After mode/action | Cleanup, notify |
| `on_event_*` | On specific events | Event handling |
| `on_error` | On any error | Error handling |

## Custom Mode Plugins

### Creating a Custom Mode

```bash
# plugins/my-plugin/modes/ANALYST/SKILL.md
---
name: ANALYST
type: agent-mode
version: 1.0.0
---

# ANALYST Mode

## Identity
You are the ANALYST - Data analysis specialist.

## When Activated
Keywords: "analyze", "data", "insights", "metrics", "BI"

## Responsibilities
- Data exploration and profiling
- Statistical analysis
- Visualization recommendations
- Trend identification
- Report generation

## Guidelines
1. Always start with data quality assessment
2. Use appropriate statistical methods
3. Generate actionable insights
4. Sync findings to Obsidian vault

## Obsidian Sync
Path: `vault/80-ANALYTICS/`
```

## Script Plugins

```bash
# plugins/my-plugin/scripts/analyze_data.sh
#!/bin/bash
# Custom analysis tool

DATA_FILE="$1"
OUTPUT_DIR="$2"

# Your analysis logic here
python3 << EOF
import pandas as pd
df = pd.read_csv("$DATA_FILE")
print(df.describe())
EOF
```

## Plugin Installation

```bash
# Install a plugin
./scripts/delegado-ctl.sh plugin install ./plugins/my-plugin

# List installed plugins
./scripts/delegado-ctl.sh plugin list

# Enable/disable plugins
./scripts/delegado-ctl.sh plugin enable my-plugin
./scripts/delegado-ctl.sh plugin disable my-plugin

# Uninstall
./scripts/delegado-ctl.sh plugin uninstall my-plugin
```

## Plugin API

Plugins can access these environment variables:

| Variable | Description |
|----------|-------------|
| `DELEGADO_ROOT` | Delegado OS installation path |
| `DELEGADO_MODE` | Current active mode |
| `DELEGADO_SESSION_ID` | Current session ID |
| `DELEGADO_VAULT` | Obsidian vault path |
| `CONTEXT7_API_KEY` | Context7 API key |

## Creating a Plugin from Scratch

```bash
# 1. Create plugin structure
mkdir -p plugins/my-analytics-plugin/{hooks,modes/ANALYST,scripts}

# 2. Create manifest
cat > plugins/my-analytics-plugin/plugin.json << 'EOF'
{
  "name": "my-analytics-plugin",
  "version": "1.0.0",
  "description": "Data analytics mode for Delegado OS",
  "author": "Your Name",
  "delegado_version": ">=1.0.0",
  "modes": ["ANALYST"]
}
EOF

# 3. Create mode skill
cat > plugins/my-analytics-plugin/modes/ANALYST/SKILL.md << 'EOF'
# ANALYST Mode - see template above
EOF

# 4. Install
./scripts/delegado-ctl.sh plugin install ./plugins/my-analytics-plugin
```

## Official Plugins

| Plugin | Description | Status |
|--------|-------------|--------|
| `delegado/analytics` | Data analysis mode | Planned |
| `delegado/devops` | DevOps automation | Planned |
| `delegado/test` | Testing specialist | Planned |
| `delegado/security` | Security scanning | Planned |

---

*This file is part of Delegado OS*
