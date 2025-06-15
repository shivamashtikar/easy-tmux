#!/bin/bash

# This script sets up the tmux configuration for a cloud environment.
# It creates a symbolic link from the local tmux.conf.cloud to ~/.tmux.conf.

# Define the source and target file paths
SOURCE_CONFIG_FILE="$(pwd)/tmux.conf.cloud"
TARGET_CONFIG_FILE="$HOME/.tmux.conf"

echo "Setting up tmux cloud configuration..."

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
