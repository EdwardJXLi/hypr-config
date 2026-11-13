-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can split this configuration into multiple files
-- Create your files separately and then require them in this file like this:
-- require("myColors")


--###############
--## PLUGINS  ###
--###############

local hs = require("hyprsplit")
hs.config({
    num_workspaces = 10,
    persistent_workspaces = false,
})

-- hyprpm loads hyprbars after startup and reloads the config when it is ready.
if hl.plugin.hyprbars then
    hl.config({
        plugin = {
            hyprbars = {
                bar_height = 30,
                bar_text_size = 12,
                bar_buttons_alignment = "left",
                bar_padding = 12,
                bar_button_padding = 7,
            },
        },
    })
    hl.plugin.hyprbars.add_button({ bg_color = "rgb(ff4040)", fg_color = "rgb(ffffff)", size = 12, icon = "", action = "hyprctl dispatch killactive" })
    hl.plugin.hyprbars.add_button({ bg_color = "rgb(eeee11)", fg_color = "rgb(ffffff)", size = 12, icon = "", action = "hyprctl dispatch fullscreen 1" })
    hl.plugin.hyprbars.add_button({ bg_color = "rgb(87CEEB)", fg_color = "rgb(ffffff)", size = 12, icon = "", action = "hyprctl dispatch togglefloating" })
end


--###############
--## MONITORS ###
--###############

-- See https://wiki.hypr.land/Configuring/Monitors/
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "1920x1200@60.0", position = "2160x1850", scale = 1.0 })
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60.0", position = "4080x1610", scale = 1.0 })
hl.monitor({ output = "desc:LG Electronics LG ULTRAFINE 202NTKFDW837", mode = "3840x2160@60.0", position = "4080x1024", scale = 1.0 })
hl.monitor({ output = "desc:Dell Inc. DELL S2725QS 6GSHT84", mode = "3840x2160@60.0", position = "0x0", scale = 1.0, transform = 1 })
hl.monitor({ output = "desc:BOE Display 0x01010120", mode = "2160x1440@60.0", position = "0x1610", scale = 1.0 })
hl.monitor({ output = "desc:Invalid Vendor Codename - RTK 0x1920 0x19201200", mode = "1920x1200@59.95", position = "4080x1850", scale = 1.0 })

-- Work Monitors
hl.monitor({ output = "desc:Dell Inc. DELL U2723QE 6B0LF34", mode = "3840x2160@60.0", position = "1594x122", scale = 1.25 })

--##################
--## MY PROGRAMS ###
--##################

-- See https://wiki.hypr.land/Configuring/Keywords/

-- Set programs that you use
local terminal = "kitty"
local browser = "firefox"
local browser_private = "firefox --private-window"
local fileManager = "dolphin"
-- local menu = "wofi --show drun -D key_expand=Tab"
local menu = "vicinae toggle"

--################s
--## AUTOSTART ###
--################

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
    -- hl.exec_cmd(terminal)
    -- hl.exec_cmd("waybar & hyprpaper & firefox")
    hl.exec_cmd("kwalletd6")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    -- waybar is started by waybar.service (auto-restarts on crash) via hyprland-session.target
    hl.exec_cmd("hyprpaper & hypridle")
    hl.exec_cmd("nm-applet & blueman-applet")
    hl.exec_cmd("vicinae server")
    hl.exec_cmd("systembus-notify")
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("batsignal -w 25 -c 10 -d 5")
    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd("hyprtab daemon")
    hl.exec_cmd("/home/hydra/.local/bin/openwhispr")

    -- Export Wayland env to systemd/dbus and bring up the graphical session so xdg-desktop-portal starts
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user start hyprland-session.target")

    -- Fix some stupid race condition with one of the window rules
    hl.exec_cmd("sleep 0.5 && hyprctl reload")
end)

--############################
--## ENVIRONMENT VARIABLES ###
--############################

-- See https://wiki.hypr.land/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- # Fixes KDE app menus
-- hl.env("XDG_MENU_PREFIX", "arch-")

-- # Make home-manager / nix profile apps visible to all Hyprland-launched apps
-- hl.env("XDG_DATA_DIRS", "/home/hydra/.nix-profile/share:/nix/var/nix/profiles/default/share:/usr/local/share:/usr/share")
-- hl.env("NIX_PROFILES", "/nix/var/nix/profiles/default /home/hydra/.nix-profile")
-- hl.env("XDG_CONFIG_DIRS", "/etc/xdgnix/var/nix/profiles/default/etc/xdg:/home/hydra/.nix-profile/etc/xdg")


--##################
--## PERMISSIONS ###
--##################

-- See https://wiki.hypr.land/Configuring/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({ ecosystem = {
--     enforce_permissions = true,
-- } })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


--####################
--## LOOK AND FEEL ###
--####################

-- Refer to https://wiki.hypr.land/Configuring/Variables/

