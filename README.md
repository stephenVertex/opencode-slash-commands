# OpenCode Slash Commands

A collection of custom slash commands for [OpenCode](https://opencode.ai) focused on git worktree workflows.

## Installation

Copy these files to your OpenCode command directory:

```bash
# Global installation (available in all projects)
cp *.md ~/.config/opencode/command/

# Or per-project installation
cp *.md .opencode/command/
```

## Commands

| Command | Description |
|---------|-------------|
| `/new-spec-for-worktree` | Create a new spec file and collaborate with AI to develop the idea |
| `/new-worktree` | Create a git worktree for feature development |
| `/start-dev-in-worktree` | Start development workflow by reading the spec and creating a TODO list |
| `/close-worktree` | Commit, push, and create a PR for the worktree |
| `/update-worktrees` | Check worktree status and find recent PRs ready for review |
| `/awsid` | Show current AWS identity |

## Workflow

These commands support a worktree-based development workflow:

1. **`/new-spec-for-worktree <name>`** - Create and develop a spec for a new feature
2. **`/new-worktree <feature-name>`** - Create a worktree and branch for the feature
3. **`/start-dev-in-worktree`** - Read the spec and create an implementation plan
4. **`/close-worktree`** - When done, commit everything and open a PR
5. **`/update-worktrees`** - Check status of all worktrees and open PRs

## Requirements

- Git
- GitHub CLI (`gh`) for PR operations
- [Warp Terminal](https://warp.dev) (optional, for automatic tab opening)

## License

MIT
