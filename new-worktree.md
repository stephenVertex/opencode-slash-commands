Create a git worktree for feature development.

Argument: $ARGUMENTS (feature name or --spec=specs/feature-name.md)

Steps:
1. Check if a `new-worktree.sh` script exists in the repo root. If not, create one with this content:
   - Parse --spec or feature-name arguments
   - Set WORKTREE_PATH to parent directory with repo-name--feature-name format
   - Create worktree with `git worktree add -b <branch> <path>`
   - Copy .env if it exists
   - Open new Warp tab if in WarpTerminal, otherwise print cd command

2. Check for uncommitted files in specs/ directory using `git status --porcelain specs/`. If any exist, stop and tell the user to commit them first so they're available in the new branch.

3. Run the new-worktree.sh script with the provided arguments: `./new-worktree.sh $ARGUMENTS`

4. After successful creation, display a clear notification telling the user to switch to the new Warp tab (or cd to the worktree path if not in Warp).


# new-worktree.sh sample script

Below is an example new-worktree.sh script. This is a good starting point, and it can evolve to meet the needs of the repo that it is in.

## Warp Terminal Integration

To open a new tab in the current Warp window, use the URI scheme:
- `warp://action/new_tab?path=<path_to_folder>`

See the full Warp URI scheme documentation: https://docs.warp.dev/terminal/more-features/uri-scheme

<SCRIPT>
#!/bin/bash
set -e

# Parse arguments
FEATURE_NAME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --spec=*)
            SPEC_PATH="${1#*=}"
            # Extract feature name from spec path: specs/new-feature-name.md -> new-feature-name
            FEATURE_NAME=$(basename "$SPEC_PATH" .md)
            shift
            ;;
        --spec)
            SPEC_PATH="$2"
            FEATURE_NAME=$(basename "$SPEC_PATH" .md)
            shift 2
            ;;
        @specs/*)
            # Handle @specs/feature-name.md format (common in AI agent references)
            SPEC_PATH="${1#@}"  # Remove @ prefix -> specs/feature-name.md
            FEATURE_NAME=$(basename "$SPEC_PATH" .md)
            shift
            ;;
        *)
            if [[ -z "$FEATURE_NAME" ]]; then
                FEATURE_NAME="$1"
            fi
            shift
            ;;
    esac
done

if [[ -z "$FEATURE_NAME" ]]; then
    echo "Usage: $0 <feature-name>"
    echo "       $0 --spec specs/feature-name.md"
    echo "       $0 --spec=specs/feature-name.md"
    echo "       $0 @specs/feature-name.md"
    exit 1
fi

REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")
WORKTREE_PATH="$(dirname "$REPO_ROOT")/${REPO_NAME}--${FEATURE_NAME}"
BRANCH_NAME="$FEATURE_NAME"

# Check for uncommitted files in specs/
UNCOMMITTED_SPECS=$(git status --porcelain specs/ 2>/dev/null)
if [[ -n "$UNCOMMITTED_SPECS" ]]; then
    echo "Error: Uncommitted files in specs/"
    echo "$UNCOMMITTED_SPECS"
    echo ""
    echo "Commit spec files before creating worktree so they're available in the new branch."
    exit 1
fi

echo "Creating worktree at: $WORKTREE_PATH"
echo "Branch: $BRANCH_NAME"

# Create worktree with new branch
git worktree add -b "$BRANCH_NAME" "$WORKTREE_PATH"

# Copy .env if it exists
if [[ -f "$REPO_ROOT/.env" ]]; then
    cp "$REPO_ROOT/.env" "$WORKTREE_PATH/.env"
    echo "Copied .env to worktree"
fi

echo ""
echo "Worktree created at: $WORKTREE_PATH"

# Open new Warp tab at the worktree directory
# See: https://docs.warp.dev/terminal/more-features/uri-scheme
if [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; then
    open "warp://action/new_tab?path=${WORKTREE_PATH}"
    echo "Opened new Warp tab at worktree directory"
else
    echo "Run: cd $WORKTREE_PATH"
fi
</SCRIPT>
