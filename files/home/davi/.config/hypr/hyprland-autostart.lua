-- Hyprland Autostart
-- ==================
-- Reference: https://wiki.hyprland.org/Configuring/Keywords/#executing
-- Everything that starts with Hyprland is listed here.
--
-- This file should contain only graphical applications. Hyprland is a window
-- manager, so if an application does not need a window, it does not need
-- hyprland. There is no need to bind a application/setting to hyprland when it
-- is not needed. If you need to autostart a service or application that does
-- not need a window, use systemd.
--
-- Remember to always start applications and processes using uwsm
-- Reference: https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#3-applications-and-slices

local float_tuis = require("hyprland-float-tuis")

local uwsm = "uwsm-app -t service --"

-- Cursor theme (AUR: catppuccin-cursors-mocha)
local cursor_theme = "catppuccin-mocha-sapphire-cursors"
local cursor_size = "24"


-- When using other window managers alongside with hyprland they can overide
-- this environment variable. It is good to set this everytime hyprland starts
-- to prevent any errors.
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

-- Cursor for Hyprland and for apps that read these variables. `uwsm finalize`
-- (below) exports them to the rest of the session.
hl.env("XCURSOR_THEME", cursor_theme)
hl.env("XCURSOR_SIZE", cursor_size)

-- Qt apps take their theme (Catppuccin palette) from qt6ct
-- (see ~/.config/qt6ct/qt6ct.conf)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.on("hyprland.start", function()
    -- Cursor for GTK apps (zen-browser, file dialogs), which read it from
    -- gsettings instead of the variables above
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme " .. cursor_theme)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. cursor_size)

    -- Web browser
    hl.exec_cmd(uwsm .. " zen-browser")

    -- Obsidian workflow using nvim, and WhatsApp on the terminal. They join the
    -- same kitty instance as the other terminals (--single-instance). Their
    -- custom classes are used by window rules to place them on their
    -- workspaces (see hyprland-windowrules.lua).
    hl.exec_cmd(uwsm .. " kitty --single-instance --class obsidian_tui"
        .. " --session /home/davi/.config/kitty/sessions/obsidian_tui.session")
    hl.exec_cmd(uwsm .. " kitty --single-instance --class nvim_whatsapp"
        .. " --session /home/davi/.config/kitty/sessions/nvim_whatsapp.session")

    -- Floating TUIs (bluetui, impala, wiremix), started hidden in their special
    -- workspaces (see hyprland-float-tuis.lua)
    float_tuis.autostart()

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
