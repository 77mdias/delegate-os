# Test Generator Plugin

The Test Generator Plugin automatically generates tests based on code analysis, specification files, and existing implementations within Delegado OS.

## Overview

This plugin accelerates test creation by analyzing source code and generating comprehensive test suites that cover edge cases, happy paths, and error conditions.

## Features

### Test Generation
Automatically generate tests from:
- Source code analysis (functions, classes, modules)
- Specification documents (SPEC.md files)
- API definitions (OpenAPI/Swagger)
- Database schemas

### Spec-Based Testing
Generate tests directly from specifications:
- Parse SPEC.md files
- Extract requirements and acceptance criteria
- Generate corresponding test cases

### Code Analysis
Understand code structure to generate meaningful tests:
- Function signature analysis
- Control flow mapping
- Edge case identification
- Error handling detection

### Mock Generation
Automatically create mock objects:
- Function mocks
- API client mocks
- Database mocks
- External service mocks

### Fixture Creation
Generate test fixtures:
- Sample data files
- Configuration objects
- Database seeds

### Coverage Analysis
Analyze and improve test coverage:
- Line coverage reporting
- Branch coverage analysis
- Missing coverage identification

## Supported Languages

| Language   | Test Framework | Status |
|------------|----------------|--------|
| JavaScript | Jest, Mocha    | ✓ Full |
| TypeScript | Jest, Mocha    | ✓ Full |
| Python     | pytest         | ✓ Full |
| Bash       | bats-core      | ✓ Full |
| Go         | testing        | ✓ Full |
| Rust       | Rust testing   | ✓ Full |
| Java       | JUnit          | ✓ Full |

## Usage

### Generate Tests from Code

```bash
./generate_tests.sh --source /path/to/source.js --framework jest
```

### Generate Tests from Spec

```bash
./generate_tests.sh --spec /path/to/SPEC.md --output /tests
```

### Analyze Code and Generate

```bash
./generate_tests.sh --analyze /path/to/code --generate
```

## Options

```
--source <path>       Source file or directory to analyze
--spec <path>         SPEC.md file to generate tests from
--analyze <path>      Analyze code and generate tests
--output <path>       Output directory for tests [default: ./tests]
--framework <name>    Test framework [default: jest]
--language <lang>     Programming language
--generate            Actually generate the tests (dry-run by default)
--coverage            Include coverage analysis
--mocks               Generate mock objects
--fixtures            Generate test fixtures
```

## Examples

### JavaScript/TypeScript with Jest

```bash
./generate_tests.sh \
  --source src/utils.js \
  --framework jest \
  --generate
```

Output:
```javascript
// tests/utils.test.js
describe('utils', () => {
  describe('calculateTotal', () => {
    it('should calculate total for positive numbers', () => {
      expect(calculateTotal([1, 2, 3])).toBe(6);
    });
    
    it('should return 0 for empty array', () => {
      expect(calculateTotal([])).toBe(0);
    });
    
    it('should throw for negative numbers', () => {
      expect(() => calculateTotal([-1])).toThrow();
    });
  });
});
```

### Python with pytest

```bash
./generate_tests.sh \
  --source src/api.py \
  --framework pytest \
  --language python \
  --generate
```

### Bash with bats-core

```bash
./generate_tests.sh \
  --source scripts/deploy.sh \
  --framework bats \
  --generate
```

## Integration with Mode System

| Mode | Integration Point |
|------|------------------|
| SPEC | Generate tests from specification |
| CODE | Validate implementation against tests |
| TEST | Create comprehensive test suites |
| REVIEW | Verify test coverage |
| DEBUG | Generate regression tests |
| SECURE | Generate security tests |
| OPTIMIZE | Performance test generation |

## Test Generation Strategy

### 1. Code Analysis
- Parse source code structure
- Identify functions, classes, methods
- Extract parameters and return types
- Map control flow

### 2. Edge Case Identification
- Null/undefined values
- Empty collections
- Boundary conditions
- Error conditions
- Concurrent access

### 3. Test Case Generation
- Happy path tests
- Edge case tests
- Error handling tests
- Integration tests

### 4. Mock and Fixture Creation
- Generate mock functions
- Create test fixtures
- Set up test data

## Configuration

Edit `manifest.yaml` to configure:

```yaml
configuration:
  default_framework: jest
  generate_mocks: true
  generate_fixtures: true
  min_coverage_target: 80
```

## Exit Codes

| Code | Meaning |
|------|--------|
| 0 | Success |
| 1 | General error |
| 2 | Source file not found |
| 3 | Unsupported language |
| 4 | Unsupported framework |
| 5 | Analysis error |

## See Also

- [Plugins Documentation](../../PLUGINS.md)
- [HELL Integration](../HELL-INTEGRATION.md)
- [Best Practices](../BEST-PRACTICES.md)
