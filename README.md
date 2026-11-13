# Edward Li's Hyprland Config

Personal [Hyprland](https://hypr.land/)/[Wayland](https://wayland.freedesktop.org/) desktop config for EdwardArch (main linux machine).

## Main Contents

- `hypr/`
  - `hyprland.lua` - main config (keybinds, window rules, startup, etc.)
  - `hypridle.conf` - idle and lock config
  - `hyprlock.conf` - lock screen config
  - `hyprpaper.conf` - wallpaper config
- `waybar/` - status bar config and styling
- `wofi/` - app launcher styling (deprecated)

## Setup

Use Hyprland 0.55 or later. Install and enable `hyprbars` with `hyprpm`.

Before switching to the Lua config, disable the native hyprsplit plugin:

```sh
hyprpm disable hyprsplit
```

Restart Hyprland to load `hypr/hyprland.lua`.
