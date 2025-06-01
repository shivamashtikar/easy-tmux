# easy-tmux

A streamlined `tmux` configuration setup designed to enhance your terminal multiplexing experience with intuitive keybindings, efficient pane management, and useful plugins.

## Features

* **Custom Keybindings**: Navigate and manage panes/windows using `Alt` and `Shift` combinations.
* **Persistent Sessions**: Automatically save and restore sessions using `tmux-resurrect` and `tmux-continuum`.
* **Enhanced Navigation**: Seamless movement between `tmux` panes and `vim` splits with `sunaku/tmux-navigate`.
* **Fuzzy Finder Integration**: Quickly switch between windows and panes using `tmux-fzf`.
* **Clipboard Support**: Copy to system clipboard with `xclip` or `pbcopy`, depending on your OS.
* **Mouse Support**: Enable mouse interactions for pane selection and resizing.
* **Custom Theme**: Aesthetic status bar with directory name display using `tmux-onedark-theme`.

## Prerequisites

Ensure the following are installed on your system:

* [tmux](https://github.com/tmux/tmux) (version 3.2a or higher recommended)
* [git](https://git-scm.com/)
* [xclip](https://github.com/astrand/xclip) (for Linux clipboard integration)
* [pbcopy/pbpaste](https://ss64.com/osx/pbcopy.html) (for macOS clipboard integration)

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/shivamashtikar/easy-tmux.git
   cd easy-tmux
   ```



2. **Run the Setup Script**:

   ```bash
   sh setup.sh
   ```



This script will:

* Copy the `tmux.conf` file to your home directory as `.tmux.conf`.
* Clone the [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm) into `~/.tmux/plugins/tpm`.

3. **Install Plugins**:

   After starting `tmux`, press `Prefix` + `I` (that's `Ctrl+b` followed by `I`) to install the plugins specified in the configuration.

## Keybindings Overview

| Action                       | Keybinding                 |
| ---------------------------- | -------------------------- |
| Split pane vertically        | `Alt + /`                  |
| Split pane horizontally      | `Alt + '`                  |
| Navigate panes               | `Alt + Arrow Keys`         |
| Resize panes                 | `Shift + Arrow Keys`       |
| Create new window            | `Alt + n`                  |
| Create new session           | `Alt + N`                  |
| Toggle full-screen pane      | `Alt + f`                  |
| View all windows (tree view) | `Alt + d`                  |
| Close current pane           | `Alt + q`                  |
| Close current window         | `Alt + Q`                  |
| Reload tmux configuration    | `Prefix + R`               |
| Open htop in new pane        | `Prefix + p`               |
| List all keybindings         | `Prefix + ?`               |
| Switch to last pane          | `Prefix + Ctrl + a`        |
| Copy mode (vi-style)         | `v` to select, `y` to copy |
| Open fzf window switcher     | `Alt + o`                  |

*Note*: The `Prefix` key is `Ctrl + b` by default.

## Plugin Integrations

* **[tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)**: Manages `tmux` plugins.
* **[tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)**: Provides default settings that "just work".
* **[sunaku/tmux-navigate](https://github.com/sunaku/tmux-navigate)**: Enables seamless navigation between `tmux` panes and `vim` splits.
* **[sainnhe/tmux-fzf](https://github.com/sainnhe/tmux-fzf)**: Adds fuzzy finder capabilities for quick navigation.
* **[tmux-plugins/tmux-copycat](https://github.com/tmux-plugins/tmux-copycat)**: Enhances searching in `tmux` copy mode.
* **[tmux-plugins/tmux-open](https://github.com/tmux-plugins/tmux-open)**: Enables opening highlighted selections with the system opener.
* **[tmux-plugins/tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)**: Saves and restores `tmux` sessions.
* **[tmux-plugins/tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)**: Automates saving of `tmux` environments.
* **[shivamashtikar/tmux-onedark-theme](https://github.com/shivamashtikar/tmux-onedark-theme)**: Applies a One Dark theme to the status bar.

## Customization

Feel free to modify the `.tmux.conf` file to suit your preferences. For instance, you can change keybindings, adjust the status bar, or add/remove plugins as needed.

## Troubleshooting

* **Clipboard Issues**: Ensure `xclip` (Linux) or `pbcopy/pbpaste` (macOS) is installed for clipboard integration.
* **Plugin Installation**: If plugins aren't installing, verify that TPM is correctly cloned into `~/.tmux/plugins/tpm` and that you're pressing `Prefix + I` inside a `tmux` session.
* **Mouse Support**: If mouse interactions aren't working, ensure that your terminal emulator supports mouse events and that `set -g mouse on` is present in your `.tmux.conf`.

## License

This project is licensed under the [MIT License](LICENSE).

---

For more details and updates, visit the [easy-tmux GitHub repository](https://github.com/shivamashtikar/easy-tmux).

---
