#!/bin/bash
# Test Generator Plugin - on_code_generated hook
# Called after code is generated, triggers test generation

set -e

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="${DELEGADO_LOG_DIR:-~/.delegado/logs}"

# Configuration
AUTO_GENERATE_TESTS="${TEST_GENERATOR_AUTO_GENERATE:-true}"
TEST_FRAMEWORK="${TEST_GENERATOR_FRAMEWORK:-jest}"
LANGUAGE="${CODE_LANGUAGE:-javascript}"

# Log function
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $level | test-generator | $message" >> "$LOG_DIR/test-generator.log"
}

# Parse source files from arguments
parse_source_files() {
    local files=()
    while [ $# -gt 0 ]; do
        case "$1" in
            --file)
                files+=("$2")
                shift 2
                ;;
            --language)
                LANGUAGE="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done
    echo "${files[@]}"
}

# Detect test framework from project
detect_test_framework() {
    local project_dir="${CODE_PROJECT_DIR:-.}"

    if [ -f "$project_dir/package.json" ]; then
        if grep -q '"vitest"' "$project_dir/package.json"; then
            echo "vitest"
            return
        elif grep -q '"jest"' "$project_dir/package.json"; then
            echo "jest"
            return
        elif grep -q '"mocha"' "$project_dir/package.json"; then
            echo "mocha"
            return
        fi
    fi

    if [ -f "$project_dir/pyproject.toml" ] || [ -f "$project_dir/setup.py" ]; then
        echo "pytest"
        return
    fi

    echo "$TEST_FRAMEWORK"
}

# Generate test file name
generate_test_path() {
    local source_file="$1"
    local base=$(basename "$source_file")

    case "$LANGUAGE" in
        javascript|typescript)
            if [[ "$base" == *.ts ]]; then
                echo "${source_file%.ts}.test.ts"
            else
                echo "${source_file%.js}.test.js"
            fi
            ;;
        python)
            if [[ "$base" == *.py ]]; then
                echo "${source_file%.py}_test.py"
            else
                echo "${source_file}_test.py"
            fi
            ;;
        *)
            echo "${source_file}.test"
            ;;
    esac
}

# Generate tests for a source file
generate_tests() {
    local source_file="$1"
    local test_file
    test_file=$(generate_test_path "$source_file")

    log "INFO" "Generating tests for $source_file"

    case "$LANGUAGE" in
        javascript|typescript)
            generate_javascript_tests "$source_file" "$test_file"
            ;;
        python)
            generate_python_tests "$source_file" "$test_file"
            ;;
        *)
            log "WARN" "Unsupported language: $LANGUAGE"
            return 1
            ;;
    esac
}

# Generate JavaScript/TypeScript tests
generate_javascript_tests() {
    local source_file="$1"
    local test_file="$2"
    local framework
    framework=$(detect_test_framework)

    log "INFO" "Using test framework: $framework"

    case "$framework" in
        vitest)
            cat > "$test_file" << 'TEMPLATE'
import { describe, it, expect, vi } from 'vitest';
// import { functionName } from './source-file';

describe('Module', () => {
    describe('functionName', () => {
        it('should handle basic case', () => {
            // TODO: Implement test
            expect(true).toBe(true);
        });

        it('should handle edge case', () => {
            // TODO: Implement test
            expect(true).toBe(true);
        });
    });
});
TEMPLATE
            ;;
        jest|*)
            cat > "$test_file" << 'TEMPLATE'
const module = require('./source-file');

describe('Module', () => {
    describe('functionName', () => {
        it('should handle basic case', () => {
            // TODO: Implement test
            expect(true).toBe(true);
        });

        it('should handle edge case', () => {
            // TODO: Implement test
            expect(true).toBe(true);
        });
    });
});
TEMPLATE
            ;;
    esac

    log "INFO" "Generated test file: $test_file"
}

# Generate Python tests
generate_python_tests() {
    local source_file="$1"
    local test_file="$2"
    local module_name
    module_name=$(basename "$source_file" .py)

    cat > "$test_file" << TEMPLATE
import pytest
# from ${module_name} import function_name

class TestModule:
    class TestFunctionName:
        def test_basic_case(self):
            # TODO: Implement test
            assert True

        def test_edge_case(self):
            # TODO: Implement test
            assert True
TEMPLATE

    log "INFO" "Generated test file: $test_file"
}

# Main execution
main() {
    mkdir -p "$LOG_DIR"

    if [ "$AUTO_GENERATE_TESTS" != "true" ]; then
        log "INFO" "Test auto-generation disabled, skipping"
        exit 0
    fi

    local source_files=()
    while [ $# -gt 0 ]; do
        case "$1" in
            --file)
                source_files+=("$2")
                shift 2
                ;;
            --project-dir)
                export CODE_PROJECT_DIR="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done

    if [ ${#source_files[@]} -eq 0 ]; then
        log "WARN" "No source files provided"
        exit 0
    fi

    log "INFO" "Processing ${#source_files[@]} source files"

    for file in "${source_files[@]}"; do
        if [ -f "$file" ]; then
            generate_tests "$file" || log "ERROR" "Failed to generate tests for $file"
        else
            log "WARN" "Source file not found: $file"
        fi
    done

    log "INFO" "Test generation complete"
}

main "$@"
