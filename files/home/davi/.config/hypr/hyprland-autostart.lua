-- Hyprland Autostart
-- ==================
-- Reference: https://wiki.hyprland.org/Configuring/Keywords/#executing
-- Autostart necessary processes (like notifications daemons, status bars, etc.)


-- When using other window managers alongside with hyprland they can overide
-- this environment variable. It is good to set this everytime hyprland starts
-- to prevent any errors.
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

hl.on("hyprland.start", function()
    -- This will only call the autostart script. All configurations must be done in
    -- the bash script, as it is more customizable.
    hl.exec_cmd("bash ~/.config/hypr/hyprland-autostart.sh")

    -- -------------------------------------------------------------------------
    -- UWSM FINALIZATION AND SERVICE NOTIFICATION
    -- -------------------------------------------------------------------------
    -- My compositor puts WAYLAND_DISPLAY (and along with it DISPLAY, or other
    -- important or useful variables) into systemd activation environment, so
    -- uwsm will make everything work automagically. Even thought, I don't want
    -- to rely on it blindly, so I'll call the `uwsm finalize` manually anyways.
    --
    -- Per the "Service startup notification" section of the UWSM readme:
    -- 1. This command manually pushes the critical environment variables
    --    (WAYLAND_DISPLAY, DISPLAY, XDG_CURRENT_DESKTOP) to the systemd
    --    activation environment.
    -- 2. Crucially, it sends the "READY=1" signal to systemd. Without this,
    --    the session unit might hang in a "starting" state until it times out,
    --    delaying other startup scripts.
    --
    -- This explicitly forces "Scenario B" (Manual Path) from the docs, ensuring
    -- maximum stability.
    hl.exec_cmd("uwsm finalize")
end)
