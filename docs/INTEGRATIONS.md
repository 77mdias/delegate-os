# Integrations Guide

## Overview

Delegado OS integrates with various external tools and services.

## Available Integrations

### Obsidian (Primary)

**Purpose:** Knowledge management and documentation

**Features:**
- Automatic note creation
- Bidirectional sync
- Graph visualization
- Daily notes

**Setup:** See `docs/OBSIDIAN.md`

### GitHub

**Purpose:** Repository management and automation

**Features:**
- Issue creation
- PR management
- Repository setup
- Action triggering

**Setup:** `plugins/github/`

### Docker

**Purpose:** Containerization

**Features:**
- Development environments
- Consistent execution
- Isolation

**Setup:** `Dockerfile`, `docker-compose.yml`

### Kubernetes

**Purpose:** Production deployment

**Features:**
- Scaling
- Rolling updates
- Health monitoring

**Setup:** `plugins/kubernetes/`

### Monitoring

**Purpose:** Observability

**Features:**
- Prometheus metrics
- Grafana dashboards
- Alerting

**Setup:** `plugins/observability/`

### Notification Services

**Purpose:** Alerts and updates

**Features:**
- Slack/Discord
- Email
- Webhooks
- Telegram

**Setup:** `plugins/notification/`, `plugins/webhook/`

## Integration Configuration

```yaml
# configs/integrations.yaml
integrations:
  obsidian:
    enabled: true
    vault_path: ~/obsidian-vault
    
  github:
    enabled: true
    token_env: GITHUB_TOKEN
    
  docker:
    enabled: true
    
  kubernetes:
    enabled: false
    config_path: ~/.kube/config
    
  monitoring:
    enabled: false
    prometheus: http://localhost:9090
```

## Custom Integrations

### Creating a New Integration

1. Create plugin:
```bash
mkdir -p plugins/my-integration
```

2. Create manifest:
```yaml
# manifest.yaml
name: my-integration
version: 1.0.0
type: plugin
description: My custom integration
```

3. Implement hooks:
```bash
# hooks/on_activate.sh
#!/bin/bash
echo "Integration activated!"
```

4. Document:
```markdown
# docs/MY_INTEGRATION.md
Usage guide...
```
