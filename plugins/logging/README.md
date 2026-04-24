# Logging Plugin

Centralized logging system for all Delegado OS agent activities.

## Features

- **Activity Logging**: Track all agent actions, tasks, and tool calls
- **Log Rotation**: Automatic rotation based on size and age
- **Multiple Outputs**: File, syslog, webhook destinations
- **Error Tracking**: Alert on error thresholds
- **Filtering**: Exclude noisy patterns, focus on important events

## Log Files

| File | Description |
|------|-------------|
| `agent.log` | All agent activities |
| `error.log` | Errors only |
| `activity.log` | High-level activity summary |

## Log Levels

| Level | Description |
|-------|-------------|
| DEBUG | Detailed debugging info |
| INFO | Normal operations |
| WARN | Warning conditions |
| ERROR | Error conditions |

## Configuration

Edit `manifest.yaml`:

```yaml
config:
  log_dir: ~/.delegado/logs
  log_level: info
  rotation:
    enabled: true
    max_size_mb: 100
    max_files: 10
    max_age_days: 30
```

## Hooks

### `on_agent_start`
Called when agent starts. Logs:
- Agent ID
- Mode
- Start time

### `on_agent_end`
Called when agent completes. Logs:
- Agent ID
- Duration
- Exit status

### `on_agent_error`
Called on agent error. Logs:
- Agent ID
- Error message
- Stack trace (if available)

### `on_tool_call`
Called on each tool invocation. Logs:
- Tool name
- Arguments
- Duration
- Success/failure

### `on_task_start` / `on_task_complete` / `on_task_fail`
Task lifecycle events. Logs:
- Task ID
- Task description
- Outcome

## Usage

### Log Activity Manually

```bash
~/.delegado/plugins/logging/hooks/on_task_start.sh "task_id=123" "description=Build widget"
```

### Query Logs

```bash
# Recent errors
tail -50 ~/.delegado/logs/error.log

# Agent activity
grep "AGENT" ~/.delegado/logs/agent.log | tail -20

# Tool calls
grep "TOOL_CALL" ~/.delegado/logs/activity.log
```

### Set Log Level

```bash
export LOG_LEVEL=debug  # Enable debug logging
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `LOG_LEVEL` | Override log level (debug, info, warn, error) |
| `LOG_DIR` | Override log directory |
| `LOG_FORMAT` | Override format (default, detailed, json) |

## Log Format

### Default
```
[2024-01-15 10:30:45] INFO | agent.main | Task completed successfully
```

### JSON
```json
{"timestamp":"2024-01-15T10:30:45Z","level":"INFO","source":"agent.main","message":"Task completed successfully"}
```

## Alerting

Configure error threshold alerting:

```yaml
config:
  alerting:
    error_threshold: 10
    error_window_minutes: 5
    notification_webhook: "https://hooks.example.com/logging"
```

When errors exceed threshold in window, POST to webhook:

```json
{
  "type": "error_threshold_exceeded",
  "count": 12,
  "window_minutes": 5,
  "recent_errors": [...]
}
```

## Troubleshooting

### Logs not appearing
- Check `enabled: true` in manifest.yaml
- Verify log directory is writable
- Check `LOG_LEVEL` is not set too high

### Large log files
Enable rotation in config, or manually rotate:
```bash
mv ~/.delegado/logs/agent.log ~/.delegado/logs/agent.log.old
kill -USR1 $(pgrep -f delegado)  # Reopen logs
```
