# Example: Database Comparison Research with Delegado OS

## Scenario
Compare PostgreSQL vs MongoDB vs Redis for a real-time analytics workload.

## Using RESEARCHER Mode

```bash
./delegado.sh researcher "Compare databases for real-time analytics: PostgreSQL vs MongoDB vs Redis"
```

## Evaluation Criteria

| Criterion | PostgreSQL | MongoDB | Redis |
|-----------|------------|---------|-------|
| Data Model | Relational | Document | Key-Value |
| Query Language | SQL | MQL | Commands |
| Transactions | ACID | ACID (single doc) | Lua scripts |
| Scalability | Vertical + partitioning | Horizontal sharding | Vertical + clustering |
| Latency (p99) | 5-15ms | 3-10ms | <1ms |
| Use Case Fit | Analytics | Operational | Caching |

## Benchmark Results (Synthetic)

### Write Performance (ops/sec)
```
Redis:      150,000+
MongoDB:    45,000
PostgreSQL: 25,000
```

### Read Performance (ops/sec)
```
Redis:      200,000+
MongoDB:    65,000
PostgreSQL: 85,000 (indexed)
```

### Storage Efficiency
```
PostgreSQL: 1.2x raw data
MongoDB:    1.5x raw data (WiredTiger)
Redis:      2-5x raw data (persistence)
```

## Decision Matrix

| Requirement | PostgreSQL | MongoDB | Redis |
|-------------|-----------|---------|-------|
| Complex joins | ✅ Best | ⚠️ Limited | ❌ No |
| Flexible schema | ⚠️ ALTER TABLE | ✅ Native | N/A |
| Real-time analytics | ⚠️ Materialized views | ⚠️ Aggregation | ✅ Streams |
| Full-text search | ✅ pg_trgm/GIN | ✅ Atlas Search | ⚠️ Module |
| Geospatial queries | ✅ PostGIS | ✅ Native | ⚠️ Module |

## Recommendation

**For Real-Time Analytics Dashboard:**

1. **Primary**: Redis (sub-millisecond reads for dashboard metrics)
2. **Secondary**: PostgreSQL (historical analysis, complex queries)
3. **Caching Layer**: Redis in front of both

**Architecture:**
```
Dashboard -> Redis (hot data) -> PostgreSQL (cold data)
                            -> MongoDB (event log)
```

## HELL Method Application

Using the HELL Core Engine (GRASP + GoF + TDD):

1. **Creator**: ResearchService orchestrates comparison
2. **Expert**: Each database adapter implements StorageExpert interface
3. **Strategy**: QueryStrategy pattern for different query types
4. **Observer**: BenchmarkResultsPublisher notifies subscribers
