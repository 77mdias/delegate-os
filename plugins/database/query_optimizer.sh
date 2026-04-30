#!/bin/bash
# Query Optimizer for Delegado OS
# Analyzes and optimizes SQL queries

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Default values
QUERY=""
QUERY_FILE=""
ANALYZE=false
EXPLAIN_PLAN=""
DB_TYPE="${DB_TYPE:-postgresql}"
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-delegado}"
DB_USER="${DB_USER:-postgres}"
DB_PASSWORD="${DB_PASSWORD:-}"

# Usage
usage() {
    cat << EOF
${GREEN}Query Optimizer for Delegado OS${NC}

Usage: $0 --query <sql> [options]
       $0 --query_file <file> [options]
       $0 --explain_plan <sql> [options]

Options:
  --query         SQL query to analyze
  --query_file    Path to file containing SQL query
  --explain_plan  Show query execution plan
  --analyze       Perform deep analysis
  --db-type       Database type [default: postgresql]
  --db-host       Database host [default: localhost]
  --db-port       Database port [default: 5432]
  --db-name       Database name [default: delegado]
  --db-user       Database user [default: postgres]
  --help          Show this help

Examples:
  $0 --query "SELECT * FROM users WHERE email = 'test@example.com'"
  $0 --query_file /path/to/query.sql --analyze
  $0 --explain_plan "EXPLAIN ANALYZE SELECT * FROM orders"

EOF
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --query)
            QUERY="$2"
            shift 2
            ;;
        --query_file)
            QUERY_FILE="$2"
            shift 2
            ;;
        --explain_plan)
            EXPLAIN_PLAN="$2"
            shift 2
            ;;
        --analyze)
            ANALYZE=true
            shift
            ;;
        --db-type)
            DB_TYPE="$2"
            shift 2
            ;;
        --db-host)
            DB_HOST="$2"
            shift 2
            ;;
        --db-port)
            DB_PORT="$2"
            shift 2
            ;;
        --db-name)
            DB_NAME="$2"
            shift 2
            ;;
        --db-user)
            DB_USER="$2"
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

# Get query from file if specified
if [[ -n "$QUERY_FILE" ]]; then
    if [[ ! -f "$QUERY_FILE" ]]; then
        echo -e "${RED}Error: Query file not found: $QUERY_FILE${NC}"
        exit 1
    fi
    QUERY=$(cat "$QUERY_FILE")
fi

# Ensure we have a query to analyze
if [[ -z "$QUERY" ]] && [[ -z "$EXPLAIN_PLAN" ]]; then
    echo -e "${RED}Error: Either --query, --query_file, or --explain_plan is required${NC}"
    usage
fi

# Get connection string
get_connection() {
    case "$DB_TYPE" in
        postgresql)
            echo "postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
            ;;
        mysql)
            echo "mysql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
            ;;
        *)
            echo ""
            ;;
    esac
}

# Run EXPLAIN on a query
run_explain() {
    local sql="$1"
    local analyze="$2"
    
    case "$DB_TYPE" in
        postgresql)
            if [[ "$analyze" == "true" ]]; then
                PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON) $sql" 2>/dev/null
            else
                PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "EXPLAIN (FORMAT JSON) $sql" 2>/dev/null
            fi
            ;;
        mysql)
            if [[ "$analyze" == "true" ]]; then
                mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -e "EXPLAIN ANALYZE $sql" 2>/dev/null
            else
                mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -e "EXPLAIN $sql" 2>/dev/null
            fi
            ;;
        *)
            echo -e "${RED}Unsupported database type: $DB_TYPE${NC}"
            exit 1
            ;;
    esac
}

# Analyze query complexity
analyze_complexity() {
    local sql="$1"
    local complexity="LOW"
    local score=0
    
    # Check for SELECT *
    if echo "$sql" | grep -qi "SELECT \*"; then
        ((score += 10))
    fi
    
    # Check for JOINs
    local join_count=$(echo "$sql" | grep -oi "JOIN" | wc -l)
    ((score += join_count * 15))
    
    # Check for subqueries
    local subquery_count=$(echo "$sql" | grep -oi "WHERE.*(SELECT\|FROM.*(SELECT" | wc -l)
    ((score += subquery_count * 20))
    
    # Check for LIKE with wildcards
    local like_count=$(echo "$sql" | grep -oi "LIKE '%" | wc -l)
    ((score += like_count * 5))
    
    # Check for ORDER BY
    if echo "$sql" | grep -qi "ORDER BY"; then
        ((score += 5))
    fi
    
    # Check for GROUP BY
    if echo "$sql" | grep -qi "GROUP BY"; then
        ((score += 10))
    fi
    
    # Check for DISTINCT
    if echo "$sql" | grep -qi "DISTINCT"; then
        ((score += 5))
    fi
    
    # Check for aggregate functions
    if echo "$sql" | grep -qiE "(COUNT|SUM|AVG|MIN|MAX)\("; then
        ((score += 5))
    fi
    
    # Determine complexity
    if [[ $score -gt 50 ]]; then
        complexity="HIGH"
    elif [[ $score -gt 20 ]]; then
        complexity="MEDIUM"
    fi
    
    echo "$complexity"
}

