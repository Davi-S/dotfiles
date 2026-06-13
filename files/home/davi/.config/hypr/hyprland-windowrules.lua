-- Hyprland Windowrules
-- ====================
-- Reference: https://wiki.hyprland.org/Configuring/Window-Rules/
-- Reference:  https://wiki.hyprland.org/Configuring/Workspace-Rules/
-- Use `hyprctl clients` to see the windows


-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name = "windowrule-1",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "windowrule-2",
    match = {
        class = "^$",
        title = "^$",
        xwayland = 1,
        float = 1,
        fullscreen = 0,
        pin = 0,
    },
    no_focus = true,
})

-- Open browser on the first workspace
hl.window_rule({
    name = "windowrule-3",
    match = {
        class = "zen",
    },
    workspace = "1 silent",
})

-- Usually for Youtube videos. Make  them floating and pinned
hl.window_rule({
    name = "windowrule-4",
    match = {
        title = "Picture-in-Picture",
    },
    float = true,
    pin = true,
    size = "(monitor_w*0.35) (monitor_h*0.35)",
    move = "((monitor_w*1)-window_w-(monitor_w*0.1)) ((monitor_h*1)-window_h-(monitor_h*0.1))",
    keep_aspect_ratio = true,
})

-- For opening mvi (mpv with scripts for acting as image viewer) in floating mode
hl.window_rule({
    name = "windowrule-7",
    match = {
        class = "mvi",
    },
    float = true,
})

-- For the qualculate app to open as a floting window with some cool features
-- The settings bellow are used to center the window on the right half of the screen.
-- The formula is:
-- size: a%        b%
-- move: (b/2+25)% (a/2)%
hl.window_rule({
    name = "windowrule-8",
    match = {
        initial_title = "Qalculate!",
    },
    float = true,
    pin = true,
    opacity = "1.0 0.5",
    no_blur = true,
    size = "(monitor_w*0.3) (monitor_h*0.7)",
    move = "((monitor_w*0.6)) ((monitor_h*0.15))",
})

-- For opening custom terminals on specific workspaces.
-- These classes are defined when opening the terminal sessions using the kitty
-- command. You can find some of these on `hyprland-autostart.sh` file
hl.window_rule({
    name = "windowrule-9",
    match = {
        class = "nchat",
    },
    workspace = "9 silent",
})

hl.window_rule({
    name = "windowrule-10",
    match = {
        class = "obsidian_tui",
    },
    workspace = "10 silent",
})

-- Prevent Bisq tooltips from stealing focus, causing an loop of tooltips
-- spawning and vanishing.
hl.window_rule({
    name = "windowrule-11",
    match = {
        class = "^(bisq\\.desktop_app\\.JavaFXApplication)$",
        title = "^$",
    },
    no_initial_focus = true,
})
