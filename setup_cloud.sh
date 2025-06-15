#!/bin/bash

# This script sets up the tmux configuration for a cloud environment.
# It creates a symbolic link from the local tmux.conf.cloud to ~/.tmux.conf.

# Define the source and target file paths
# Ensure this script is run from the 'easy-tmux' directory for pwd to be correct,
# or adjust SOURCE_CONFIG_FILE path if the script can be run from elsewhere.
SCRIPT_DIR_TMUX="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_CONFIG_FILE="$SCRIPT_DIR_TMUX/tmux.conf.cloud" # More robust path
TARGET_CONFIG_FILE="$HOME/.tmux.conf"

echo "Setting up tmux cloud configuration..."

# --- Dynamically set default-shell in tmux.conf.cloud ---
USER_DEFAULT_SHELL=$(echo "$SHELL") # Get user's default shell

if [ -z "$USER_DEFAULT_SHELL" ]; then
    echo "Warning: Could not determine default shell from \$SHELL variable. default-shell in tmux.conf.cloud will not be modified."
elif [ ! -f "$SOURCE_CONFIG_FILE" ]; then
    echo "Warning: $SOURCE_CONFIG_FILE not found. Cannot set default-shell."
else
    echo "User's default shell is: $USER_DEFAULT_SHELL"
    # Escape the shell path for sed (especially for '/' characters)
    ESCAPED_USER_DEFAULT_SHELL=$(echo "$USER_DEFAULT_SHELL" | sed 's/[\/&]/\\&/g')
    
    # Check if default-shell is already set in tmux.conf.cloud
    if grep -q "^set-option -g default-shell" "$SOURCE_CONFIG_FILE"; then
        # If it exists, replace it
        sed -i.bak "s|^set-option -g default-shell .*|set-option -g default-shell $ESCAPED_USER_DEFAULT_SHELL|" "$SOURCE_CONFIG_FILE"
        echo "Updated default-shell in $SOURCE_CONFIG_FILE to $USER_DEFAULT_SHELL"
    else
        # If it doesn't exist, append it (ensure it's not commented out)
        # To be safe, let's add it near the top or ensure it's not in a commented block
        # For simplicity, we'll append. If a specific location is needed, awk or more complex sed is required.
        echo "" >> "$SOURCE_CONFIG_FILE" # Add a newline for separation
        echo "set-option -g default-shell $USER_DEFAULT_SHELL" >> "$SOURCE_CONFIG_FILE"
        echo "Added default-shell $USER_DEFAULT_SHELL to $SOURCE_CONFIG_FILE"
    fi
    # Remove backup file created by sed -i.bak (macOS behavior)
    # For Linux sed -i, this might not be created unless an extension is given.
    rm -f "${SOURCE_CONFIG_FILE}.bak"
fi
# --- End of default-shell modification ---

# Check if the source configuration file exists
if [ ! -f "$SOURCE_CONFIG_FILE" ]; then
    echo "ERROR: Source configuration file not found: $SOURCE_CONFIG_FILE"
    echo "Please ensure tmux.conf.cloud is in the current directory ($(pwd))."
    exit 1
fi

# Remove existing ~/.tmux.conf if it's a symlink or file to avoid `ln` error
if [ -L "$TARGET_CONFIG_FILE" ] || [ -f "$TARGET_CONFIG_FILE" ]; then
    echo "Found existing tmux configuration at $TARGET_CONFIG_FILE. Removing it."
    rm "$TARGET_CONFIG_FILE"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to remove existing $TARGET_CONFIG_FILE."
        exit 1
    fi
    echo "Removed existing $TARGET_CONFIG_FILE."
fi

# Create the symbolic link
echo "Creating symbolic link from $SOURCE_CONFIG_FILE to $TARGET_CONFIG_FILE..."
ln -s "$SOURCE_CONFIG_FILE" "$TARGET_CONFIG_FILE"

if [ $? -eq 0 ]; then
    echo "Successfully created symbolic link."
    echo "Tmux cloud configuration setup complete."
    echo "You can now start tmux to use the new configuration."
else
    echo "ERROR: Failed to create symbolic link."
    echo "Please check permissions or if the target path is valid."
    exit 1
fi

# Make the script executable (optional, user might do this manually)
# chmod +x setup_cloud.sh
