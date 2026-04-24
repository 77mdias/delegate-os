# Delegado OS Performance Guide

**Version**: 1.0.0  
**Last Updated**: 2024-01-15

---

## Overview

This guide provides optimization strategies for maximizing Delegado OS performance across different workloads and deployment scenarios.

---

## Performance Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Delegado OS Kernel                       │
├──────────────┬──────────────┬──────────────┬────────────────┤
│   Guardian   │    Mentor    │  Consultant  │   Architect    │
│    Mode      │     Mode     │     Mode     │     Mode       │
├──────────────┴──────────────┴──────────────┴────────────────┤
│                    HELL Method Engine                        │
├─────────────────────────────────────────────────────────────┤
│              Memory Layer (Obsidian + Graph)                │
├─────────────────────────────────────────────────────────────┤
│                    Plugin Pipeline                           │
└─────────────────────────────────────────────────────────────┘
```

---

## Core Performance Tips

### 1. Memory Configuration

#### Enable Graph-Based Indexing

```bash
# Enable for faster relationship queries
MEMORY_GRAPH_ENABLED=true
MEMORY_AUTO_INDEX=true
```

Graph indexing improves query performance by **40-60%** for relationship-heavy workloads.

#### Configure Retention Appropriately

```bash
# Short retention for development
MEMORY_RETENTION_DAYS=7

# Long retention for production
MEMORY_RETENTION_DAYS=90
```

#### Cache Settings

```bash
CACHE_ENABLED=true
CACHE_TTL_SECONDS=3600
CACHE_MAX_SIZE_MB=512
```

### 2. Agent Parallelism

#### Task Parallelization

```yaml
# config.yaml
performance:
  max_parallel_tasks: 4
  task_batch_size: 10
  worker_threads: 2
```

#### Mode-Specific Optimization

| Mode | Recommended Parallelism | Reason |
|------|------------------------|--------|
| Guardian | High (4-8) | Independent security checks |
| Mentor | Low (1-2) | Sequential learning paths |
| Consultant | Medium (2-4) | Mixed I/O and computation |
| Architect | Low (1-2) | Heavy design reasoning |
| Researcher | High (4-8) | Parallel literature searches |

### 3. Context Window Management

```bash
# Optimal context settings
AGENT_CONTEXT_WINDOW=8192    # Standard workloads
AGENT_CONTEXT_WINDOW=16384   # Complex analysis
AGENT_CONTEXT_WINDOW=4096    # Memory-constrained
```

#### Context Trimming Strategy

For long-running agents, enable automatic context trimming:

```yaml
context:
  auto_trim: true
  trim_threshold: 0.9        # Trim at 90% capacity
  trim_preserve_recent: 0.3 # Keep last 30% of messages
```

---

## HELL Method Optimization

### TDD Performance

```yaml
hell:
  tdd:
    fast_fail: true          # Stop on first failure
    parallel_test_workers: 4
    cache_test_results: true
    
  grasp:
    cache_pattern_matches: true
    max_pattern_depth: 3
```

### GRASP Pattern Caching

```yaml
hell:
  grasp:
    cache_creator_assignments: true
    cache_controller_routing: true
```

Pattern caching reduces design decision time by **30-50%** for repetitive patterns.

---

## Plugin Performance

### Plugin Loading

#### Lazy Loading for Unused Plugins

```yaml
plugins:
  # Only load when explicitly needed
  lazy_load:
    - kubernetes
    - database
    - container
```

#### Plugin Ordering

Load high-frequency plugins first:

```yaml
plugins:
  load_order:
    - api-server      # Required for all API calls
    - obsidian-sync   # Memory critical
    - logging         # Observability
    - monitoring      # Metrics
    - kubernetes      # Lazy loaded
```

### Plugin Resource Limits

```yaml
plugins:
  resource_limits:
    max_memory_mb: 256
    max_cpu_percent: 50
    max_execution_time_seconds: 300
```

---

## Obsidian Integration Performance

### Sync Optimization

```yaml
obsidian:
  sync:
    interval_seconds: 60      # Default: 60
    batch_size: 50            # Notes per sync batch
    compression: true
    incremental: true        # Only sync changes
```

### For Large Vaults (>1000 notes)

```yaml
obsidian:
  sync:
    interval_seconds: 300     # 5 minutes
    batch_size: 100
    background_indexing: true
    graph_cache_enabled: true
```

### Dataview Query Optimization

```yaml
obsidian:
  dataview:
    cache_queries: true
    cache_ttl_seconds: 300
    max_results_per_query: 1000
