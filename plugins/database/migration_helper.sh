#!/bin/bash
# Migration Helper for Delegado OS
# Manages database schema migrations

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Default values
ACTION=""
MIGRATION_NAME=""
TARGET_VERSION=""
STEPS=1
DB_TYPE="${DB_TYPE:-postgresql}"
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-delegado}"
DB_USER="${DB_USER:-postgres}"
DB_PASSWORD="${DB_PASSWORD:-}"

# Migration directory
MIGRATIONS_DIR="${MIGRATIONS_DIR:-$HOME/.delegado/migrations}"
MIGRATIONS_TABLE="schema_migrations"

# Usage
usage() {
    cat << EOF
${GREEN}Migration Helper for Delegado OS${NC}

Usage: $0 --action <action> [options]

Actions:
  create       Create a new migration
  up           Run pending migrations
  down         Rollback migrations
  status       Show migration status
  rollback     Rollback to a specific version

Options:
  --name          Migration name (for create action)
  --target        Target version (for up action)
  --steps         Number of steps to rollback [default: 1]
  --db-type       Database type [default: postgresql]
  --db-host       Database host [default: localhost]
  --db-port       Database port [default: 5432]
  --db-name       Database name [default: delegado]
  --db-user       Database user [default: postgres]
  --help          Show this help

Examples:
  $0 --action create --name add_users_table
  $0 --action up --target 20240101000000
  $0 --action down --steps 2
  $0 --action status

EOF
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --action)
            ACTION="$2"
            shift 2
            ;;
        --name)
            MIGRATION_NAME="$2"
            shift 2
            ;;
        --target)
            TARGET_VERSION="$2"
            shift 2
            ;;
        --steps)
            STEPS="$2"
            shift 2
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

# Validate required arguments
if [[ -z "$ACTION" ]]; then
    echo -e "${RED}Error: --action is required${NC}"
    usage
fi

# Ensure migrations directory exists
mkdir -p "$MIGRATIONS_DIR"

# Get current timestamp for version
get_version() {
    date +"%Y%m%d%H%M%S"
}

# Create a new migration
create_migration() {
    if [[ -z "$MIGRATION_NAME" ]]; then
        echo -e "${RED}Error: --name is required for create action${NC}"
        exit 1
    fi
    
    local version=$(get_version)
    local filename="${version}_${MIGRATION_NAME}.sql"
    local filepath="$MIGRATIONS_DIR/$filename"
    
    echo -e "${BLUE}[Migration Helper]${NC} Creating migration: $filename"
    
    cat > "$filepath" << 'EOF'
-- Migration: MIGRATION_NAME
-- Created: TIMESTAMP
-- Version: VERSION

-- UP Migration (apply changes)
BEGIN;

-- TODO: Add your SQL here

COMMIT;

-- DOWN Migration (rollback changes)
-- BEGIN;
-- TODO: Add rollback SQL here
-- COMMIT;
EOF
    
    # Replace placeholders
    sed -i "s/MIGRATION_NAME/$MIGRATION_NAME/g" "$filepath"
    sed -i "s/TIMESTAMP/$(date -u +"%Y-%m-%d %H:%M:%S")/g" "$filepath"
    sed -i "s/VERSION/$version/g" "$filepath"
    
    echo -e "${GREEN}✓ Migration created: $filepath${NC}"
    echo ""
    echo "Edit this file to add your SQL changes."
}

# Get database connection string
get_connection_string() {
    case "$DB_TYPE" in
        postgresql)
            echo "postgresql://${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
            ;;
        mysql)
            echo "${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
            ;;
        sqlite)
            echo "$DB_NAME.db"
            ;;
        *)
            echo ""
            ;;
    esac
}

# Check if migrations table exists
migrations_table_exists() {
    case "$DB_TYPE" in
        postgresql)
            PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = '$MIGRATIONS_TABLE');" 2>/dev/null | grep -q "t"
            ;;
        mysql)
            mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -e "DESCRIBE $MIGRATIONS_TABLE;" >/dev/null 2>&1
            ;;
        sqlite)
            sqlite3 "$DB_NAME.db" ".schema $MIGRATIONS_TABLE" >/dev/null 2>&1
            ;;
        *)
            false
            ;;
    esac
}

