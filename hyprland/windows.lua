hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move = "20 monitor_h-120",
    float = true,
})

-- Float steam client's child windows && Steam to DP-2.
-- hl.window_rule({
--     name = "float-steam-children",
--     match = {
--         initial_class = "steam",
--         initial_title = "(Friends List|about:blank.*|.*Chat.*)",
--     },
--     float = true,
-- })

-- Apps to side monitor
hl.window_rule({
    name = "launch-to-dp-2",
    match = {
        initial_title = "(.*Steam.*|.*Discord.*|.*Spotify.*)|Steam",
    },
    workspace = "6 silent",
})
-- Float steam client's child windows && Steam to DP-2.
hl.window_rule({
    name = "float-steam-children",
    match = {
        initial_title = "(Friends List|about:blank.*|.*Chat.*)",
    },
    workspace = "6 silent",
})

hl.window_rule({
    name = "float-steam-children",
    match = {
        title = "(.*Bitwarden.*)",
    },
    float = true,
})

-- Games to ws3
hl.window_rule({
    name = "steam-apps-to-ws3",
    match = {
        initial_class = "(steam_app_.*|cs2)",
    },
    workspace = "3",
})

-- Fullscreen orphan workspaces
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
    name = "no-gaps-wtv1",
    match = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding = 0,
})

hl.window_rule({
    name = "no-gaps-f1",
    match = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding = 0,
})
