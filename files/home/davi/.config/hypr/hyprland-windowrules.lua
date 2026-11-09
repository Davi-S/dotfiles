-- Hyprland Windowrules
-- ====================
-- Reference: https://wiki.hyprland.org/Configuring/Window-Rules/
-- Reference: https://wiki.hyprland.org/Configuring/Workspace-Rules/
-- Use `hyprctl clients` to see the windows
--
-- Rule names describe what the rule does, so they are readable in hyprctl
-- output and can be referenced later.


-- Ignore maximize requests from apps
hl.window_rule({
    name = "ignore-maximize-requests",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "xwayland-drag-fix",
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

-- Prevent Bisq tooltips from stealing focus, which causes a loop of tooltips
-- spawning and vanishing
hl.window_rule({
    name = "bisq-tooltips-no-focus",
    match = {
        class = "^(bisq\\.desktop_app\\.JavaFXApplication)$",
        title = "^$",
    },
    no_initial_focus = true,
})

-- Apps that always open on the same workspace. The terminal classes are set
-- when the terminals are launched (see hyprland-autostart.lua).
hl.window_rule({
    name = "browser-on-workspace-1",
    match = {
        class = "zen",
    },
    workspace = "1 silent",
})

hl.window_rule({
    name = "whatsapp-on-workspace-9",
    match = {
        class = "nvim_whatsapp",
    },
    workspace = "9 silent",
})

hl.window_rule({
    name = "obsidian-on-workspace-10",
    match = {
        class = "obsidian_tui",
    },
    workspace = "10 silent",
})

-- Floating windows. The floating TUIs have their own rules in
-- hyprland-float-tuis.lua.

-- Picture-in-Picture (usually YouTube videos): floating, pinned, in the
-- bottom-right corner
hl.window_rule({
    name = "picture-in-picture",
    match = {
        title = "Picture-in-Picture",
    },
    float = true,
    pin = true,
    size = "(monitor_w*0.35) (monitor_h*0.35)",
    move = "((monitor_w*1)-window_w-(monitor_w*0.1)) ((monitor_h*1)-window_h-(monitor_h*0.1))",
    keep_aspect_ratio = true,
})

-- File dialogs (open, save) shown through the GTK portal, e.g. by Zen:
-- floating and centered, so they don't fill the screen and their borders stay
-- visible
hl.window_rule({
    name = "file-dialog-float",
    match = {
        class = "^xdg-desktop-portal-gtk$",
    },
    float = true,
    size = "(monitor_w*0.5) (monitor_h*0.9)",
    center = true,
})

-- App launcher and clipboard history (fzf in kitty, see hyprland-keybindings.lua):
-- floating and centered
hl.window_rule({
    name = "menu-float",
    match = {
        class = "^(launcher|clipboard)_float$",
    },
    float = true,
    size = "800 500",
    center = true,
})

-- Satty (screenshot editor): floating and centered over the current work
hl.window_rule({
    name = "satty-float",
    match = {
        class = "^(com\\.gabm\\.satty|org\\.satty\\.satty)$",
    },
    float = true,
    center = true,
})

-- mvi (mpv with scripts to act as an image viewer)
hl.window_rule({
    name = "mvi-float",
    match = {
        class = "mvi",
    },
    float = true,
})

-- Qalculate: floating, pinned and half transparent when not focused, centered
-- on the right half of the screen. For a size of w% x h%, the position is
-- (75 - w/2)% (50 - h/2)%.
hl.window_rule({
    name = "qalculate-float",
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