-- https://wiki.hypr.land/Configuring/Variables/#general
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,

        border_size = 2,

        -- https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
        ["col.active_border"] = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
        ["col.inactive_border"] = "rgba(595959aa)",

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",

        snap = {
            enabled = true,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#decoration
hl.config({
    decoration = {
        rounding = 0,
        -- rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 0.975,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        -- https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
            enabled = true,
            size = 3,
            passes = 1,

            vibrancy = 0.1696,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#animations
hl.config({ animations = { enabled = false } })

-- Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
--        NAME,           X0,   Y0,   X1,   Y1
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default animations, see https://wiki.hypr.land/Configuring/Animations/
--           NAME,          ONOFF, SPEED, CURVE,        [STYLE]
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "smart-gaps-border-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
-- hl.window_rule({ name = "smart-gaps-rounding-wtv1", match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
-- hl.window_rule({ name = "smart-gaps-border-f1", match = { float = false, workspace = "f[1]" }, border_size = 0 })
-- hl.window_rule({ name = "smart-gaps-rounding-f1", match = { float = false, workspace = "f[1]" }, rounding = 0 })

hl.workspace_rule({ workspace = "special:magic", gaps_out = 100 })

-- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
        middle_click_paste = false,
    },
})


--############
--## INPUT ###
--############

-- https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 2,

        sensitivity = -0.1, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.config({
    cursor = {
        no_warps = true,
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#gestures
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "down", action = "close", mods = "ALT" })
hl.gesture({ fingers = 4, direction = "up", action = "fullscreen", mods = "SUPER", scale = 1.5 })

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})


--##################
--## KEYBINDINGS ###
--##################

-- See https://wiki.hypr.land/Configuring/Keywords/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more

-- Custom keybinds
hl.bind("CONTROL + space", hl.dsp.exec_cmd(menu))
hl.bind("ALT + grave", hl.dsp.exec_cmd("kitten quick-access-terminal"))
hl.bind("SUPER + G", hl.dsp.exec_cmd("/home/hydra/.local/bin/hints"))
hl.bind("SUPER + period", hl.dsp.exec_cmd("/home/hydra/.local/bin/hypremoji"))

-- Alt Tab
hl.bind("ALT + Tab", hl.dsp.exec_cmd("hyprtab next"))
hl.bind("ALT + SHIFT + Tab", hl.dsp.exec_cmd("hyprtab prev"))

-- Screenshot
hl.bind("CONTROL + SHIFT + 3", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))
hl.bind("CONTROL + SHIFT + 4", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind("CONTROL + SHIFT + 5", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))

-- Color picker
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a -f hex"))

-- Lock screen
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock --immediate & systemctl suspend"))

-- Helpers
hl.bind(mainMod .. " + CTRL + ALT + delete", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + return", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + CTRL + SHIFT + return", hl.dsp.exec_cmd(browser_private))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move window with mod shift + arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hs.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hs.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hs.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hs.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hs.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hs.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hs.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hs.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hs.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hs.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hs.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hs.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hs.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hs.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hs.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hs.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hs.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hs.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hs.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hs.dsp.window.move({ workspace = 10 }))

-- Move focus between monitors
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ monitor = "r" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ monitor = "r" }))

-- Misc keybinds for handing multiple monitors
hl.bind(mainMod .. " + SHIFT + backslash", hs.dsp.grab_rogue_windows())

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Lock on lid close
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock --immediate & systemctl suspend"), { locked = true })

--#############################
--## WINDOWS AND WORKSPACES ###
--#############################

-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

-- Example windowrule
-- hl.window_rule({ name = "kitty-float", match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })

-- Ignore maximize requests from apps.
hl.window_rule({
    match = {
        class = ".*",
    },
    name = "windowrule-2",
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    name = "windowrule-3",
    no_focus = true,
})

-- Force all new windows to go to new workspace
hl.window_rule({
    match = {
        class = ".*",
        float = false,
    },
    name = "open-in-new-workspace",
    workspace = "empty",
})

-- Disable bars by default
hl.window_rule({
    match = {
        float = false,
    },
    name = "no-bars",
    ["hyprbars:no_bar"] = hl.plugin.hyprbars ~= nil or nil,
})

-- Window rules for HyprEmoji
hl.window_rule({
    match = {
        title = "^(HyprEmoji)$",
    },
    name = "hypremoji-float",
    float = true,
    ["hyprbars:no_bar"] = hl.plugin.hyprbars ~= nil or nil,
})

hl.window_rule({
    match = {
        title = "^(HyprEmoji)$",
    },
    name = "hypremoji-move",
    move = "(cursor_x-(window_w*0.5)) (cursor_y-(window_h*0.05))",
})

-- OpenWhispr disable voice recorder overlay
hl.window_rule({
    match = {
        class = "open-whispr",
        title = "Voice Recorder",
    },
    name = "openwhispr-recorder",
    ["hyprbars:no_bar"] = hl.plugin.hyprbars ~= nil or nil,
    no_blur = true,
    no_anim = true,
    border_size = 0,
    no_shadow = true,
    -- Uncomment this to hide the popup entirely
    -- workspace = "special:whispr silent",
})

--##################
--## DARK MODE ###
--##################

hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_PATH", "/usr/share/icons")
