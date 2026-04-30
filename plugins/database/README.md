# Database Plugin

The Database Plugin provides comprehensive database operations, migrations, and query optimization for Delegado OS.

## Overview

This plugin standardizes database interactions across different database engines, providing consistent tooling for schema management, data migrations, and performance optimization.

## Features

### Migration Helper
Version-controlled database schema changes:
- Create and manage migrations
- Rollback support
- Migration status tracking
- Dependency resolution between migrations

### Query Optimizer
Analyze and optimize SQL queries:
- Explain plan analysis
- Missing index detection
- Query complexity scoring
- Optimization suggestions

### Schema Diff
Compare database schemas:
- Generate diff between two schemas
- Identify structural changes
- Migration script generation

### Data Validation
Validate data integrity:
- Schema validation
- Constraint checking
- Data quality metrics

### Backup & Restore
Database backup utilities:
- Full database backup
- Point-in-time recovery
- Incremental backups

### Index Analysis
Analyze and recommend indexes:
- Unused index detection
- Missing index recommendations
- Index usage statistics

## Supported Databases

| Database   | Status | Notes                    |
|------------|--------|--------------------------|
| PostgreSQL | ✓      | Full support             |
| MySQL      | ✓      | Full support             |
| SQLite     | ✓      | Limited to file-based ops|
| MongoDB    | Partial| Basic support            |

## Usage

### Migration Helper

```bash
./migration_helper.sh --action create --name add_users_table
./migration_helper.sh --action up --target 20240101000000
./migration_helper.sh --action down --steps 1
./migration_helper.sh --action status
```

Options:
- `--action` - Action to perform (create, up, down, status, rollback)
- `--name` - Migration name (for create action)
- `--target` - Target migration version (for up action)
- `--steps` - Number of steps to rollback (for down action)

### Query Optimizer

```bash
./query_optimizer.sh --query "SELECT * FROM users WHERE email = 'test@example.com'"
./query_optimizer.sh --query_file /path/to/query.sql --analyze
./query_optimizer.sh --explain_plan "EXPLAIN ANALYZE SELECT * FROM orders"
```

Options:
- `--query` - SQL query to analyze
- `--query_file` - Path to file containing SQL query
- `--analyze` - Perform deep analysis
- `--explain_plan` - Show query execution plan

## Configuration

Edit `manifest.yaml` to configure:

```yaml
configuration:
  default_timeout: 30
  max_connections: 10
  query_cache_size: 100
  log_slow_queries: true
  slow_query_threshold_ms: 1000
```

## Migration Workflow

### 1. Create a Migration

```bash
./migration_helper.sh --action create --name add_user_profiles_table
```

This creates a migration file in `migrations/` directory.

### 2. Edit the Migration

Edit the generated file to add your schema changes:

```sql
-- up migration
CREATE TABLE user_profiles (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- down migration
DROP TABLE user_profiles;
```

### 3. Run Migration

```bash
./migration_helper.sh --action up
```

### 4. Rollback if Needed

```bash
./migration_helper.sh --action down --steps 1
```

## Query Optimization Examples

### Basic Query Analysis

```bash
./query_optimizer.sh --query "SELECT * FROM orders WHERE status = 'pending'"
```

Output:
```
Query Complexity: LOW
Estimated Rows: 150
Suggestions:
  ✓ Consider adding index on orders(status)
  ✓ Use SELECT only needed columns instead of SELECT *
```

### Explain Plan Analysis

```bash
./query_optimizer.sh --explain_plan "EXPLAIN ANALYZE SELECT u.name, COUNT(o.id) 
FROM users u 
LEFT JOIN orders o ON u.id = o.user_id 
GROUP BY u.name"
```

### Index Recommendations

```bash
./query_optimizer.sh --analyze --query_file /path/to/queries.sql
```

## Integration with Mode System

| Mode | Integration Point |
|------|------------------|
| SPEC | Validate schema definitions |
| CODE | Generate database code |
| TEST | Create database tests |
| REVIEW | Audit query performance |
| DEBUG | Investigate data issues |
| SECURE | Check data permissions |
| OPTIMIZE | Optimize slow queries |

## Exit Codes

| Code | Meaning |
|------|--------|
| 0 | Success |
| 1 | General error |
| 2 | Database connection error |
| 3 | Migration error |
| 4 | Query timeout |
| 5 | Invalid SQL |

## See Also

- [Plugins Documentation](../../PLUGINS.md)
- [HELL Integration](../HELL-INTEGRATION.md)
- [Best Practices](../BEST-PRACTICES.md)