# Initialize migrations table
init_migrations_table() {
    echo -e "${YELLOW}[Migration Helper]${NC} Initializing migrations table..."
    
    case "$DB_TYPE" in
        postgresql)
            PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << 'EOF'
CREATE TABLE IF NOT EXISTS schema_migrations (
    version VARCHAR(14) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(name)
);
EOF
            ;;
        mysql)
            mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" << 'EOF'
CREATE TABLE IF NOT EXISTS schema_migrations (
    version VARCHAR(14) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(name)
);
EOF
            ;;
        sqlite)
            sqlite3 "$DB_NAME.db" << 'EOF'
CREATE TABLE IF NOT EXISTS schema_migrations (
    version VARCHAR(14) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF
            ;;
    esac
    
    echo -e "${GREEN}✓ Migrations table initialized${NC}"
}

# Get applied migrations
get_applied_migrations() {
    case "$DB_TYPE" in
        postgresql)
            PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT version FROM $MIGRATIONS_TABLE ORDER BY version;" 2>/dev/null | tr -d ' ' | grep -v '^$'
            ;;
        mysql)
            mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -sN -e "SELECT version FROM $MIGRATIONS_TABLE ORDER BY version;" 2>/dev/null
            ;;
        sqlite)
            sqlite3 "$DB_NAME.db" "SELECT version FROM $MIGRATIONS_TABLE ORDER BY version;" 2>/dev/null
            ;;
    esac
}

