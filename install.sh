#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Target directories
OPENCODE_DIR="$HOME/.config/opencode/command"
CLAUDE_DIR="$HOME/.claude/commands"
GEMINI_DIR="$HOME/.gemini/commands"

# Create directories if they don't exist
mkdir -p "$OPENCODE_DIR"
mkdir -p "$CLAUDE_DIR"
mkdir -p "$GEMINI_DIR"

# Copy markdown files for OpenCode/Claude (flattened)
copy_md_commands() {
    local target_dir="$1"
    local count=0

    # Copy top-level .md files (except README.md)
    for file in "$SCRIPT_DIR"/*.md; do
        if [[ -f "$file" && "$(basename "$file")" != "README.md" ]]; then
            cp "$file" "$target_dir/"
            ((count++))
        fi
    done

    # Copy .md files from subdirectories (flattened)
    for file in "$SCRIPT_DIR"/**/*.md; do
        if [[ -f "$file" ]]; then
            cp "$file" "$target_dir/"
            ((count++))
        fi
    done

    echo "$count"
}

# Convert markdown to TOML for Gemini CLI
# Args: $1 = source md file, $2 = target toml file
convert_to_toml() {
    local md_file="$1"
    local toml_file="$2"
    
    # Read the markdown file
    local content
    content=$(cat "$md_file")
    
    # Extract first line as description (strip leading # and whitespace)
    local first_line
    first_line=$(head -n 1 "$md_file" | sed 's/^#* *//')
    
    # Get the rest of the content as prompt
    local prompt
    prompt=$(tail -n +2 "$md_file")
    
    # Convert $ARGUMENTS to {{args}} for Gemini
    prompt=$(echo "$prompt" | sed 's/\$ARGUMENTS/{{args}}/g')
    
    # Write TOML file with description and prompt
    cat > "$toml_file" << EOF
description = "$first_line"
prompt = """
$prompt
"""
EOF
}

# Install TOML commands for Gemini (preserving directory structure for namespacing)
# e.g., worktrees/close-worktree.md -> worktrees/close-worktree.toml -> /worktrees:close-worktree
install_gemini_commands() {
    local target_dir="$1"
    local count=0

    # Convert top-level .md files (except README.md)
    for file in "$SCRIPT_DIR"/*.md; do
        if [[ -f "$file" && "$(basename "$file")" != "README.md" ]]; then
            local basename
            basename=$(basename "$file" .md)
            convert_to_toml "$file" "$target_dir/$basename.toml"
            ((count++))
        fi
    done

    # Convert .md files from subdirectories (preserving structure for namespacing)
    for dir in "$SCRIPT_DIR"/*/; do
        if [[ -d "$dir" && "$(basename "$dir")" != ".git" ]]; then
            local subdir_name
            subdir_name=$(basename "$dir")
            
            # Create matching subdirectory in target
            mkdir -p "$target_dir/$subdir_name"
            
            for file in "$dir"*.md; do
                if [[ -f "$file" ]]; then
                    local basename
                    basename=$(basename "$file" .md)
                    convert_to_toml "$file" "$target_dir/$subdir_name/$basename.toml"
                    ((count++))
                fi
            done
        fi
    done

    echo "$count"
}

echo "Installing slash commands..."
echo ""

opencode_count=$(copy_md_commands "$OPENCODE_DIR")
echo "Copied $opencode_count commands to $OPENCODE_DIR"

claude_count=$(copy_md_commands "$CLAUDE_DIR")
echo "Copied $claude_count commands to $CLAUDE_DIR"

gemini_count=$(install_gemini_commands "$GEMINI_DIR")
echo "Converted $gemini_count commands to $GEMINI_DIR (TOML format)"
echo "  (subdirectories preserved for namespacing, e.g., /worktrees:close-worktree)"

echo ""
echo "Done!"
