# Tmux Configuration - Complete Command Reference

This document provides a comprehensive reference for all commands, key bindings, and features in this tmux configuration.

## Table of Contents

1. [Key Bindings](#key-bindings)
2. [Plugin Commands](#plugin-commands)
3. [Status Bar Configuration](#status-bar-configuration)
4. [Advanced Usage](#advanced-usage)

---

## Key Bindings

### Prefix Key

The default prefix key is `Ctrl+B`. All commands below assume you press the prefix key first, unless noted otherwise.

### Pane Management

#### Creating Panes
- `|` - Split window horizontally (new pane to the right)
- `-` - Split window vertically (new pane below)
- Both splits maintain the current working directory

#### Navigating Panes
- `h` - Move to left pane
- `j` - Move to lower pane
- `k` - Move to upper pane
- `l` - Move to right pane

#### Navigate Without Prefix (Alt Keys)
These work without pressing the prefix key:
- `Alt+h` - Move to left pane
- `Alt+j` - Move to lower pane
- `Alt+k` - Move to upper pane
- `Alt+l` - Move to right pane
- `Alt+Left` - Move to left pane
- `Alt+Right` - Move to right pane
- `Alt+Up` - Move to upper pane
- `Alt+Down` - Move to lower pane

#### Resizing Panes
All resize commands use repeatable key bindings (press and hold):
- `4` (repeatable) - Resize pane left by 10 cells
- `6` (repeatable) - Resize pane right by 10 cells
- `8` (repeatable) - Resize pane up by 10 cells
- `5` (repeatable) - Resize pane down by 10 cells

#### Pane Actions
- `*` - Kill the process running in the current pane (tmux-cowboy)
  - Uses `kill -9` to forcefully terminate the process
  - Useful for hanging or unresponsive processes

### Window Management

#### Creating and Managing Windows
- `c` - Create a new window
- `,` - Rename the current window
- `&` - Kill the current window (with confirmation)
- `0-9` - Switch to window by number (0-9)
- `n` - Next window
- `p` - Previous window
- `l` - Last active window
- `'` - Prompt for window index to select

#### Window Navigation
- `(` - Switch to previous session
- `)` - Switch to next session

### Copy Mode (Vi-style)

Enter copy mode with `[` or use mouse selection.

#### Selection
- `v` - Begin visual selection
- `r` - Toggle rectangle selection mode
- `Mouse Drag` - Select text with mouse
- `Mouse Release` - Copy selection to clipboard

#### Copying
- `y` - Yank (copy) selection to clipboard
  - Automatically copies to both primary and clipboard (Linux)
  - Works with xclip integration

#### Opening Files/URLs (tmux-open)
- `o` - Open highlighted selection with default application
  - URLs open in browser
  - Files open with default application
  - Uses `xdg-open` on Linux, `open` on macOS
- `Ctrl+o` - Open highlighted selection in `$EDITOR`
  - Useful for editing files directly from copy mode

### Session Management

#### Basic Commands
- `d` - Detach from session
- `s` - List and switch sessions (interactive)
- `$` - Rename current session
- `D` - Choose a client to detach

### Plugin Management (TPM)

- `I` (capital I) - Install new plugins
  - Fetches plugins from GitHub
  - Sources them automatically
- `U` (capital U) - Update plugins
  - Updates all installed plugins
- `Alt+u` - Uninstall plugins
  - Removes plugins not in the plugin list

### Help and Information

- `?` - List all key bindings
- `:` - Enter command prompt
- `/` - Search key bindings by key sequence

---

## Plugin Commands

### tmux-resurrect

Save and restore tmux sessions automatically.

**Default Key Bindings:**
- `Ctrl+B Ctrl+s` - Save session
- `Ctrl+B Ctrl+r` - Restore session

**Manual Commands:**
```bash
# Save session manually
~/.tmux/plugins/tmux-resurrect/scripts/save.sh

# Restore session manually
~/.tmux/plugins/tmux-resurrect/scripts/restore.sh
```

**Features:**
- Saves all panes and their layouts
- Restores pane contents (if supported)
- Preserves window/pane ordering
- Works across reboots

### tmux-cowboy

Quickly kill processes in the current pane.

**Key Binding:**
- `Ctrl+B *` - Kill process in current pane with `kill -9`

**Usage:**
1. Navigate to a pane with a running process
2. Press `Ctrl+B` then `*` (asterisk/Shift+8)
3. Process is immediately terminated

**Warning:** Uses `kill -9` which forcefully terminates processes without cleanup.

### tmux-open

Open files and URLs from copy mode.

**Key Bindings (in copy mode):**
- `o` - Open selection with default application
- `Ctrl+o` - Open selection in `$EDITOR`

**Supported:**
- File paths (absolute or relative)
- URLs (http, https, etc.)
- Email addresses (opens mail client)

### vim-tmux-navigator

Seamless navigation between vim splits and tmux panes.

**Key Bindings:**
- `Ctrl+h` - Navigate left (pane or vim split)
- `Ctrl+j` - Navigate down (pane or vim split)
- `Ctrl+k` - Navigate up (pane or vim split)
- `Ctrl+l` - Navigate right (pane or vim split)
- `Ctrl+\` - Navigate to previous pane/window

**Features:**
- Automatically detects if you're in vim
- Sends keys to vim if in vim, otherwise navigates tmux panes
- Works in both normal mode and copy mode

---

## Status Bar Configuration

### Left Side

Displays the window list with Catppuccin theme styling:
- Current window highlighted
- Window numbers starting from 1
- Window names
- Rounded style

### Right Side

Displays (in order):
1. **Application** - Current application name
2. **CPU** - CPU usage percentage (from tmux-cpu)
3. **Session** - Session information
4. **Uptime** - System uptime
5. **Battery** - Battery status and percentage (from tmux-battery)

### Status Bar Update Interval

Updates every 60 seconds:
```tmux
set -g status-interval 60
```

### Customization

The status bar modules are configured via Catppuccin plugin options. Each module can be customized in `.tmux.conf`:

```tmux
# Enable/disable modules
set -g @catppuccin_status_modules_right "application cpu session uptime battery"
```

---

## Advanced Usage

### Custom Key Bindings

To add custom key bindings, edit `.tmux.conf`:

```tmux
# Example: Bind Ctrl+B r to reload config
bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
```

### Plugin Configuration

#### Catppuccin Theme Options

```tmux
# Change flavor (latte, frappe, macchiato, mocha)
set -g @catppuccin_flavor 'macchiato'

# Change window style (basic, none, rounded, slanted)
set -g @catppuccin_window_status_style "rounded"

# Customize window text
set -g @catppuccin_window_default_text "#W"
set -g @catppuccin_window_current_text "#W"
```

#### tmux-cpu Options

```tmux
# CPU icon thresholds
set -g @cpu_low_icon "="
set -g @cpu_medium_icon "≡"
set -g @cpu_high_icon "≣"

# CPU percentage thresholds
set -g @cpu_medium_thresh "30"
set -g @cpu_high_thresh "80"
```

#### tmux-battery Options

Battery display automatically detects:
- `upower` (Linux, preferred)
- `acpi` (Linux, fallback)
- `pmset` (macOS)
- `/sys/class/power_supply` (WSL)

### Environment Variables

The configuration respects:
- `$EDITOR` - Used by tmux-open for `Ctrl+o` binding

### Script Execution

Plugins are loaded in this order:
1. Catppuccin theme
2. tmux-cpu
3. tmux-battery
4. TPM (which loads remaining plugins)

### Working Directory Preservation

Pane splits preserve the current working directory:
- `|` and `-` use `-c "#{pane_current_path}"`
- New panes start in the same directory as the current pane

### Window Numbering

- Windows start at index 1 (not 0)
- Windows are automatically renumbered when windows are closed
- Configured with: `set -g base-index 1` and `set-option -g renumber-windows on`

### History and Scrolling

- **History Limit:** 10,000 lines
- **Scrollback:** Access with `Ctrl+B [` or mouse wheel
- **Vi Mode:** Use vi-style navigation in copy mode

### Mouse Support

Fully enabled mouse support includes:
- Click to select panes
- Drag to resize panes
- Scroll to browse history
- Click and drag to select text in copy mode

### Terminal Compatibility

Configured for:
- `tmux-256color` terminal type
- Full color support with `Tc` capability
- X11 clipboard integration (xclip)

### Escape Key Delay

Set to 0ms for instant mode switching:
```tmux
set -sg escape-time 0
```

---

## Troubleshooting Commands

### Check Plugin Status

```bash
# List installed plugins
ls ~/.tmux/plugins/

# Check if plugin is loaded
tmux show-options -g | grep plugin
```

### Debug Key Bindings

```bash
# List all key bindings
tmux list-keys

# List prefix key bindings
tmux list-keys -T prefix

# List copy mode bindings
tmux list-keys -T copy-mode-vi
```

### Reload Configuration

```bash
# Reload config file
tmux source-file ~/.tmux.conf

# Or from within tmux
# Press Ctrl+B then : and type:
source-file ~/.tmux.conf
```

### Check Plugin Scripts

```bash
# Test battery script
~/.tmux/plugins/tmux-battery/scripts/battery_percentage.sh

# Test CPU script
~/.tmux/plugins/tmux-cpu/scripts/cpu_percentage.sh

# Test cowboy script (kills current pane process!)
# Use with caution
~/.tmux/plugins/tmux-cowboy/scripts/kill.sh KILL
```

---

## Command Reference Summary

### Essential Daily Commands

| Action | Key Binding |
|--------|-------------|
| Split horizontal | `Ctrl+B \|` |
| Split vertical | `Ctrl+B -` |
| Navigate panes | `Ctrl+B h/j/k/l` |
| Navigate (no prefix) | `Alt+h/j/k/l` |
| Kill process | `Ctrl+B *` |
| New window | `Ctrl+B c` |
| Copy mode | `Ctrl+B [` |
| Copy selection | `v` then `y` (in copy mode) |
| Open file/URL | `o` (in copy mode) |
| Install plugins | `Ctrl+B I` |

### Plugin Management

| Action | Key Binding |
|--------|-------------|
| Install plugins | `Ctrl+B I` |
| Update plugins | `Ctrl+B U` |
| Uninstall plugins | `Ctrl+B Alt+u` |

### Navigation Shortcuts

| Action | Key Binding |
|--------|-------------|
| Vim-style nav | `Ctrl+h/j/k/l` |
| Alt nav (no prefix) | `Alt+h/j/k/l` |
| Arrow nav (no prefix) | `Alt+Arrow Keys` |

---

For more information about specific plugins, refer to their individual README files in the `plugins/` directory.