# Find potential missing indexes
find_missing_indexes() {
    local sql="$1"
    
    local indexes=()
    
    # Look for WHERE clause columns
    local where_columns=$(echo "$sql" | grep -oE "WHERE\s+(\w+\.)?\w+\s*=" | grep -oE "\w+\.\w+|\w+(?=\s*=)" | sort -u)
    
    for col in $where_columns; do
        # Skip keywords
        if [[ "$col" =~ (SELECT|FROM|WHERE|AND|OR|INSERT|UPDATE|DELETE|LIMIT|OFFSET) ]]; then
            continue
        fi
        indexes+=("Consider index on column used in WHERE: $col")
    done
    
    # Look for JOIN columns
    local join_columns=$(echo "$sql" | grep -oE "ON\s+\w+\.\w+\s*=\s*\w+\.\w+" | grep -oE "\w+\.\w+" | sort -u)
    for col in $join_columns; do
        if [[ "$col" =~ (SELECT|FROM|WHERE|AND|OR|INSERT|UPDATE|DELETE|LIMIT|OFFSET) ]]; then
            continue
        fi
        indexes+=("Consider index on JOIN column: $col")
    done
    
    # Look for ORDER BY columns
    local order_columns=$(echo "$sql" | grep -oE "ORDER BY\s+(\w+\.)?\w+" | grep -oE "\w+$" | sort -u)
    for col in $order_columns; do
        if [[ "$col" =~ (SELECT|FROM|WHERE|AND|OR|INSERT|UPDATE|DELETE|LIMIT|OFFSET) ]]; then
            continue
        fi
        indexes+=("Consider index on ORDER BY column: $col")
    done
    
    echo "${indexes[@]}"
}

# Generate optimization suggestions
generate_suggestions() {
    local sql="$1"
    local suggestions=()
    
    # SELECT * suggestion
    if echo "$sql" | grep -qi "SELECT \*"; then
        suggestions+=("Use specific column names instead of SELECT * to reduce data transfer")
    fi
    
    # LIKE optimization
    if echo "$sql" | grep -qi "LIKE '%"; then
        suggestions+=("LIKE with leading wildcard prevents index usage. Consider full-text search.")
    fi
    
    # DISTINCT optimization
    if echo "$sql" | grep -qi "DISTINCT"; then
        suggestions+=("DISTINCT can be expensive. Consider if duplicate filtering is necessary.")
    fi
    
    # COUNT(*) optimization
    if echo "$sql" | grep -qi "COUNT\(\*\)"; then
        suggestions+=("COUNT(*) scans the table. For large tables, consider maintaining a counter.")
    fi
    
    # No WHERE clause
    if ! echo "$sql" | grep -qi "WHERE"; then
        suggestions+=("Query has no WHERE clause. This may return unnecessary data.")
    fi
    
    # Multiple OR conditions
    local or_count=$(echo "$sql" | grep -oi "\bOR\b" | wc -l)
    if [[ $or_count -gt 3 ]]; then
        suggestions+=("Multiple OR conditions. Consider using IN or UNION for better performance.")
    fi
    
    # Subqueries
    if echo "$sql" | grep -qi "WHERE.*(SELECT"; then
        suggestions+=("Subquery in WHERE clause. Consider rewriting as JOIN for better performance.")
    fi
    
    echo "${suggestions[@]}"
}

# Show explain plan
show_explain_plan() {
    local plan_sql="${EXPLAIN_PLAN:-$QUERY}"
    local use_analyze="${ANALYZE:-false}"
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}   Query Execution Plan${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    echo -e "${CYAN}[Query]${NC}"
    echo "$plan_sql"
    echo ""
    
    echo -e "${YELLOW}[Analyzing...]${NC}"
    echo ""
    
    local result
    result=$(run_explain "$plan_sql" "$use_analyze") || true
    
    if [[ -z "$result" ]]; then
        echo -e "${RED}Could not get explain plan. Database may be unreachable or query invalid.${NC}"
        return 1
    fi
    
    echo -e "${CYAN}[Execution Plan]${NC}"
    echo "$result" | head -100
    echo ""
}

# Main analysis
analyze_query() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}   Query Optimization Analysis${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    echo -e "${CYAN}[Query]${NC}"
    echo "$QUERY"
    echo ""
    
    # Complexity analysis
    local complexity=$(analyze_complexity "$QUERY")
    echo -e "${CYAN}[Complexity Analysis]${NC}"
    echo "Complexity Score: $complexity"
    echo ""
    
    # Get table names
    local tables=$(echo "$QUERY" | grep -oE "FROM\s+(\w+\.)?\w+" | grep -oE "\w+$" | head -5)
    echo -e "${CYAN}[Tables Involved]${NC}"
    echo "$tables" | while read -r table; do
        echo "  - $table"
    done
    echo ""
    
    # Find missing indexes
    local indexes=$(find_missing_indexes "$QUERY")
    if [[ ${#indexes[@]} -gt 0 ]]; then
        echo -e "${CYAN}[Index Recommendations]${NC}"
        for idx in "${indexes[@]}"; do
            if [[ -n "$idx" ]]; then
                echo "  ✓ $idx"
            fi
        done
        echo ""
    fi
    
    # Generate suggestions
    local suggestions=$(generate_suggestions "$QUERY")
    if [[ ${#suggestions[@]} -gt 0 ]]; then
        echo -e "${YELLOW}[Optimization Suggestions]${NC}"
        for suggestion in "${suggestions[@]}"; do
            if [[ -n "$suggestion" ]]; then
                echo "  • $suggestion"
            fi
        done
        echo ""
    fi
    
    # Explain plan if analyzing
    if [[ "$ANALYZE" == "true" ]]; then
        show_explain_plan
    fi
    
    # Summary
    echo -e "${GREEN}[Summary]${NC}"
    echo "  Query Complexity: $complexity"
    echo "  Tables: $(echo "$tables" | wc -l)"
    echo "  Index Recommendations: ${#indexes[@]}"
    echo "  Suggestions: ${#suggestions[@]}"
}

# Main execution
main() {
    if [[ -n "$EXPLAIN_PLAN" ]]; then
        show_explain_plan
    elif [[ -n "$QUERY" ]] || [[ -n "$QUERY_FILE" ]]; then
        analyze_query
    fi
}

main "$@"
