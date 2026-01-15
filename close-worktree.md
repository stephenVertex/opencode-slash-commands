Close a git worktree by committing, pushing, and opening a PR.

Steps:
1. Verify we're in a git worktree (not the main repo):
   - Run `git rev-parse --is-inside-work-tree` to confirm we're in a git repo
   - Run `git worktree list` and check if current directory is a worktree (not the main repo path)
   - Check that current branch is not main/master
   - If any check fails, stop and inform the user they must run this from within a worktree

2. Check for uncommitted changes with `git status --porcelain`:
   - If there are changes, stage all with `git add -A`
   - Create a commit with a descriptive message summarizing the changes
   - If no changes, skip commit

3. Push the branch to remote:
   - Run `git push -u origin <branch-name>`

4. Create a pull request using gh:
   - Run `gh pr create --fill` to create a PR with auto-filled title and body from commits
   - If the PR already exists, run `gh pr view --web` to open it instead

5. Display the PR URL prominently and remind the user they can:
   - Review the PR in their browser
   - Switch back to the main worktree to continue other work
   - Remove this worktree later with `git worktree remove <path>`
