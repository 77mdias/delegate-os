# ADR-003: Database Choice

**Status**: Accepted

**Date**: 2024-01-20

**Authors**: Delegado OS Team

**Deciders**: Delegado OS Team, Infrastructure Team

---

## Context

Delegado OS requires data persistence for:

| Data Type | Examples | Requirements |
|-----------|----------|--------------|
| Configuration | Plugin configs, user settings | Read-heavy, durability |
| State | Workflow state, agent memory | Fast reads/writes, consistency |
| Activity Logs | Agent actions, task history | High write throughput, time-series |
| Relationships | Agent-Plugin links, workflow steps | Graph queries, joins |
| Files/Blobs | Workflow definitions, artifacts | Large objects, streaming |

We evaluated:
- **PostgreSQL**: Relational, ACID, strong consistency
- **MongoDB**: Document, flexible schema, horizontal scaling
- **SQLite**: Embedded, zero-config, good for local/dev
- **Neo4j**: Graph, relationship-centric queries
- **TimescaleDB**: Time-series on PostgreSQL
- **Redis**: In-memory, caching, pub/sub

---

## Decision

We will use a **polyglot persistence** approach:

### Primary Database: PostgreSQL

For:
- User and resource management
- Plugin configurations
- Workflow definitions
- Agent state
- Audit logs

**Why PostgreSQL**:
- Mature, reliable, well-understood
- Excellent JSON support for flexible data
- Strong consistency for critical state
- Good performance with proper indexing
- Rich ecosystem and tooling

### Cache/Queue: Redis

For:
- Session caching
- Rate limiting
- Pub/sub messaging
- Job queues
- Temporary state

### Time-Series: TimescaleDB (PostgreSQL extension)

For:
- Agent activity logs
- Performance metrics
- Task execution history
- System monitoring

**Why TimescaleDB**:
- Same PostgreSQL, different use case
- Automatic time-based partitioning
- Compression for historical data
- Continuous aggregates

### Embedded: SQLite

For:
- Local development
- Single-user mode
- Mobile/edge deployments

### Object Storage: S3-compatible

For:
- Workflow artifacts
- Generated files
- Backup archives

---

## Data Architecture

```
┌─────────────┐     ┌─────────────┐
│   Client    │────▶│   REST API  │
└─────────────┘     └──────┬──────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Redis     │     │ PostgreSQL  │     │ TimescaleDB │
│  (Cache)    │     │ (Primary)   │     │  (Metrics)  │
└─────────────┘     └─────────────┘     └─────────────┘
        │                  │                  │
        │                  ▼                  │
        │           ┌─────────────┐           │
        │           │  SQLite     │           │
        │           │ (Local/Dev) │           │
        │           └─────────────┘           │
        │                                     │
        └────────────────┬──────────────────┘
                         │
                         ▼
                 ┌─────────────┐
                 │  S3/MinIO   │
                 │  (Blobs)    │
                 └─────────────┘
```

---

## Consequences

### Positive

- **Best tool for each job**: Each database excels at its specific use case
- **PostgreSQL reliability**: ACID guarantees for critical data
- **Redis performance**: Sub-millisecond caching
- **TimescaleDB**: Optimized for time-series without new infrastructure
- **Team expertise**: Team familiar with PostgreSQL

### Negative

- **Complexity**: Multiple systems to maintain
- **Consistency challenges**: Data across systems may drift
- **Operational overhead**: Backup, monitoring, upgrades for each
- **Connection management**: Multiple connection pools

### Neutral

- **SQLite limitations**: Not for production multi-user
- **Redis persistence**: Can lose data (mitigated by persistence config)

---

## Migration Strategy

### Phase 1: PostgreSQL Only (Current)
- All data in PostgreSQL
- Works for MVP
- Performance acceptable for <10k users

### Phase 2: Add Redis Caching
- Cache hot data
- Session management
- Rate limiting
- Read replicas for scaling

### Phase 3: TimescaleDB for Logs
- Migrate activity logs
- Set up retention policies
- Create continuous aggregates

### Phase 4: SQLite for Edge
- Local mode for offline
- Mobile app support

---

## Schema Overview

### PostgreSQL Core Tables

```sql
-- Users
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    password_hash VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Agents
CREATE TABLE agents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50),
    config JSONB DEFAULT '{}',
    state JSONB DEFAULT '{}',
    status VARCHAR(50) DEFAULT 'idle',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Plugins
CREATE TABLE plugins (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) UNIQUE NOT NULL,
    version VARCHAR(50),
    config JSONB DEFAULT '{}',
    enabled BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Workflows
CREATE TABLE workflows (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    name VARCHAR(255) NOT NULL,
    definition JSONB NOT NULL,
    status VARCHAR(50) DEFAULT 'draft',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### TimescaleDB for Metrics

```sql
-- Enable TimescaleDB
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Convert to hypertable
SELECT create_hypertable('agent_metrics', 'timestamp',
    chunk_time_interval => INTERVAL '1 day');

-- Continuous aggregate for hourly stats
CREATE MATERIALIZED VIEW agent_metrics_hourly
WITH (timescaledb.continuous) AS
SELECT time_bucket('1 hour', timestamp) AS bucket,
    agent_id,
    AVG(cpu_percent) AS avg_cpu,
    AVG(memory_mb) AS avg_memory,
    COUNT(*) AS event_count
FROM agent_metrics
GROUP BY bucket, agent_id;
```

---

## References

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [TimescaleDB Documentation](https://docs.timescale.com/)
- [Redis Persistence](https://redis.io/topics/persistence)
- [Polyglot Persistence](https://martinfowler.com/bliki/PolyglotPersistence.html)
