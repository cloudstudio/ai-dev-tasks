#!/bin/bash

# Script to install AI dev task commands to Claude Code and Cursor

set -e

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the parent directory (project root)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Define target directories
CLAUDE_DIR="$PROJECT_ROOT/.claude/commands"
CURSOR_DIR="$PROJECT_ROOT/.cursor/commands"

# Create target directories if they don't exist
mkdir -p "$CLAUDE_DIR"
mkdir -p "$CURSOR_DIR"

# Copy command files to both directories
echo "📦 Installing AI dev task commands..."

# Find all .md files in the current directory and copy them
for file in "$SCRIPT_DIR"/*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        cp "$file" "$CLAUDE_DIR/$filename"
        cp "$file" "$CURSOR_DIR/$filename"
        echo "  ✓ Installed: $filename"
    fi
done

# Remove the ai-dev-tasks directory
echo "🗑️  Removing ai-dev-tasks directory..."
rm -rf "$SCRIPT_DIR"

echo "✅ Installation complete!"
echo "   Commands installed to:"
echo "   - $CLAUDE_DIR"
echo "   - $CURSOR_DIR"
