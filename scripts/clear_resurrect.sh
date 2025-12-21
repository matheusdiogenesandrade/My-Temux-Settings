#!/usr/bin/env bash

# Script to clear tmux-resurrect saved environments
# This script deletes all saved tmux-resurrect files

# Get the resurrect directory (same logic as tmux-resurrect)
if [ -d "$HOME/.tmux/resurrect" ]; then
    RESURRECT_DIR="$HOME/.tmux/resurrect"
else
    RESURRECT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"/tmux/resurrect
fi

# Check if directory exists
if [ ! -d "$RESURRECT_DIR" ]; then
    tmux display-message "No saved environments found at $RESURRECT_DIR"
    exit 0
fi

# Count files before deletion
FILE_COUNT=$(find "$RESURRECT_DIR" -maxdepth 1 -name "tmux_resurrect_*.txt" -type f 2>/dev/null | wc -l)

if [ "$FILE_COUNT" -eq 0 ]; then
    tmux display-message "No saved environments to delete"
    exit 0
fi

# Delete all saved environment files
find "$RESURRECT_DIR" -maxdepth 1 -name "tmux_resurrect_*.txt" -type f -delete

# Remove the 'last' symlink if it exists
[ -L "$RESURRECT_DIR/last" ] && rm -f "$RESURRECT_DIR/last"

# Also remove pane contents if they exist
[ -d "$RESURRECT_DIR/save" ] && rm -rf "$RESURRECT_DIR/save"
[ -d "$RESURRECT_DIR/restore" ] && rm -rf "$RESURRECT_DIR/restore"
[ -f "$RESURRECT_DIR/pane_contents.tar.gz" ] && rm -f "$RESURRECT_DIR/pane_contents.tar.gz"

tmux display-message "Deleted $FILE_COUNT saved environment(s)"

