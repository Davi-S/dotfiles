-- Hyprland Eyecandy
-- =================
-- Reference:
--    - https://wiki.hyprland.org/Configuring/Variables/
--    - https://wiki.hyprland.org/Configuring/Variables/#general
--    - https://wiki.hyprland.org/Configuring/Variables/#decoration
--    - https://wiki.hyprland.org/Configuring/Variables/#animations
--    - https://wiki.hyprland.org/Configuring/Variables/#blur
--    - https://wiki.hyprland.org/Configuring/Animations
--    - https://wiki.hyprland.org/Configuring/Master-Layout/
--    - https://wiki.hyprland.org/Configuring/Dwindle-Layout/

local colors = require("catppuccin-mocha")

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("crazyshot", { type = "bezier", points = { { 0.1, 1.5 }, { 0.76, 0.92 } } })
hl.curve("hyprnostretch", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("fluent_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 3,
    bezier = "easeOutExpo",
    style = "slide",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 3,
    bezier = "easeOutExpo",
    style = "slide",
})
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 3,
    bezier = "easeOutExpo",
    style = "slidevert",
})

hl.config({
    animations = {
        enabled = true,
    },
    general = {
        border_size = 1,
        gaps_in = 0,
        gaps_out = 0,
        col = {
            inactive_border = colors.surface1,
            active_border = colors.sapphire
        },
        layout = "dwindle",
    },
    dwindle = {
        force_split = 2,
        preserve_split = true,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
        enable_swallow = true,
        background_color = colors.mantle,
    },
})
