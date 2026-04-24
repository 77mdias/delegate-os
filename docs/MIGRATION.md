# Delegado OS Migration Guide

**Version**: 1.0.0  
**Last Updated**: 2024-01-15

---

## Overview

This guide covers migration between major versions of Delegado OS, including breaking changes, deprecated features, and recommended upgrade paths.

---

## Migrating from v0.x to v1.0

### Breaking Changes

#### 1. Configuration Format

**Old format** (`config.yaml`):
```yaml
mode: auto
plugins:
  - api-server
  - obsidian-sync
```

**New format** (`config.yaml`):
```yaml
core:
  mode: auto
  
plugins:
  enabled:
    - api-server
    - obsidian-sync
  disabled: []
```

**Migration**:
```bash
# Automatic migration
./delegado.sh migrate --from v0.x --to v1.0
```

#### 2. Environment Variables

Renamed variables:

| Old Name | New Name |
|----------|----------|
| `DELEGADO_PLUGIN_PATH` | `DELEGADO_PLUGINS_PATH` |
| `DELEGADO_KERNEL_MODE` | `DELEGADO_KERNEL_MODE` (unchanged) |
| `AGENT_MAX_TASKS` | `AGENT_MAX_ITERATIONS` |

#### 3. API Changes

- Base URL changed from `/api` to `/api/v1`
- Response format now includes `error` wrapper for errors
- Authentication header changed from `X-API-Key` to `Authorization: Bearer`

**Old**:
```bash
curl -H "X-API-Key: $API_KEY" http://localhost:8080/api/tasks
```

**New**:
```bash
curl -H "Authorization: Bearer $DELEGADO_API_TOKEN" http://localhost:8080/api/v1/tasks
```

#### 4. Plugin Manifest

**Old manifest**:
```yaml
name: my-plugin
version: 1.0.0
hooks:
  - pre_start
  - post_stop
```

**New manifest**:
```yaml
name: my-plugin
version: 1.0.0
type: plugin
description: My plugin description
author: Author Name

hooks:
  pre_server_start:
    script: hooks/pre_server_start.sh
  post_server_stop:
    script: hooks/post_server_stop.sh

config:
  enabled: false
  priority: medium
```

### Manual Migration Steps

#### Step 1: Backup Configuration

```bash
# Backup current config
cp config.yaml config.yaml.backup
cp -r plugins plugins.backup
cp -r memory memory.backup
```

#### Step 2: Update Configuration

```bash
# Use migration tool
./delegado.sh migrate config --input config.yaml.backup --output config.yaml
```

#### Step 3: Update Plugins

Each plugin manifest needs updating:

```bash
# Check plugin compatibility
./delegado.sh migrate check-plugins

# Update plugin manifests
./delegado.sh migrate update-plugin --plugin my-plugin
```

#### Step 4: Migrate Memory Data

```bash
# Export memory from v0.x
./delegado.sh memory export --output memory-export.json

# Import to v1.0
./delegado.sh memory import --input memory-export.json
```

#### Step 5: Verify Migration

```bash
# Run verification
./delegado.sh migrate verify

# Test API
curl http://localhost:8080/api/v1/health
```

---

## Migrating from v0.9 to v0.10

### Configuration Changes

#### Workflow Definition

**Old**:
```yaml
workflow:
  default: bmad
  bmad_steps:
    - analyze
    - implement
    - verify
    - deploy
```

**New**:
```yaml
workflow:
  default: bmad
  bmad:
    steps:
      - analyze
      - implement
      - verify
      - deploy
    settings:
      fail_fast: true
      parallel_steps: false
```

### API Changes

- Added `mode` parameter to task creation
- Task types now validated against mode capabilities

---

## Plugin Migration

### Migrating v0.x Plugins to v1.0

#### Manifest Update

Create `manifest.yaml`:

```yaml
name: my-plugin
version: 1.0.0
type: plugin
description: Description of my plugin
author: Your Name

hooks:
  pre_server_start:
    script: hooks/pre_server_start.sh
  post_server_stop:
    script: hooks/post_server_stop.sh
  pre_task:
    script: hooks/pre_task.sh
  post_task:
    script: hooks/post_task.sh

config:
  enabled: false
  priority: medium
  
permissions:
  - memory.read
  - memory.write
  - agent.invoke
```

