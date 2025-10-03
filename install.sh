#!/bin/bash

# Script to install AI dev task commands to Claude Code and Cursor

set -e

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the parent directory (project root)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Function to display menu and get user choice
show_menu() {
    echo "🚀 AI Dev Tasks Installer"
    echo ""
    echo "Choose installation type:"
    echo "  1) Local  - Install to current project only (.claude/commands, .cursor/commands)"
    echo "  2) Global - Install to user home directory (~/.claude/commands, ~/.cursor/commands)"
    echo "  3) Cancel - Exit without installing"
    echo ""
    read -p "Enter your choice (1-3): " choice
    echo ""
}

# Show menu and get choice
show_menu

# Process user choice
case $choice in
    1)
        echo "📍 Installing locally to current project..."
        CLAUDE_DIR="$PROJECT_ROOT/.claude/commands"
        CURSOR_DIR="$PROJECT_ROOT/.cursor/commands"
        ;;
    2)
        echo "🌍 Installing globally to user home directory..."
        CLAUDE_DIR="$HOME/.claude/commands"
        CURSOR_DIR="$HOME/.cursor/commands"
        ;;
    3)
        echo "❌ Installation cancelled."
        exit 0
        ;;
    *)
        echo "❌ Invalid choice. Installation cancelled."
        exit 1
        ;;
esac

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