# Get pending migrations
get_pending_migrations() {
    local applied=($(get_applied_migrations))
    local applied_set=$(printf '%s\n' "${applied[@]}" | sort)
    
    for file in "$MIGRATIONS_DIR"/*.sql; do
        if [[ -f "$file" ]]; then
            local filename=$(basename "$file")
            local version=${filename%%_*}
            
            if ! echo "$applied_set" | grep -qx "$version"; then
                echo "$file"
            fi
        fi
    done | sort
}

# Apply a single migration
apply_migration() {
    local filepath="$1"
    local filename=$(basename "$filepath")
    local version=${filename%%_*}
    local name=${filename#*_}
    name=${name%.sql}
    
    echo -e "${YELLOW}[Migration Helper]${NC} Applying: $filename"
    
    # Extract UP migration (between BEGIN and first COMMIT that's not part of a statement)
    local up_sql=$(sed -n '/-- UP Migration/,/-- DOWN Migration/p' "$filepath" | sed '1d;$d' | sed '/^--/d')
    
    # Add version record
    case "$DB_TYPE" in
        postgresql)
            PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
BEGIN;
$up_sql
INSERT INTO $MIGRATIONS_TABLE (version, name) VALUES ('$version', '$name')
ON CONFLICT (version) DO NOTHING;
COMMIT;
EOF
            ;;
        mysql)
            mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" << EOF
START TRANSACTION;
$up_sql
INSERT INTO $MIGRATIONS_TABLE (version, name) VALUES ('$version', '$name')
ON DUPLICATE KEY UPDATE name = name;
COMMIT;
EOF
            ;;
        sqlite)
            sqlite3 "$DB_NAME.db" << EOF
BEGIN TRANSACTION;
$up_sql
INSERT OR IGNORE INTO $MIGRATIONS_TABLE (version, name) VALUES ('$version', '$name');
COMMIT;
EOF
            ;;
    esac
    
    echo -e "${GREEN}✓ Applied: $filename${NC}"
}

# Rollback a single migration
rollback_migration() {
    local version="$1"
    local filepath
    for file in "$MIGRATIONS_DIR"/*"${version}"*.sql; do
        if [[ -f "$file" ]]; then
            filepath="$file"
            break
        fi
    done
    
    if [[ -z "$filepath" ]]; then
        echo -e "${RED}Error: Could not find migration for version $version${NC}"
        return 1
    fi
    
    local filename=$(basename "$filepath")
    echo -e "${YELLOW}[Migration Helper]${NC} Rolling back: $filename"
    
    # Extract DOWN migration
    local down_sql=$(sed -n '/-- DOWN Migration/,/^$/p' "$filepath" | sed '1d;/^--/d' | sed '/^$/d')
    
    case "$DB_TYPE" in
        postgresql)
            PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
BEGIN;
$down_sql
DELETE FROM $MIGRATIONS_TABLE WHERE version = '$version';
COMMIT;
EOF
            ;;
        mysql)
            mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" << EOF
START TRANSACTION;
$down_sql
DELETE FROM $MIGRATIONS_TABLE WHERE version = '$version';
COMMIT;
EOF
            ;;
        sqlite)
            sqlite3 "$DB_NAME.db" << EOF
BEGIN TRANSACTION;
$down_sql
DELETE FROM $MIGRATIONS_TABLE WHERE version = '$version';
COMMIT;
EOF
            ;;
    esac
    
    echo -e "${GREEN}✓ Rolled back: $filename${NC}"
}

# Run pending migrations
run_migrations_up() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}   Delegado OS Migration Helper${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    # Check if migrations table exists
    if ! migrations_table_exists; then
        init_migrations_table
    fi
    
    local pending=($(get_pending_migrations))
    
    if [[ ${#pending[@]} -eq 0 ]]; then
        echo -e "${GREEN}✓ No pending migrations${NC}"
        return 0
    fi
    
    echo -e "${YELLOW}[Migration Helper]${NC} Found ${#pending[@]} pending migration(s)"
    echo ""
    
    for migration_file in "${pending[@]}"; do
        if [[ -n "$TARGET_VERSION" ]]; then
            local migration_version=$(basename "$migration_file" | cut -d'_' -f1)
            if [[ "$migration_version" > "$TARGET_VERSION" ]]; then
                break
            fi
        fi
        apply_migration "$migration_file"
    done
    
    echo ""
    echo -e "${GREEN}✓ All migrations applied${NC}"
}

# Rollback migrations
run_migrations_down() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}   Delegado OS Migration Rollback${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    if ! migrations_table_exists; then
        echo -e "${RED}Error: No migrations table found${NC}"
        exit 1
    fi
    
    local applied=($(get_applied_migrations | sort -r))
    
    if [[ ${#applied[@]} -eq 0 ]]; then
        echo -e "${YELLOW}No migrations to rollback${NC}"
        return 0
    fi
    
    echo -e "${YELLOW}[Migration Helper]${NC} Rolling back $STEPS migration(s)"
    echo ""
    
    for ((i=0; i<STEPS && i<${#applied[@]}; i++)); do
        rollback_migration "${applied[$i]}"
    done
    
    echo ""
    echo -e "${GREEN}✓ Rollback complete${NC}"
}

# Show migration status
show_status() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}   Migration Status${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    if ! migrations_table_exists; then
        echo -e "${YELLOW}No migrations table found. Run 'up' to initialize.${NC}"
        return 0
    fi
    
    local applied=($(get_applied_migrations))
    local pending=($(get_pending_migrations))
    
    echo -e "${GREEN}Applied Migrations (${#applied[@]}):${NC}"
    if [[ ${#applied[@]} -eq 0 ]]; then
        echo "  None"
    else
        for version in "${applied[@]}"; do
            echo "  ✓ $version"
        done
    fi
    
    echo ""
    echo -e "${YELLOW}Pending Migrations (${#pending[@]}):${NC}"
    if [[ ${#pending[@]} -eq 0 ]]; then
        echo "  None"
    else
        for file in "${pending[@]}"; do
            echo "  ○ $(basename "$file")"
        done
    fi
    
    echo ""
}

# Main execution
main() {
    case "$ACTION" in
        create)
            create_migration
            ;;
        up)
            run_migrations_up
            ;;
        down)
            run_migrations_down
            ;;
        status)
            show_status
            ;;
        rollback)
            if [[ -z "$TARGET_VERSION" ]]; then
                echo -e "${RED}Error: --target is required for rollback action${NC}"
                exit 1
            fi
            STEPS=1000
            run_migrations_down
            ;;
        *)
            echo -e "${RED}Error: Unknown action '$ACTION'${NC}"
            usage
            ;;
    esac
}

main "$@"
