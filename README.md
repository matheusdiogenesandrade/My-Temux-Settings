# My Tmux Configuration

A comprehensive tmux configuration featuring a beautiful Catppuccin theme, useful plugins, and vim-style key bindings for efficient terminal management.

## Features

- 🎨 **Catppuccin Macchiato Theme** - Beautiful, modern color scheme
- 🔌 **Plugin Management** - Managed via TPM (Tmux Plugin Manager)
- ⌨️ **Vim-style Navigation** - Seamless navigation between panes, windows, and vim
- 📊 **Status Bar** - Shows CPU, battery, uptime, application, and session info
- 🖱️ **Mouse Support** - Full mouse interaction enabled
- 📋 **Enhanced Copy/Paste** - Improved clipboard integration with xclip
- 🔋 **Battery Status** - Displays battery information in status bar
- 💻 **CPU Monitoring** - Real-time CPU usage display
- 💾 **Session Management** - Save and restore sessions with tmux-resurrect
- 🔍 **Session Browser** - Advanced session management with fuzzy finding and previews (tmux-sessionx)
- 🧹 **Session Cleanup** - Clear saved environments with a single command
- 🎯 **Process Management** - Quick kill processes with tmux-cowboy

## Quick Start

### Prerequisites

- tmux (version 1.9 or higher)
- git
- bash
- xclip (for Linux clipboard support)
- upower or acpi (for battery status on Linux)
- Optional: iostat/sar (for accurate CPU stats)

### Installation

1. Clone or copy this configuration to `~/.tmux/`:
   ```bash
   git clone <repository> ~/.tmux
   ```

2. Create a symlink to your tmux config:
   ```bash
   ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
   ```

3. Start tmux and install plugins:
   ```bash
   tmux
   # Press Ctrl+B then I (capital I) to install plugins
   ```

4. Reload configuration (if needed):
   ```bash
   tmux source-file ~/.tmux.conf
   ```

## Key Bindings Quick Reference

**Prefix Key:** `Ctrl+B` (default)

### Pane Management
- `Ctrl+B |` - Split pane horizontally
- `Ctrl+B -` - Split pane vertically
- `Ctrl+B h/j/k/l` - Navigate panes (vim-style)
- `Alt+h/j/k/l` - Navigate panes without prefix
- `Alt+Arrow Keys` - Navigate panes without prefix
- `Ctrl+B 4/6/8/5` - Resize pane (Left/Right/Up/Down)
- `Ctrl+B *` - Kill process in current pane (tmux-cowboy)

### Window Management
- `Ctrl+B c` - New window
- `Ctrl+B ,` - Rename window
- `Ctrl+B 0-9` - Switch to window by number
- `Ctrl+B n` - Next window
- `Ctrl+B p` - Previous window

### Copy Mode (Vi-style)
- `Ctrl+B [` - Enter copy mode
- `v` - Begin selection
- `y` - Yank (copy) selection to clipboard
- `r` - Toggle rectangle selection
- `o` - Open highlighted text (tmux-open)
- `Ctrl+o` - Open highlighted text in editor (tmux-open)

### Session Management
- `Ctrl+B f` - Open session manager with fuzzy finding (tmux-sessionx)
- `Ctrl+B Ctrl+s` - Save current tmux environment (tmux-resurrect)
- `Ctrl+B Ctrl+r` - Restore last saved environment (tmux-resurrect)
- `Ctrl+B X` - Clear all saved environments (tmux-resurrect)

### Plugins
- `Ctrl+B I` - Install/update plugins (TPM)
- `Ctrl+B U` - Update plugins (TPM)
- `Ctrl+B Alt+u` - Uninstall plugins (TPM)

### Vim-Tmux Navigation
- `Ctrl+h/j/k/l` - Navigate panes (works seamlessly with vim splits)

## Status Bar

The status bar displays:
- **Left:** Window list with Catppuccin styling
- **Right:** Application name, CPU usage, session info, uptime, and battery status

## Plugins

This configuration includes the following plugins:

1. **TPM** - Tmux Plugin Manager
2. **tmux-sensible** - Sensible defaults for tmux
3. **tmux-resurrect** - Save and restore tmux sessions
4. **tmux-continuum** - Automatic saving and restoring of tmux sessions
5. **catppuccin/tmux** - Beautiful Catppuccin theme
6. **tmux-cpu** - CPU usage display
7. **tmux-battery** - Battery status display
8. **tmux-open** - Open files/URLs from copy mode
9. **tmux-cowboy** - Quick kill processes
10. **tmux-sessionx** - Advanced session management with fuzzy finding and previews
11. **vim-tmux-navigator** - Seamless vim/tmux navigation

## Session Management

### tmux-sessionx - Interactive Session Browser

**tmux-sessionx** provides an advanced session management interface with fuzzy finding and session previews.

**Usage:**
- Press `Ctrl+B` then `f` to open the session manager interface

**Features:**
- **Fuzzy Find Sessions** - Quickly search and filter sessions by typing
- **Preview Sessions** - View session details before switching
- **Switch Sessions** - Select a session to switch to it
- **Delete Sessions** - Remove unwanted sessions directly from the interface
- **Rename Sessions** - Change session names for better organization

**Customizing the Key Binding:**

To change the default key binding from `f` to something else, add this to `.tmux.conf`:

```tmux
set -g @sessionx-bind 'your_preferred_key'
```

For example, to use `Ctrl+B x` instead:
```tmux
set -g @sessionx-bind 'x'
```

**Note:** The default tmux binding `Ctrl+B s` already lists sessions, but tmux-sessionx provides a more advanced interface with fuzzy finding and previews.

### tmux-resurrect - Saving and Restoring Sessions

**Save your current tmux environment:**
- Press `Ctrl+B` then `Ctrl+s`
- Your session state is saved to `~/.tmux/resurrect/` (or `~/.local/share/tmux/resurrect/`)

**Restore a saved session:**
- Press `Ctrl+B` then `Ctrl+r`
- Your last saved environment will be restored

**View all saved environments:**
```bash
ls -lh ~/.tmux/resurrect/
# or
ls -lh ~/.local/share/tmux/resurrect/
```

Each save creates a timestamped file (e.g., `tmux_resurrect_20251220T212458.txt`). The `last` symlink points to the most recent save.

**Clear all saved environments:**
- Press `Ctrl+B` then `X` (capital X)
- This deletes all saved environment files and cleans up related data

**Restore a specific previous environment:**
1. List saved files: `ls ~/.tmux/resurrect/`
2. Update the `last` symlink: `cd ~/.tmux/resurrect/ && ln -sf tmux_resurrect_YYYYMMDDTHHMMSS.txt last`
3. Restore: Press `Ctrl+B` then `Ctrl+r`

### Automatic Saving (tmux-continuum)

With `tmux-continuum` installed, your tmux environment is:
- **Automatically saved** every 15 minutes in the background
- **Automatically restored** when tmux starts (if enabled)

The automatic restore feature is enabled by default. To disable it, edit `.tmux.conf`:
```tmux
set -g @continuum-restore 'off'
```

## Configuration

### Theme Customization

The theme is set to Catppuccin Macchiato. To change flavors, edit `.tmux.conf`:

```tmux
set -g @catppuccin_flavor 'latte'  # or 'frappe', 'macchiato', 'mocha'
```

### Window Style

Current window style is "rounded". Options:
- `basic`
- `none`
- `rounded`
- `slanted`

Change in `.tmux.conf`:
```tmux
set -g @catppuccin_window_status_style "rounded"
```

## Custom Options

- **Base Index:** Windows start at 1 (instead of 0)
- **Mouse:** Full mouse support enabled
- **History:** 10,000 lines of scrollback
- **Vi Mode:** Vi-style key bindings enabled
- **Escape Time:** 0ms delay for escape key

## Troubleshooting

### Plugins not loading
- Run `tmux source-file ~/.tmux.conf`
- Press `Ctrl+B` then `I` to install plugins

### Battery not showing
- Install `upower` or `acpi` on Linux
- Check if battery device is detected: `upower -e`

### CPU not showing
- Install `iostat` or `sar` for accurate readings
- Plugin falls back to `ps aux` if unavailable

### Copy/paste not working
- Install `xclip` on Linux: `sudo apt install xclip` (Debian/Ubuntu)
- On macOS, ensure `pbcopy` is available

## License

This configuration uses various plugins with their respective licenses (mostly MIT).
