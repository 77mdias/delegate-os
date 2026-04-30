# Contributing to Delegado OS

## Welcome!

Thank you for your interest in contributing to Delegado OS. This document outlines how to contribute effectively.

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Follow the project's coding standards
- Test changes before submitting

## How to Contribute

### 1. Reporting Issues

Before creating an issue:
- Search existing issues first
- Use the issue template
- Include reproduction steps
- Specify environment (OS, versions)

Issue template:
```markdown
**Description**
[Clear description]

**Environment**
- OS:
- Delegado OS version:
- Related tools:

**Steps to Reproduce**
1.
2.
3.

**Expected Behavior**
[What should happen]

**Actual Behavior**
[What happens instead]

**Logs/Errors**
[Relevant logs here]
```

### 2. Suggesting Features

Feature requests are welcome! Include:
- Clear use case
- Proposed solution
- Alternative approaches considered
- Mockups/examples if applicable

### 3. Pull Requests

#### Process

1. **Fork** the repository
2. **Clone** your fork
   ```bash
   git clone https://github.com/your-name/delegado-os.git
   cd delegado-os
   ```
3. **Create** a feature branch
   ```bash
   git checkout -b feature/your-feature
   # or
   git checkout -b fix/your-bugfix
   ```
4. **Develop** your contribution
5. **Test** your changes
6. **Commit** with clear messages
   ```bash
   git commit -m "feat: add new mode X"
   git commit -m "fix: resolve issue with Y"
   ```
7. **Push** to your fork
   ```bash
   git push origin feature/your-feature
   ```
8. **Open** a Pull Request

#### Commit Message Format

```
type(scope): subject

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance

Examples:
```bash
feat(professor): add new teaching template
fix(debugger): resolve context loss on mode switch
docs(guardian): update OWASP checklist
refactor(orchestration): improve mode selection algorithm
```

#### PR Template

```markdown
## Description
[What this PR does]

## Type of Change
- [ ] New mode
- [ ] Plugin
- [ ] Bug fix
- [ ] Documentation
- [ ] Refactoring
- [ ] Other

## Testing
[How was this tested?]

## Checklist
- [ ] Code follows style guidelines
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes
```

### 4. Creating New Modes

See [Creating New Modes](docs/BEST-PRACTICES.md#creating-new-modes) in Best Practices.

Quick checklist:
- [ ] Create `subagents/MYMODE/SKILL.md`
- [ ] Create mode guide `subagents/MYMODE/MYMODE.md`
- [ ] Create pre-hook `scripts/hooks.d/pre_MYMODE.sh`
- [ ] Create post-hook `scripts/hooks.d/post_MYMODE.sh`
- [ ] Add Obsidian template `templates/obsidian/TEMPLATE-MYMODE.md`
- [ ] Update MODE-ORCHESTRATOR.md
- [ ] Add examples in `examples/MYMODE/`

### 5. Creating Plugins

See [Plugin System](PLUGINS.md) for full documentation.

Plugin checklist:
- [ ] Create `plugins/my-plugin/manifest.yaml`
- [ ] Create hook scripts in `plugins/my-plugin/hooks/`
- [ ] Write `plugins/my-plugin/README.md`
- [ ] Test hooks manually
- [ ] Add examples in documentation

### 6. Documentation

Documentation improvements are always welcome:
- Fix typos/grammar
- Improve clarity
- Add examples
- Translate to other languages

Documentation files:
- `*.md` in root - main documentation
- `docs/` - additional guides
- `subagents/*/SKILL.md` - mode documentation

## Development Setup

```bash
# Clone repo
git clone https://github.com/your-org/delegado-os.git
cd delegado-os

# Install dependencies
./scripts/install.sh

# Run tests
./scripts/test.sh

# Setup pre-commit hooks
./scripts/setup-git-hooks.sh
```

## Style Guidelines

### Shell Scripts
- Use `#!/bin/bash` with `set -e`
- Add descriptive comments
- Use meaningful variable names
- Check exit codes

```bash
#!/bin/bash
set -e

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

main() {
    log "Starting process..."
    # ...
}

main "$@"
```

### YAML
- Use 2-space indentation
- Comments for complex sections
- Consistent key ordering

### Markdown
- 80 character line width
- Code blocks with language
- Links to related docs
- Examples when helpful

## Testing Guidelines

### Manual Testing

```bash
# Test mode activation
./scripts/delegate.sh activate MYMODE

# Test hooks
bash -x scripts/hooks.d/pre_MYMODE.sh

# Test with sample input
./scripts/delegate.sh info MYMODE
```

### Automated Testing

```bash
# Run test suite
./scripts/test.sh

# Test specific component
./scripts/test.sh --component mode

# Generate coverage
./scripts/test.sh --coverage
```

## Community

- **Issues**: GitHub Issues
- **Discussions**: GitHub Discussions
- **Discord**: [Link]
- **Wiki**: [Link]

## Recognition

Contributors will be recognized in:
- CONTRIBUTORS.md file
- Release notes
- GitHub profile links

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

Feel free to:
- Open an issue for bugs/questions
- Start a discussion for ideas
- Contact maintainers directly
