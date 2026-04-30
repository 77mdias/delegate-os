---
type: bug
mode: DEBUGGER
date: {{DATE}}
status: investigating
severity: {{SEVERITY}}
---

# Bug Report: {{TITLE}}

> {{SHORT_DESCRIPTION}}

## 🐛 Symptoms

{{SYMPTOMS}}

## 🔍 Investigation

### Environment
- OS: {{OS}}
- Version: {{VERSION}}
- Environment: {{ENV}}

### Steps to Reproduce
1. Step 1
2. Step 2
3. Step 3

### Expected Behavior
{{EXPECTED}}

### Actual Behavior
{{ACTUAL}}

## 💥 Stack Trace

```
{{STACK_TRACE}}
```

## 🧪 Test Case

```python
def test_{{TEST_NAME}}():
    """Reproduction test for bug: {{TITLE}}"""
    # Arrange
    {{ARRANGE}}
    
    # Act
    {{ACT}}
    
    # Assert
    {{ASSERT}}
```

## 🔧 Root Cause

**Root Cause:** {{ROOT_CAUSE}}

**Location:** {{LOCATION}}

## ✅ Fix

```{{LANGUAGE}}
{{FIX_CODE}}
```

## 📊 Impact

- **Severity:** {{SEVERITY}}
- **Affected Users:** {{AFFECTED_USERS}}
- **Workaround:** {{WORKAROUND}}

## 🛡️ Prevention

- [ ] Add regression test
- [ ] Add validation
- [ ] Update documentation

---

*Created with Delegado OS - Debugger Mode*