#### Create Hooks Directory

```bash
mkdir -p plugins/my-plugin/hooks
```

#### Update Entry Point

**Old** (direct execution):
```bash
#!/bin/bash
# plugins/my-plugin/run.sh
```

**New** (hook-based):
```bash
#!/bin/bash
# plugins/my-plugin/hooks/pre_server_start.sh
echo "Plugin initializing..."
```

### Plugin Compatibility Matrix

| Plugin | v0.x | v1.0 | Notes |
|--------|------|------|-------|
| api-server | Yes | Yes | Full support |
| obsidian-sync | Yes | Yes | Full support |
| logging | Yes | Yes | Full support |
| monitoring | Yes | Yes | Full support |
| kubernetes | Partial | Yes | Full rewrite |
| database | Yes | Yes | Full support |
| cicd | Yes | Yes | Full support |

---

## Data Migration

### Memory Format Changes

**Old format**:
```json
{
  "type": "note",
  "content": "...",
  "timestamp": 1234567890
}
```

**New format**:
```json
{
  "id": "note-123",
  "type": "obsidian",
  "title": "Note Title",
  "content": "...",
  "tags": ["tag1", "tag2"],
  "links": ["note-456"],
  "created_at": "2024-01-15T10:00:00Z",
  "updated_at": "2024-01-15T10:30:00Z"
}
```

### Export/Import Tool

```bash
# Export all data
./delegado.sh data export \
  --output ./migration-backup.tar.gz \
  --include-memory \
  --include-config \
  --include-plugins

# Import data
./delegado.sh data import \
  --input ./migration-backup.tar.gz \
  --mode merge  # or 'replace'
```

---

## API Migration

### Endpoint Changes

| Old Endpoint | New Endpoint | Notes |
|--------------|--------------|-------|
| `GET /api/status` | `GET /api/v1/status` | Versioned |
| `GET /api/modes` | `GET /api/v1/modes` | Versioned |
| `POST /api/tasks` | `POST /api/v1/tasks` | Versioned |
| `GET /api/memory` | `GET /api/v1/memory` | Versioned |
| `GET /metrics` | `GET /api/v1/metrics/prometheus` | Moved |

### Response Format Changes

**Old error format**:
```json
{
  "message": "Not found",
  "code": 404
}
```

**New error format**:
```json
{
  "error": {
    "code": "NOT_FOUND",
    "message": "Resource not found",
    "details": {
      "resource": "task",
      "id": "task-123"
    }
  }
}
```

### SDK Migration

#### JavaScript SDK

**Old**:
```javascript
const client = new DelegadoClient({ apiKey: 'xxx' });
await client.getStatus();
```

**New**:
```javascript
import { DelegadoClient } from '@delegado-os/client';
const client = new DelegadoClient({
  baseUrl: 'http://localhost:8080/api/v1',
  token: 'xxx'  // Bearer token
});
await client.getStatus();
```

---

## Rollback Procedure

If migration fails:

```bash
# Stop Delegado OS
./delegado.sh stop

# Restore backups
cp config.yaml.backup config.yaml
cp -r plugins.backup plugins
cp -r memory.backup memory

# Restart
./delegado.sh start --version v0.x
```

---

## Migration Timeline

| Phase | Duration | Actions |
|-------|----------|---------|
| Pre-migration | 30 min | Backup, assess changes |
| Configuration | 15 min | Run auto-migration |
| Plugin update | 30 min | Per-plugin updates |
| Data migration | 15 min | Export/import |
| Verification | 15 min | Test all systems |
| **Total** | **~2 hours** | |

---

## Getting Help

- **Documentation**: See `/docs` directory
- **Discord**: Join [Delegado OS Community](https://discord.gg/delegado-os)
- **Issues**: Report at https://github.com/delegado-os/delegado-os/issues

---

## Version History

| Version | Date | Major Changes |
|---------|------|---------------|
| 1.0.0 | 2024-01-15 | Initial stable release |
| 0.10.0 | 2023-12-01 | Workflow improvements |
| 0.9.0 | 2023-10-15 | Mode system introduced |
| 0.8.0 | 2023-08-01 | Plugin architecture |
| 0.7.0 | 2023-06-01 | Initial release |
