-- Require
require("hyprland/windows")
require("hyprland/rows")
require("hyprland/animations")

-- Define monitors
hl.monitor({
    output = "DP-1",
    mode = "2560x1440@240",
    position = "0x0",
    scale = "auto",
})

hl.monitor({
    output = "DP-2",
    mode = "2560x1440@165",
    position = "-1440x-600",
    scale = "auto",
    transform = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "3840x2160@60hz",
    position = "2560x0",
    scale = "1",
})

-- Sign workspaces to monitors
for w = 1, 5 do
    hl.workspace_rule({ workspace = tostring(w), monitor = "DP-1" })
end

for w = 6, 10 do
    hl.workspace_rule({ workspace = tostring(w), monitor = "DP-2" })
end
for w = 6, 10 do
    hl.workspace_rule({ workspace = tostring(w), layout = "scrolling" })
end

-- Vars for programs
local terminal = "ghostty"
local fileManager = "dolphin"
local menu = "hyprlauncher"
local browser = "firefox"

-- Start-up
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper & ashell & hyprsunset")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

-- Exports
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("GTK2_RC_FILES", "/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc")
hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")

hl.config({
    input = {
        kb_layout = "fi",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
    misc = {
        force_default_wallpaper = 1,  -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

local mainMod = "SUPER"
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(
    mainMod .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("systemctl hibernate"))
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("hyprpicker -a --format=hex"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("firefox -private-window"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Hyprshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))

-- Toggle VPN
-- nmcli connection import type wireguard file airvpn_x.conf
-- hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("~/.local/bin/vpn-toggle"))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border = { colors = { "rgba(44a8daff)", "rgba(1793d1ff)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 0,
        rounding_power = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 0.9,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aff)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        force_split = 0,
        preserve_split = true,
        smart_split = false,
        smart_resizing = true,
        permanent_direction_override = false,
        special_scale_factor = 1,
        split_width_multiplier = 1.0,
        use_active_for_splits = true,
        default_split_ratio = 1.0,
        split_bias = 0,
        precise_mouse_move = false,
    },
    scrolling = {
        direction = "down",
        wrap_focus = true,
    }
})
