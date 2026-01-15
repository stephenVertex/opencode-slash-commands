Start development workflow in a git worktree.

Steps:
1. Verify we're in a git worktree (not the main repo):
   - Run `git worktree list` and check if current directory is a worktree (not the first/main entry)
   - Get the current branch name with `git branch --show-current`
   - If we're in the main repo, stop and tell the user to run this from within a worktree

2. Find the spec file:
   - Look for a spec file matching the branch name: `specs/<branch-name>.md`
   - If not found, try common variations: `specs/<BRANCH_NAME>.md`, `specs/<branch_name>.md`
   - If still not found, list available specs in `specs/` and ask the user which one to use
   - Read the spec file contents

3. Create implementation TODO list:
   - Analyze the spec file thoroughly
   - Identify all implementation tasks, breaking down into specific actionable items
   - Use the TodoWrite tool to create a comprehensive task list
   - Group related tasks logically (e.g., "Phase 1", "Phase 2" or by component)

4. Review with user:
   - Present the TODO list summary to the user
   - Ask if they want to:
     a) Proceed with the plan as-is
     b) Modify/reorder any tasks
     c) Add additional tasks
     d) Remove any tasks

5. Begin development:
   - Once user approves, mark the first task as in_progress
   - Start implementing the first task
   - Continue through the TODO list, marking tasks complete as you go
