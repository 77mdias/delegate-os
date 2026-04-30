# Delegado OS REST API Reference

**Version**: 1.0.0  
**Base URL**: `http://localhost:8080/api/v1`  
**Authentication**: Bearer token (via `DELEGADO_API_TOKEN` environment variable)

---

## Overview

The Delegado OS API provides programmatic access to agent orchestration, mode management, plugin execution, and workflow operations. The API follows REST conventions with JSON request/response bodies.

### Authentication

All API endpoints require authentication via Bearer token:

```bash
curl -H "Authorization: Bearer $DELEGADO_API_TOKEN" \
  http://localhost:8080/api/v1/status
```

### Error Format

All errors follow a consistent format:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": {}
  }
}
```

Common error codes:
- `UNAUTHORIZED` - Missing or invalid authentication
- `FORBIDDEN` - Insufficient permissions
- `NOT_FOUND` - Resource not found
- `VALIDATION_ERROR` - Invalid request parameters
- `INTERNAL_ERROR` - Server-side error

---

## Endpoints

### Health & Status

#### `GET /health`

Health check endpoint (no authentication required).

**Response**:
```json
{
  "status": "healthy",
  "version": "1.0.0",
  "uptime": 3600,
  "timestamp": "2024-01-15T10:30:00Z"
}
```

---

#### `GET /api/v1/status`

Returns current system status.

**Response**:
```json
{
  "mode": "auto",
  "active_agents": 3,
  "memory_usage": 512,
  "plugins": {
    "enabled": ["api-server", "obsidian-sync", "logging"],
    "disabled": ["kubernetes"]
  },
  "workflow": {
    "current": "bmad",
    "step": "implement"
  }
}
```

---

### Mode Management

#### `GET /api/v1/modes`

List all available modes.

**Response**:
```json
{
  "modes": [
    {
      "id": "guardian",
      "name": "Guardian",
      "description": "Security and compliance monitoring",
      "capabilities": ["security-audit", "vulnerability-scan", "compliance-check"]
    },
    {
      "id": "mentor",
      "name": "Mentor",
      "description": "Career development and learning guidance",
      "capabilities": ["career-roadmap", "skill-assessment", "learning-path"]
    },
    {
      "id": "consultant",
      "name": "Consultant",
      "description": "Strategic technical advisory",
      "capabilities": ["tech-strategy", "architecture-review", "cost-analysis"]
    },
    {
      "id": "architect",
      "name": "Architect",
      "description": "System design and architecture",
      "capabilities": ["system-design", "pattern-selection", "tradeoff-analysis"]
    },
    {
      "id": "professor",
      "name": "Professor",
      "description": "Technical education and training",
      "capabilities": ["lesson-planning", "code-review", "explanation"]
    },
    {
      "id": "researcher",
      "name": "Researcher",
      "description": "Deep research and analysis",
      "capabilities": ["literature-review", "benchmarking", "prototyping"]
    }
  ]
}
```

---

#### `GET /api/v1/modes/:mode_id`

Get details about a specific mode.

**Parameters**:
- `mode_id` (path) - Mode identifier

**Response**:
```json
{
  "id": "guardian",
  "name": "Guardian",
  "description": "Security and compliance monitoring",
  "capabilities": ["security-audit", "vulnerability-scan", "compliance-check"],
  "config": {
    "severity_threshold": "medium",
    "auto_remediate": false
  }
}
```

---

#### `POST /api/v1/modes/:mode_id/activate`

Activate a specific mode.

**Parameters**:
- `mode_id` (path) - Mode identifier

**Request Body**:
```json
{
  "config": {
    "severity_threshold": "high",
    "auto_remediate": true
  }
}
```

**Response**:
```json
{
  "success": true,
  "mode": "guardian",
  "activated_at": "2024-01-15T10:30:00Z"
}
```

---

#### `POST /api/v1/modes/:mode_id/deactivate`

Deactivate a specific mode.

**Response**:
```json
{
  "success": true,
  "mode": "guardian",
  "deactivated_at": "2024-01-15T11:00:00Z"
}
```

---

### Agent Management

#### `GET /api/v1/agents`

List all active agents.

**Response**:
```json
{
  "agents": [
    {
      "id": "agent-001",
      "mode": "guardian",
      "status": "active",
      "task": "security-audit",
      "started_at": "2024-01-15T09:00:00Z",
      "memory_usage": 128
    },
    {
      "id": "agent-002",
      "mode": "mentor",
      "status": "idle",
      "task": null,
      "started_at": "2024-01-15T08:00:00Z",
      "memory_usage": 64
    }
  ]
}
```

---

#### `GET /api/v1/agents/:agent_id`

Get details about a specific agent.

**Response**:
```json
{
  "id": "agent-001",
  "mode": "guardian",
  "status": "active",
  "task": {
    "id": "task-123",
    "type": "security-audit",
    "progress": 0.65,
    "started_at": "2024-01-15T09:00:00Z"
  },
  "capabilities": ["vulnerability-scan", "compliance-check"],
  "metrics": {
    "tasks_completed": 42,
    "errors": 2,
    "avg_response_time_ms": 250
  }
}
```

---

#### `POST /api/v1/agents/:agent_id/stop`

Stop a running agent.

**Response**:
```json
{
  "success": true,
  "agent_id": "agent-001",
  "stopped_at": "2024-01-15T10:30:00Z"
}
```

---

#### `POST /api/v1/agents/:agent_id/restart`

Restart an agent.

**Response**:
```json
{
  "success": true,
  "agent_id": "agent-001",
  "new_instance_id": "agent-001-restarted"
}
```

---

### Task Execution

#### `POST /api/v1/tasks`

Create and execute a new task.

**Request Body**:
```json
{
  "type": "security-audit",
  "mode": "guardian",
  "input": {
    "target": "/path/to/project",
    "scan_type": "full"
  },
  "config": {
    "timeout": 300,
    "priority": "high"
  }
}
```

**Response**:
```json
{
  "task_id": "task-456",
  "status": "queued",
  "created_at": "2024-01-15T10:30:00Z",
  "estimated_duration_seconds": 120
}
```

---

#### `GET /api/v1/tasks`

List tasks with optional filtering.

**Query Parameters**:
- `status` - Filter by status (queued, running, completed, failed)
- `mode` - Filter by mode
- `limit` - Maximum number of results (default: 20)
- `offset` - Pagination offset

**Response**:
```json
{
  "tasks": [
    {
      "task_id": "task-456",
      "type": "security-audit",
      "mode": "guardian",
      "status": "running",
      "progress": 0.35,
      "created_at": "2024-01-15T10:30:00Z"
    }
  ],
  "total": 42,
  "limit": 20,
  "offset": 0
}
```

---

#### `GET /api/v1/tasks/:task_id`

Get task details.

**Response**:
```json
{
  "task_id": "task-456",
  "type": "security-audit",
  "mode": "guardian",
  "status": "running",
  "progress": 0.65,
  "input": {
    "target": "/path/to/project",
    "scan_type": "full"
  },
  "result": null,
  "created_at": "2024-01-15T10:30:00Z",
  "started_at": "2024-01-15T10:30:05Z",
  "completed_at": null
}
```

---

#### `DELETE /api/v1/tasks/:task_id`

Cancel a running or queued task.

**Response**:
```json
{
  "success": true,
  "task_id": "task-456",
  "cancelled_at": "2024-01-15T10:35:00Z"
}
```

---

### Plugin Management

#### `GET /api/v1/plugins`

List all plugins.

**Response**:
```json
{
  "plugins": [
    {
      "id": "api-server",
      "name": "API Server",
      "version": "1.0.0",
      "enabled": true,
      "status": "running"
    },
    {
      "id": "obsidian-sync",
      "name": "Obsidian Sync",
      "version": "1.2.0",
      "enabled": true,
      "status": "running"
    },
    {
      "id": "kubernetes",
      "name": "Kubernetes",
      "version": "0.8.0",
      "enabled": false,
      "status": "disabled"
    }
  ]
}
```

---

#### `GET /api/v1/plugins/:plugin_id`

Get plugin details.

**Response**:
```json
{
  "id": "obsidian-sync",
  "name": "Obsidian Sync",
  "version": "1.2.0",
  "enabled": true,
  "status": "running",
  "description": "Synchronizes agent memory with Obsidian vault",
  "hooks": ["pre_task", "post_task", "on_error"],
  "config": {
    "vault_path": "./Obsidian",
    "sync_interval_seconds": 60,
    "auto_commit": true
  }
}
```

---

#### `POST /api/v1/plugins/:plugin_id/enable`

Enable a plugin.

**Response**:
```json
{
  "success": true,
  "plugin_id": "kubernetes",
  "enabled_at": "2024-01-15T10:30:00Z"
}
```

---

#### `POST /api/v1/plugins/:plugin_id/disable`

Disable a plugin.

**Response**:
```json
{
  "success": true,
  "plugin_id": "kubernetes",
  "disabled_at": "2024-01-15T10:30:00Z"
}
```

---

### Workflow Management

#### `GET /api/v1/workflows`

List available workflows.

**Response**:
```json
{
  "workflows": [
    {
      "id": "bmad",
      "name": "BMAD",
      "description": "Analyze, Implement, Verify, Deploy"
    },
    {
      "id": "gsd",
      "name": "Get Shit Done",
      "description": "Fast execution workflow"
    },
    {
      "id": "openspec",
      "name": "OpenSpec",
      "description": "Specification-driven development"
    }
  ]
}
```

---

#### `POST /api/v1/workflows/:workflow_id/execute`

Execute a workflow.

**Request Body**:
```json
{
  "task": "implement-feature-x",
  "context": {
    "feature": "user-authentication",
    "requirements": ["oauth2", "jwt", "refresh-tokens"]
  },
  "steps": ["analyze", "implement", "verify", "deploy"]
}
```

**Response**:
```json
{
  "execution_id": "exec-789",
  "workflow_id": "bmad",
  "status": "running",
  "current_step": "analyze",
  "created_at": "2024-01-15T10:30:00Z"
}
```

---

#### `GET /api/v1/workflows/:workflow_id/execute/:execution_id`

Get workflow execution status.

**Response**:
```json
{
  "execution_id": "exec-789",
  "workflow_id": "bmad",
  "status": "running",
  "current_step": "implement",
  "steps": {
    "analyze": {" status": "completed", "duration_ms": 5000 },
    "implement": { "status": "running", "progress": 0.4 },
    "verify": { "status": "pending" },
    "deploy": { "status": "pending" }
  },
  "created_at": "2024-01-15T10:30:00Z",
  "started_at": "2024-01-15T10:30:01Z"
}
```

---

### Memory & Knowledge

#### `GET /api/v1/memory`

Query the knowledge base.

**Query Parameters**:
- `q` - Search query
- `limit` - Maximum results (default: 10)

**Response**:
```json
{
  "results": [
    {
      "id": "note-123",
      "type": "obsidian",
      "title": "Security Audit Notes",
      "content_preview": "...found vulnerability in authentication module...",
      "relevance": 0.95
    }
  ],
  "total": 1
}
```

---

#### `POST /api/v1/memory`

Store a new memory entry.

**Request Body**:
```json
{
  "type": "obsidian",
  "title": "API Security Findings",
  "content": "Detailed security findings from audit...",
  "tags": ["security", "api", "audit"],
  "links": ["project-x", "architecture-doc"]
}
```

**Response**:
```json
{
  "success": true,
  "id": "note-456",
  "created_at": "2024-01-15T10:30:00Z"
}
```

---

#### `DELETE /api/v1/memory/:memory_id`

Delete a memory entry.

**Response**:
```json
{
  "success": true,
  "memory_id": "note-456",
  "deleted_at": "2024-01-15T10:30:00Z"
}
```

---

### Configuration

#### `GET /api/v1/config`

Get current configuration.

**Response**:
```json
{
  "core": {
    "mode": "auto",
    "language": "en",
    "autonomy_level": "medium"
  },
  "agent": {
    "max_iterations": 50,
    "context_window": 8192,
    "self_correct": true
  },
  "memory": {
    "backend": "obsidian",
    "graph_enabled": true,
    "retention_days": 90
  },
  "workflow": {
    "default": "bmad"
  }
}
```

---

#### `PATCH /api/v1/config`

Update configuration.

**Request Body**:
```json
{
  "core": {
    "mode": "guardian"
  },
  "agent": {
    "max_iterations": 100
  }
}
```

**Response**:
```json
{
  "success": true,
  "updated": ["core.mode", "agent.max_iterations"],
  "applied_at": "2024-01-15T10:30:00Z"
}
```

---

### Metrics & Observability

#### `GET /api/v1/metrics`

Get system metrics.

**Response**:
```json
{
  "system": {
    "cpu_usage": 0.45,
    "memory_usage": 512,
    "memory_total": 2048,
    "uptime": 3600
  },
  "agents": {
    "total": 5,
    "active": 2,
    "idle": 3
  },
  "tasks": {
    "queued": 3,
    "running": 2,
    "completed_today": 47,
    "failed_today": 2
  },
  "plugins": {
    "enabled": 12,
    "disabled": 3
  }
}
```

---

#### `GET /api/v1/metrics/prometheus`

Prometheus-formatted metrics (for scraping).

**Response**:
```
# HELP DelegadoOS_agent_tasks_completed_total Total completed tasks
# TYPE DelegadoOS_agent_tasks_completed_total counter
DelegadoOS_agent_tasks_completed_total{mode="guardian"} 42

