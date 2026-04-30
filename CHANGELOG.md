# Changelog

All notable changes to Delegado OS will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- Multiple new agent modes (PROFESSOR, ARCHITECT, DEBUGGER, GUARDIAN, RESEARCHER, MENTOR, CONSULTANT, ORCHESTRATION)
- Complete plugin system with manifest-based loading
- CI/CD, monitoring, obsidian-sync, API integration, database, test-generator, notification, backup, developer-tools, git-integration, logging plugins
- Complete workflow system (code-review, architecture-proposal, debugging-session, teaching-session)
- Comprehensive documentation (METRICS, HELL-INTEGRATION, MODE-COMPARISON, BEST-PRACTICES, ADVANCED-PROMPTING, TROUBLESHOOTING, CLI-REFERENCE)
- Obsidian vault setup script
- ADR (Architecture Decision Records) system
- API documentation template
- Shell scripts for delegate, auto-improve, context7 search, mode selection
- Pre and post hooks for all agent modes
- Obsidian templates for all modes
- Practical examples for all modes

## [1.0.0] - 2024-04-24

### Added
- Initial release
- HELL framework (Hyper-Extreme Learning Loop)
- Meta-prompting system
- Obsidian integration
- Context7 documentation search
- Basic agent modes (CODER, ANALYST, REVIEW)
- Kernel/HELL core engine
- SKILL system for agent definition

---

## Versioning

We use [Semantic Versioning](https://semver.org/):
- MAJOR version: Breaking changes
- MINOR version: New features (backwards compatible)
- PATCH version: Bug fixes

## Release Schedule

- **Major releases**: As needed for breaking changes
- **Minor releases**: Monthly for new features
- **Patch releases**: Weekly for bug fixes

## Supported Versions

| Version | Supported |
|---------|----------|
| 1.x.x   | ✅ Latest |
| 0.x.x   | ⚠️ EOL |

## Deprecation Policy

1. Deprecation notice in changelog
2. Warning in documentation
3. Feature flag for migration
4. Minimum 2 minor versions before removal