```

---

## Database Performance

### Connection Pooling

```yaml
database:
  pool:
    min_size: 2
    max_size: 10
    idle_timeout_seconds: 30
    max_lifetime_seconds: 3600
```

### Query Optimization

```yaml
database:
  queries:
    timeout_seconds: 30
    retry_attempts: 3
    retry_delay_seconds: 1
    slow_query_threshold_ms: 1000
```

---

## Network Performance

### API Server Tuning

```yaml
api_server:
  workers: 4                 # Match CPU cores
  keepalive_timeout: 65
  request_timeout: 300
  max_request_size_mb: 10
  
  # For high-throughput scenarios
  worker_connections: 1000
  pipelining: true
  pipelining_requests: 10
```

### CORS Optimization

```yaml
api_server:
  cors:
    enabled: true
    # Use specific origins in production
    origins:
      - https://yourapp.com
    max_age_seconds: 86400    # Cache preflight
```

---

## Monitoring & Profiling

### Enable Detailed Metrics

```bash
METRICS_ENABLED=true
METRICS_PORT=9090
METRICSDetailed=true
```

### Key Metrics to Watch

| Metric | Target | Alert Threshold |
|--------|--------|-----------------|
| `agent.tasks.completed` | >10/min | <1/min |
| `memory.usage_percent` | <70% | >85% |
| `task.queue.depth` | <10 | >50 |
| `plugin.response_time_ms` | <100ms | >500ms |
| `obsidian.sync.latency_ms` | <1000ms | >5000ms |

### Prometheus Metrics

Access Prometheus-formatted metrics at:

```
GET /api/v1/metrics/prometheus
```

Key metrics:
- `DelegadoOS_agent_tasks_completed_total`
- `DelegadoOS_agent_tasks_failed_total`
- `DelegadoOS_memory_usage_bytes`
- `DelegadoOS_task_queue_depth`
- `DelegadoOS_obsidian_sync_latency_seconds`
- `DelegadoOS_plugin_execution_duration_seconds`

---

## Performance Benchmarks

### Reference Hardware

| Scenario | CPU | RAM | Tasks/min |
|----------|-----|-----|-----------|
| Light (1 mode) | 2 cores | 4 GB | 50 |
| Medium (3 modes) | 4 cores | 8 GB | 150 |
| Heavy (5 modes) | 8 cores | 16 GB | 400 |

### Optimization Results

| Optimization | Improvement |
|--------------|-------------|
| Enable graph indexing | +40-60% query speed |
| Plugin lazy loading | -30% memory usage |
| Context trimming | -50% memory for long sessions |
| Worker parallelism | +200% throughput |
| Query caching | -70% database load |

---

## Troubleshooting Slow Performance

### 1. High Memory Usage

```bash
# Check memory allocation
curl http://localhost:8080/api/v1/metrics | jq '.system.memory_usage'

# Clear memory cache
curl -X POST http://localhost:8080/api/v1/memory/clear-cache
```

### 2. Slow Task Queue

```bash
# Check queue depth
curl http://localhost:8080/api/v1/metrics | jq '.tasks.queued'

# Increase worker parallelism
curl -X PATCH http://localhost:8080/api/v1/config \
  -d '{"performance": {"max_parallel_tasks": 8}}'
```

### 3. Plugin Latency

```bash
# Check plugin response times
curl http://localhost:8080/api/v1/metrics | jq '.plugins'

# Disable problematic plugins
curl -X POST http://localhost:8080/api/v1/plugins/<plugin_id>/disable
```

### 4. Obsidian Sync Lag

```yaml
# Reduce sync interval for faster updates
obsidian:
  sync:
    interval_seconds: 30
```

---

## Best Practices Summary

1. **Enable graph indexing** for relationship-heavy workloads
2. **Configure appropriate retention** to balance memory vs. history
3. **Use lazy loading** for plugins not on critical path
4. **Tune worker count** to match CPU cores
5. **Enable caching** for repeated operations
6. **Monitor key metrics** and set alerts
7. **Batch Obsidian syncs** for large vaults
8. **Use connection pooling** for database plugins

---

## Performance Checklist

Before production deployment:

- [ ] Graph indexing enabled
- [ ] Memory retention configured
- [ ] Plugin lazy loading set up
- [ ] Worker count tuned
- [ ] Cache enabled with appropriate TTL
- [ ] Metrics and monitoring active
- [ ] Slow query thresholds set
- [ ] Connection pooling configured
- [ ] CORS origins restricted
- [ ] Context window sized appropriately