# HELP DelegadoOS_memory_usage_bytes Memory usage in bytes
# TYPE DelegadoOS_memory_usage_bytes gauge
DelegadoOS_memory_usage_bytes 536870912
```

---

## Webhooks

Configure webhooks for event notifications via the `webhook` plugin:

```yaml
# plugins/webhook/manifest.yaml
events:
  - task.completed
  - task.failed
  - agent.started
  - agent.stopped
  - mode.changed
  - plugin.enabled
  - plugin.disabled
```

---

## Rate Limits

| Tier | Requests/minute | Burst |
|------|-----------------|-------|
| Default | 60 | 10 |
| Authenticated | 300 | 50 |
| Admin | 1000 | 100 |

---

## SDK Examples

### JavaScript/TypeScript

```typescript
import { DelegadoClient } from '@delegado-os/client';

const client = new DelegadoClient({
  baseUrl: 'http://localhost:8080/api/v1',
  token: process.env.DELEGADO_API_TOKEN
});

// List all agents
const agents = await client.agents.list();

// Activate Guardian mode
await client.modes.activate('guardian', {
  config: { severity_threshold: 'high' }
});

// Create and execute a task
const task = await client.tasks.create({
  type: 'security-audit',
  mode: 'guardian',
  input: { target: '/path/to/project' }
});
```

### Python

```python
import requests

class DelegadoClient:
    def __init__(self, base_url: str, token: str):
        self.base_url = base_url
        self.headers = {'Authorization': f'Bearer {token}'}
    
    def list_agents(self):
        resp = requests.get(f'{self.base_url}/agents', headers=self.headers)
        return resp.json()
    
    def activate_mode(self, mode_id: str, config: dict = None):
        data = {'config': config} if config else {}
        resp = requests.post(
            f'{self.base_url}/modes/{mode_id}/activate',
            json=data,
            headers=self.headers
        )
        return resp.json()
```

### cURL

```bash
# Health check
curl http://localhost:8080/health

# List tasks
curl -H "Authorization: Bearer $DELEGADO_API_TOKEN" \
  http://localhost:8080/api/v1/tasks

# Execute workflow
curl -X POST \
  -H "Authorization: Bearer $DELEGADO_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"task": "deploy-feature-x", "context": {"env": "staging"}}' \
  http://localhost:8080/api/v1/workflows/bmad/execute
```

---

## Changelog

| Version | Changes |
|---------|---------|
| 1.0.0 | Initial API release |
