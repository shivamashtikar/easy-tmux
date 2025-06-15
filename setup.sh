#!/bin/bash

# Exit on any error
set -e

# Define paths
# Ensure this script is run from the 'easy-tmux' directory for pwd to be correct
SCRIPT_DIR_TMUX="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_CONFIG_FILE="$SCRIPT_DIR_TMUX/tmux.conf"
TARGET_CONFIG_FILE="$HOME/.tmux.conf"
TPM_PATH="$HOME/.tmux/plugins/tpm"

echo "Setting up tmux configuration..."

# --- Dynamically set default-shell in tmux.conf ---
USER_DEFAULT_SHELL=$(echo "$SHELL") # Get user's default shell

if [ -z "$USER_DEFAULT_SHELL" ]; then
    echo "Warning: Could not determine default shell from \$SHELL variable. default-shell in $SOURCE_CONFIG_FILE will not be modified."
elif [ ! -f "$SOURCE_CONFIG_FILE" ]; then
    echo "Warning: $SOURCE_CONFIG_FILE not found. Cannot set default-shell."
else
    echo "User's default shell is: $USER_DEFAULT_SHELL"
    # Escape the shell path for sed (especially for '/' characters)
    ESCAPED_USER_DEFAULT_SHELL=$(echo "$USER_DEFAULT_SHELL" | sed 's/[\/&]/\\&/g')
    
    # Check if default-shell is already set in tmux.conf
    if grep -q "^set-option -g default-shell" "$SOURCE_CONFIG_FILE"; then
        # If it exists, replace it
        sed -i.bak "s|^set-option -g default-shell .*|set-option -g default-shell $ESCAPED_USER_DEFAULT_SHELL|" "$SOURCE_CONFIG_FILE"
        echo "Updated default-shell in $SOURCE_CONFIG_FILE to $USER_DEFAULT_SHELL"
    else
        # If it doesn't exist, append it
        # Prepending to ensure it's not inside a conditional block or at the very end after `run tpm`
        # Create a temp file, add the shell, then cat original, then move
        TMP_CONF=$(mktemp)
        echo "set-option -g default-shell $USER_DEFAULT_SHELL" > "$TMP_CONF"
        echo "" >> "$TMP_CONF" # Add a newline
        cat "$SOURCE_CONFIG_FILE" >> "$TMP_CONF"
        mv "$TMP_CONF" "$SOURCE_CONFIG_FILE"
        echo "Added default-shell $USER_DEFAULT_SHELL to $SOURCE_CONFIG_FILE"
    fi
    # Remove backup file created by sed -i.bak (macOS behavior)
    rm -f "${SOURCE_CONFIG_FILE}.bak"
fi
# --- End of default-shell modification ---

# Check if the source configuration file exists (it might have been just created/modified)
if [ ! -f "$SOURCE_CONFIG_FILE" ]; then
    echo "ERROR: Source configuration file not found: $SOURCE_CONFIG_FILE"
    exit 1
fi

# Remove existing ~/.tmux.conf if it's a symlink or file
if [ -L "$TARGET_CONFIG_FILE" ] || [ -f "$TARGET_CONFIG_FILE" ]; then
    echo "Found existing tmux configuration at $TARGET_CONFIG_FILE. Removing it."
    rm "$TARGET_CONFIG_FILE"
fi

# Create the symbolic link for tmux.conf
echo "Creating symbolic link from $SOURCE_CONFIG_FILE to $TARGET_CONFIG_FILE..."
ln -s "$SOURCE_CONFIG_FILE" "$TARGET_CONFIG_FILE"
echo "Successfully created symbolic link for tmux.conf."

# Clone TPM (Tmux Plugin Manager) if not already installed
if [ ! -d "$TPM_PATH" ]; then
    echo "Cloning Tmux Plugin Manager (TPM) to $TPM_PATH..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"
    echo "TPM cloned successfully."
else
    echo "TPM already installed at $TPM_PATH."
fi

echo ""
echo "Tmux setup complete."
echo "Please open tmux and press Ctrl+b I (uppercase i) to install plugins."
