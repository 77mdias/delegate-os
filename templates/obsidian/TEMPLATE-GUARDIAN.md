---
type: security
mode: GUARDIAN
date: {{DATE}}
severity: {{SEVERITY}}
status: {{STATUS}}
---

# Security Review: {{TITLE}}

> {{DESCRIPTION}}

## ⚠️ Issue Details

- **Severity:** {{SEVERITY}}
- **CWE:** {{CWE}}
- **OWASP Category:** {{OWASP}}

## 🎯 Affected Components

{{AFFECTED_COMPONENTS}}

## 📋 Description

{{FULL_DESCRIPTION}}

## 💻 Vulnerable Code

```{{LANGUAGE}}
{{VULNERABLE_CODE}}
```

## 🔓 Proof of Concept

```{{LANGUAGE}}
{{POC}}
```

## 🛡️ Remediation

```{{LANGUAGE}}
{{FIXED_CODE}}
```

## 📊 Risk Assessment

| Factor | Value |
|--------|-------|
| Likelihood | {{LIKELIHOOD}} |
| Impact | {{IMPACT}} |
| Overall | {{OVERALL_RISK}} |

## ✅ Checklist

- [ ] Code fixed
- [ ] Security test added
- [ ] Code reviewed
- [ ] Deployed to production

---

*Created with Delegado OS - Guardian Mode*
