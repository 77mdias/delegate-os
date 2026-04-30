# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | ✅ Latest          |
| < 1.0   | ❌ Not supported   |

## Reporting a Vulnerability

If you discover a security vulnerability within Delegado OS, please follow responsible disclosure:

### How to Report

1. **DO NOT** create a public GitHub issue
2. Email security@delegado-os.io with:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)
3. Expect acknowledgment within 48 hours
4. Expect resolution within 14 days

### What to Expect

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 7 days
- **Fix Timeline**: Within 14 days for critical issues
- **Public Disclosure**: After fix is released

## Security Considerations

### Hooks Security

Hooks execute arbitrary code during agent operations.

**Best Practices:**
```bash
# Set hook permissions - only owner can execute
chmod 700 scripts/hooks.d/*.sh

# Review hooks before execution
cat scripts/hooks.d/pre_DEBUGGER.sh

# Use sandbox mode for untrusted hooks
./delegado.sh --sandbox-mode
```

### Obsidian Vault

The Obsidian vault contains sensitive session data.

**Best Practices:**
```bash
# Don't commit vault to git
echo "vault/" >> .gitignore

# Use separate vault per project
export OBSIDIAN_VAULT=~/projects/myproject-vault

# Encrypt vault at rest
# Use Obsidian's built-in encryption or file-level encryption
```

### API Keys

Context7 and other API keys should never be committed.

**Best Practices:**
```bash
# Use environment variables
export CONTEXT7_API_KEY=your-key

# Or use secrets management
./scripts/delegate.sh set-secret CONTEXT7_API_KEY

# Never commit .env files
echo ".env" >> .gitignore
echo ".env.*" >> .gitignore
```

### Plugin Security

Plugins execute code with agent privileges.

**Before Installing:**
1. Review `manifest.yaml` - what hooks does it register?
2. Review hook scripts - what do they actually do?
3. Check if plugin is from trusted source
4. Test in isolated environment first

**Plugin Manifest Review Checklist:**
```yaml
# Look for suspicious:
# - External network calls to unknown hosts
# - File operations outside DELEGADO_HOME
# - Environment variable access
# - Command execution without logging
```

## Security Features

### Hook Execution Sandboxing

When enabled, hooks run in restricted environment:
- No network access
- Limited filesystem access
- No environment variable exposure

Enable:
```bash
./delegado.sh --sandbox-hooks
```

### Audit Logging

All security-relevant events are logged:
```bash
# View security logs
cat .delegado/logs/security.log

# Enable enhanced logging
export LOG_LEVEL=SECURITY
```

### Mode Isolation

Each mode runs with minimal required permissions:
- Mode-specific filesystem access
- Limited shell command access
- Context isolated between modes

## OWASP Compliance

Delegado OS considers OWASP Top 10:

| OWASP Category | Status | Notes |
|---------------|--------|-------|
| A01 Broken Access Control | ✅ Addressed | Mode-based isolation |
| A02 Cryptographic Failures | ⚠️ User Responsibility | User manages their vault |
| A03 Injection | ✅ Mitigated | Input sanitization in hooks |
| A04 Insecure Design | ✅ Addressed | HELL framework |
| A05 Security Misconfiguration | ✅ Addressed | Sensible defaults |
| A06 Vulnerable Components | ⚠️ User Responsibility | Plugin review required |
| A07 Auth Failures | N/A | No authentication in framework |
| A08 Data Integrity Failures | ✅ Addressed | Git-based versioning |
| A09 Logging Failures | ✅ Addressed | Comprehensive logging plugin |
| A10 SSRF | ✅ Mitigated | Network restrictions in hooks |

## Security Best Practices

### For Users

1. **Review hooks before running**
   ```bash
   cat scripts/hooks.d/pre_*.sh
   cat scripts/hooks.d/post_*.sh
   ```

2. **Use separate vaults per project**
   ```bash
   # Project A
   export OBSIDIAN_VAULT=~/vault-project-a
   
   # Project B  
   export OBSIDIAN_VAULT=~/vault-project-b
   ```

3. **Enable sandbox mode for untrusted contexts**
   ```bash
   ./delegado.sh --sandbox
   ```

4. **Rotate API keys regularly**
   ```bash
   # Context7
   export CONTEXT7_API_KEY=new-key
   
   # Others
   ./scripts/delegate.sh rotate-keys
   ```

### For Developers

1. **Validate all hook inputs**
   ```bash
   # In your hook
   MODE="${1:-}"
   if [[ ! "$MODE" =~ ^[A-Z]+$ ]]; then
       echo "Invalid mode"
       exit 1
   fi
   ```

2. **Log all file operations**
   ```bash
   log "Creating $OBSIDIAN_DIR/note.md"
   ```

3. **Never expose secrets in logs**
   ```bash
   # BAD
   echo "API Key: $API_KEY"
   
   # GOOD
   echo "API Key: [REDACTED]"
   ```

4. **Use temporary files securely**
   ```bash
   # Create secure temp file
   TEMP=$(mktemp)
   trap "rm -f $TEMP" EXIT
   ```

## Compliance

### GDPR Considerations

If storing personal data in Obsidian:
- Use encryption
- Implement access controls
- Provide data export/deletion

### License Compliance

All dependencies must be verified for license compatibility.

Run compliance check:
```bash
./scripts/check_licenses.sh
```

## Incident Response

If you suspect a security incident:

1. **Contain**: Disable affected components
   ```bash
   ./delegado.sh disable --plugin suspicious-plugin
   ```

2. **Assess**: Determine scope
   ```bash
   ./delegado.sh audit --from 2024-01-01
   ```

3. **Notify**: Contact security@delegado-os.io

4. **Recover**: Restore from clean backup
   ```bash
   ./scripts/restore.sh --backup clean-backup.tar.gz
   ```

5. **Review**: Post-incident analysis
   ```bash
   ./delegado.sh post-mortem --incident INC-2024-001
   ```

## Contact

- **Security Issues**: security@delegado-os.io
- **General Security**: security@delegado-os.io
- **PGP Key**: [Available on keyserver]

---

*Last updated: 2024-04-24*
