# Git Integration Plugin

Automated Git operations and workflow enforcement for Delegado OS.

## Features

- **Commit Validation**: Enforce conventional commit format
- **Branch Management**: Auto-naming, protection, cleanup
- **Push Hooks**: Pre/post push automation
- **Merge Hooks**: Validation before merging
- **Branch Lifecycle**: Track branch creation/deletion

## Configuration

Edit `manifest.yaml`:

```yaml
config:
  auto_stage: true
  require_branch_prefix: true
  branch_prefixes:
    - feat/
    - fix/
    - docs/
  protected_branches:
    - main
    - master
  max_commit_subject_length: 72
  sign_commits: false
  auto_cleanup_branches: false
```

## Commit Message Format

Uses Conventional Commits:

```
<type>: <subject>

[optional body]

[optional footer]
```

### Types

| Type | Description |
|------|-------------|
| feat | New feature |
| fix | Bug fix |
| docs | Documentation |
| style | Formatting |
| refactor | Code restructuring |
| test | Adding tests |
| chore | Maintenance |
| perf | Performance |
| ci | CI/CD changes |
| revert | Revert previous |

### Examples

```bash
git commit -m "feat: add user authentication"
git commit -m "fix: resolve memory leak in cache"
git commit -m "docs: update API documentation"
```

## Hooks

### `pre_commit`
- Validates commit message format
- Checks for required branch prefix
- Runs linting if configured
- Prevents commits to protected branches directly

### `post_commit`
- Logs commit information
- Triggers notifications if configured
- Updates activity tracking

### `pre_push`
- Validates branch name
- Checks protected branch restrictions
- Warns on large file pushes

### `post_push`
- Logs push summary
- Notifies on new branch creation
- Triggers CI if configured

### `pre_merge` / `post_merge`
- Validates merge commit message
- Logs merge activity

### `on_branch_create` / `on_branch_delete`
- Tracks branch lifecycle
- Logs branch changes

## Usage

### Installation

The plugin auto-registers with Delegado OS on startup.

### Manual Hook Invocation

```bash
# Run specific hook
~/.delegado/plugins/git-integration/hooks/pre_commit.sh

# With environment variables
FROM_BRANCH=main TO_BRANCH=feat/new-feature ~/.delegado/plugins/git-integration/hooks/pre_merge.sh
```

### Environment Variables

| Variable | Description |
|----------|-------------|
| `GIT_HOOK_CTX` | Current hook context (pre_commit, post_push, etc.) |
| `GIT_BRANCH` | Current branch name |
| `GIT_COMMIT_MSG` | Commit message |
| `FROM_BRANCH` | Source branch (for merges) |
| `TO_BRANCH` | Target branch (for merges) |
| `COMMIT_SHA` | Commit hash (post operations) |

## Branch Protection

Protected branches (main, master, develop) cannot be pushed to directly or merged without review.

```yaml
protected_branches:
  - main
  - master
  - develop
```

## Automation Examples

### Auto-cleanup Merged Branches

```yaml
config:
  auto_cleanup_branches: true
```

### Enforce Branch Prefixes

```yaml
config:
  require_branch_prefix: true
  branch_prefixes:
    - feat/
    - fix/
    - hotfix/
```

## Troubleshooting

### "Commit message format invalid"
Ensure your commit follows: `type: subject`

### "Branch name does not match pattern"
Prefix your branch with one of: feat/, fix/, docs/, etc.

### "Cannot push to protected branch"
Use pull requests to merge changes into protected branches.
