# Troubleshooting Guide

## Common Issues

### Mode Not Activating

**Symptom:** `./scripts/delegate.sh activate PROFESSOR` does nothing

**Diagnosis:**
```bash
# Check if script is executable
ls -la scripts/delegate.sh

# Check if mode exists
ls subagents/PROFESSOR/

# Check pre-hook exists
ls scripts/hooks.d/pre_PROFESSOR.sh
```

**Solutions:**
1. Make delegate.sh executable: `chmod +x scripts/delegate.sh`
2. Ensure SKILL.md exists in mode directory
3. Check hook permissions: `chmod +x scripts/hooks.d/pre_*.sh`

---

### Obsidian Sync Not Working

**Symptom:** Session notes not appearing in Obsidian vault

**Diagnosis:**
```bash
# Check vault path is set
echo $OBSIDIAN_VAULT

# Check directory exists
ls -la "$OBSIDIAN_VAULT"

# Check write permissions
touch "$OBSIDIAN_VAULT/test.md" && rm "$OBSIDIAN_VAULT/test.md"
```

**Solutions:**
1. Set vault path: `export OBSIDIAN_VAULT=~/my-vault`
2. Run setup: `./scripts/setup_obsidian_vault.sh`
3. Check disk space
4. Verify .obsidian.json is writable

---

### Context Lost Between Mode Switches

**Symptom:** Previous conversation context is lost when switching modes

**Diagnosis:**
```bash
# Check context file
cat .delegado/current_session.md 2>/dev/null || echo "No context file"

# Check session directory
ls -la .delegado/sessions/
```

**Solutions:**
1. Pre-hooks should load previous context - check `scripts/hooks.d/pre_*.sh`
2. Post-hooks should save context - check `scripts/hooks.d/post_*.sh`
3. Set `CONTEXT_PERSISTENCE=true` in config

---

### Poor Mode Output Quality

**Symptom:** Mode responses are generic or unhelpful

**Diagnosis:**
1. Is the prompt specific enough?
2. Are constraints defined?
3. Is the mode appropriate for the task?

**Solutions:**
1. Improve the mode's SKILL.md - add more context and examples
2. Use specific keywords in your request
3. Combine with ORCHESTRATION for complex tasks
4. Review MODE-COMPARISON.md to ensure right mode selection

---

### Hook Script Failures

**Symptom:** Error messages mentioning hooks, or hooks not executing

**Diagnosis:**
```bash
# Test hook manually
bash -x scripts/hooks.d/pre_DEBUGGER.sh

# Check syntax
bash -n scripts/hooks.d/pre_DEBUGGER.sh

# View recent errors
tail -20 .delegado/errors.log 2>/dev/null
```

**Solutions:**
1. Fix syntax errors in hook scripts
2. Check all referenced files/directories exist
3. Ensure required env vars are set
4. Temporarily disable hook: rename `pre_DEBUGGER.sh` to `pre_DEBUGGER.sh.bak`

---

### Context7 Search Not Working

**Symptom:** `./scripts/context7_search.sh` returns no results

**Diagnosis:**
```bash
# Check API key is set
echo $CONTEXT7_API_KEY

# Test API directly
curl -s "https://api.context7.io/v1/health" | head
```

**Solutions:**
1. Get API key from context7.io
2. Set key: `export CONTEXT7_API_KEY=your-key`
3. Check network connectivity
4. Try again with verbose: `./scripts/context7_search.sh -v "query"`

---

### Plugin Not Loading

**Symptom:** Plugin hooks not executing

**Diagnosis:**
```bash
# Check plugin manifest exists
cat plugins/my-plugin/manifest.yaml

# Check plugin is in plugins directory
ls plugins/

# Verify YAML syntax
python3 -c "import yaml; yaml.safe_load(open('plugins/my-plugin/manifest.yaml'))"
```

**Solutions:**
1. Create valid manifest.yaml (see PLUGINS.md for schema)
2. Place plugin in `plugins/` directory
3. Make hook scripts executable: `chmod +x plugins/my-plugin/hooks/*.sh`
4. Enable in config: `plugins.my-plugin.enabled=true`

---

### Memory Issues

**Symptom:** System running slow, "out of memory" errors

**Diagnosis:**
```bash
# Check context file sizes
du -sh .delegado/

# Check session count
ls .delegado/sessions/ | wc -l

# Check disk space
df -h
```

**Solutions:**
1. Clean old sessions: `find .delegado/sessions -mtime +7 -delete`
2. Archive to Obsidian: `./scripts/delegate.sh sync --all`
3. Reduce context window by clearing `.delegado/current_session.md`
4. Increase swap if needed

---

### Git Conflicts on Branch

**Symptom:** Unable to commit, merge conflicts

**Diagnosis:**
```bash
git status
git diff --name-only
```

**Solutions:**
1. Review conflicts: `git diff`
2. Resolve manually or accept ours/theirs
3. Commit resolved: `git add . && git commit`
4. Or abort: `git merge --abort`

---

### Mode Selector Choosing Wrong Mode

**Symptom:** DEBUGGER activated instead of ARCHITECT

**Diagnosis:**
1. Keywords overlap between modes
2. Request was ambiguous

**Solutions:**
1. Be more specific: "design architecture" vs "debug issue"
2. Use manual mode selection: `./scripts/delegate.sh activate ARCHITECT`
3. Update MODE-ORCHESTRATOR.md with better keyword weights

---

### Workflow Not Executing

**Symptom:** Workflow YAML not running

**Diagnosis:**
```bash
# Check workflow syntax
cat workflows/my-workflow.yaml | head -20

# Validate YAML
python3 -c "import yaml; yaml.safe_load(open('workflows/my-workflow.yaml'))"
```

**Solutions:**
1. Ensure workflow has required fields: name, modes, phases
2. Check mode names match actual mode directories
3. Use `./scripts/delegate.sh run-workflow workflows/my-workflow.yaml`

---

## Getting Help

```bash
# View all available commands
./scripts/delegate.sh help

# Run diagnostics
./scripts/auto_improve.sh diagnose

# Generate debug report
./scripts/delegate.sh debug --report
```

## Reporting Issues

When reporting issues, include:
1. `./scripts/delegate.sh debug --report` output
2. The mode and workflow (if applicable)
3. Steps to reproduce
4. Expected vs actual behavior

## Emergency Recovery

### Complete Reset
```bash
# Backup current state
cp -r .delegado .delegado.backup

# Reset to clean state
rm -rf .delegado
mkdir -p .delegado/sessions

# Re-initialize
./scripts/setup_obsidian_vault.sh
```

### Restore from Backup
```bash
# Stop current instance
pkill -f delegado

# Restore
rm -rf .delegado
mv .delegado.backup .delegado

# Restart
./scripts/delegate.sh start
```
