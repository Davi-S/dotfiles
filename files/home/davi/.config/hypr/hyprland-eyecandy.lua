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

-- One motion for everything: every animation inherits it from "global". The
-- other leaves only add a style, but hl.animation needs the speed and curve on
-- every call, so they all reuse this table.
local motion = { speed = 3, bezier = "easeOutExpo" }

local function animation(leaf, style)
    hl.animation({
        leaf = leaf,
        enabled = true,
        speed = motion.speed,
        bezier = motion.bezier,
        style = style,
    })
end

animation("global")
animation("windows", "slide")
animation("workspaces", "slide")
animation("specialWorkspace", "slidevert")
animation("layers", "fade")

-- Floating windows come from below, like the floating apps in their special
-- workspaces
hl.window_rule({
    name = "float-from-below",
    match = {
        float = true,
    },
    animation = "slide bottom",
})

-- The notification panel is on the right edge, so it comes from the right
hl.layer_rule({
    name = "notification-panel-from-right",
    match = {
        namespace = "^swaync-control-center$",
    },
    animation = "slide right",
})

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        col = {
            inactive_border = colors.surface1,
            active_border = colors.sapphire
        },
    },
    decoration = {
        -- No darkening behind special workspaces (the floating apps), like any
        -- other floating window
        dim_special = 0,
        shadow = {
            enabled = false,
        },
    },
    dwindle = {
        force_split = 2,
        preserve_split = true,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
        background_color = colors.mantle,
    },
})
