-- Hyprland Input
-- ==============
-- Reference: https://wiki.hyprland.org/Configuring/Variables/#input


hl.device({
    name = "logitech-g502-hero-se",
    sensitivity = 0.2,
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
hl.config({
    input = {
        -- Using kanata with br-abnt2 as source
        -- (see ~/.config/kanata/kanata.kbd).
        -- Other layouts ar here as falback if kanata fails
        kb_layout = "br,us",
        sensitivity = 0.60,
        force_no_accel = 0,
        accel_profile = "flat",
        touchpad = {
            scroll_factor = 0.5,
        },
    },
    gestures = {
        workspace_swipe_invert = false,
        workspace_swipe_create_new = false,
    },
})
