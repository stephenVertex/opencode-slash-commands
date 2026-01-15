Check worktree status and find recent PRs ready for review.

Steps:
1. Verify we're in the main repository (not a worktree):
   - Run `git worktree list` and confirm current directory matches the first entry (main repo)
   - If we're in a worktree, stop and tell the user to run this from the main repository

2. Display worktree status:
   - Run `git worktree list` to show all worktrees
   - For each worktree (excluding main), show:
     - Path and branch name
     - Run `git -C <worktree-path> status --short` to show uncommitted changes
     - Run `git -C <worktree-path> log origin/main..HEAD --oneline` to show unpushed commits

3. Find recent pull requests:
   - Run `gh pr list --author=@me --state=open --json number,title,url,createdAt,headRefName --limit 5`
   - Display the PRs sorted by most recent
   - Highlight the most recently created PR as the likely candidate for merging
   - Show the PR URL so user can review it

4. Provide a summary with suggested next actions:
   - If there are open PRs: suggest reviewing/merging the most recent one
   - If worktrees have uncommitted work: remind user to commit or close them
   - If worktrees exist for merged PRs: suggest cleaning them up with `git worktree remove`
