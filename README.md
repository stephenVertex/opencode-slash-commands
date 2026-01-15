# OpenCode Slash Commands

A collection of custom slash commands for [OpenCode](https://opencode.ai), [Claude Code](https://claude.ai), and [Gemini CLI](https://github.com/google-gemini/gemini-cli) focused on git worktree workflows.

## Installation

Run the install script to copy commands to all supported CLI tools:

```bash
./install.sh
```

This installs commands to:
- `~/.config/opencode/command/` (OpenCode)
- `~/.claude/commands/` (Claude Code)
- `~/.gemini/commands/` (Gemini CLI - converted to TOML format with namespacing)

## Commands

### Worktree Commands

| Command | Description |
|---------|-------------|
| `/new-spec-for-worktree` | Create a new spec file and collaborate with AI to develop the idea |
| `/new-worktree` | Create a git worktree for feature development |
| `/start-dev-in-worktree` | Start development workflow by reading the spec and creating a TODO list |
| `/close-worktree` | Commit, push, create a PR, and archive the spec to `specs/completed/` |
| `/update-worktrees` | Check worktree status and find recent PRs ready for review |
| `/check-completed-specs` | Retroactively find and archive completed specs |

### Utility Commands

| Command | Description |
|---------|-------------|
| `/awsid` | Show current AWS identity |
| `/modularize` | Check code file sizes and suggest modularization |

## Workflow

These commands support a spec-driven worktree-based development workflow:

```
specs/{name}.md  →  [implement in worktree]  →  specs/completed/{name}.md
```

1. **`/new-spec-for-worktree <name>`** - Create and develop a spec for a new feature
2. **`/new-worktree <feature-name>`** - Create a worktree and branch for the feature
3. **`/start-dev-in-worktree`** - Read the spec and create an implementation plan
4. **`/close-worktree`** - When done, commit everything, open a PR, and archive the spec
5. **`/update-worktrees`** - Check status of all worktrees and open PRs

## Gemini CLI Namespacing

For Gemini CLI, worktree commands are namespaced under `worktrees:`, e.g.:
- `/worktrees:new-worktree`
- `/worktrees:close-worktree`

## Requirements

- Git
- GitHub CLI (`gh`) for PR operations
- [Warp Terminal](https://warp.dev) (optional, for automatic tab opening)

## License

MIT
