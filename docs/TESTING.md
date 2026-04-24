# Testing Guide

## Overview

This guide covers testing strategies for Delegado OS.

## Test Categories

### 1. Unit Tests
- Test individual scripts/functions
- Mock external dependencies
- Fast execution

### 2. Integration Tests
- Test mode switching
- Test Obsidian sync
- Test hook execution

### 3. End-to-End Tests
- Complete user workflows
- Real mode activation
- Full Obsidian integration

## Test Structure

```
tests/
├── unit/
│   ├── hooks/
│   ├── modes/
│   └── scripts/
├── integration/
│   ├── mode_switching/
│   ├── obsidian_sync/
│   └── workflow_execution/
├── e2e/
│   └── workflows/
└── fixtures/
```

## Running Tests

```bash
# All tests
./scripts/test.sh

# Unit only
./scripts/test.sh --unit

# Integration only
./scripts/test.sh --integration

# E2E only
./scripts/test.sh --e2e

# With coverage
./scripts/test.sh --coverage
```

## Test Examples

### Hook Test
```bash
# tests/unit/hooks/test_pre_debugger.sh
#!/bin/bash
set -e

source "$DELEGADO_HOME/scripts/hooks.d/pre_DEBUGGER.sh"

# Mock functions
log() { echo "[mock] $1"; }

# Test
MODE=DEBUGGER SESSION_ID=test123
result=$(pre_debugger_hook 2>&1)

assert_contains "$result" "DEBUGGER"
assert_contains "$result" "test123"
```

### Mode Test
```bash
# tests/unit/modes/test_professor.sh
#!/bin/bash
set -e

source "$DELEGADO_HOME/subagents/PROFESSOR/SKILL.md"

# Mock context
export USER_REQUEST="Explain TDD"

# Execute
output=$(professor_teach)

assert_contains "$output" "Test-Driven Development"
assert_contains "$output" "Red-Green-Refactor"
```

## CI Integration

```yaml
# .github/workflows/test.yml
name: Test
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: ./scripts/test.sh --coverage
      - name: Upload coverage
        uses: codecov/codecov-action@v3
```
