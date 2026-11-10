-- Hyprland Keybindings
-- ====================
-- Reference: https://wiki.hyprland.org/Configuring/Keywords
-- Reference: https://wiki.hyprland.org/Configuring/Binds/


--#################################
--## Define apps and constants ####
--#################################

-- Remember to always use uwsm to start apps
local uwsm = "uwsm-app -t service --"

-- Not using uwsm to launch calculator because it will run just for a
-- short period of time; making it open quickly is more important
local calculator = "qalculate-gtk"

-- Using "--single-instance" to speedup startup time of new windows. See at:
-- https://man.archlinux.org/man/kitty.1#single.
-- The terminals opened at startup (see hyprland-autostart.lua) join this same
-- instance. "--class kitty" is needed because new windows otherwise take the
-- class of the window that started the instance (e.g. obsidian_tui), and window
-- rules would move them to that window's workspace.
local terminal = uwsm .. " kitty --single-instance --class kitty"

-- App launcher and clipboard history: terminal menus in a small floating kitty
-- (window rule "menu-float"), in the same kitty instance and config as the
-- floating TUIs.
-- Not using uwsm to launch these, because they run just for a short period of
-- time and opening quickly is more important.
local function float_menu(class, command)
    return "kitty --single-instance --instance-group float-tui"
        .. " --config ~/.config/kitty/float-tui.conf --class " .. class
        .. " -e env FZF_DEFAULT_OPTS_FILE=$HOME/.config/fzf/launcher " .. command
end

-- Lists the apps in fzf (searching names and keywords) and starts the chosen
-- one through uwsm
local menu = float_menu("launcher_float", "~/bin/app-launcher")

-- --no-sort keeps the newest entries first. Nothing is copied if the picker is
-- closed without a choice. setsid keeps wl-copy (which serves the clipboard)
-- alive after the kitty window closes, and its output goes to /dev/null, since
-- kitty keeps the window open while anything still writes to it.
local cliphist = float_menu("clipboard_float", "sh -c 'sel=$(cliphist list | fzf --no-sort)"
    .. " && printf \"%s\" \"$sel\" | cliphist decode | setsid -f wl-copy >/dev/null 2>&1'")

-- Opens a menu, or closes it if it is already open (so there is never a second
-- one)
local function toggle_menu(class, command)
    return function()
        for _, window in ipairs(hl.get_windows()) do
            if window.class == class then
                hl.dispatch(hl.dsp.window.close({ window = window }))
                return
            end
        end
        hl.exec_cmd(command)
    end
end

-- Folder where the user custom commands and scripts are
local ubin = "~/bin"

local screenshots_folder = "~/Pictures/screenshots"


--############
--## Binds ###
--############

hl.bind("SUPER + Escape", hl.dsp.exec_cmd("uwsm stop"))
-- Next = PageDown
-- For me, using a custom keyboard layout, "PageDown" is basically "M" in terms
-- of qwerty layout
hl.bind("SUPER + Next", hl.dsp.window.close())
-- For me, using a custom keyboard layout, "Return" is basically "Space" in terms
-- of qwerty layout
hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
-- For me, using a custom keyboard layout, "HOME" is basically "I" in terms of
-- qwerty layout
hl.bind("SUPER + Home", toggle_menu("launcher_float", menu))
-- Prior = PageUp
-- For me, using a custom keyboard layout, "PageUp" is basically "U" in terms of
-- qwerty layout
hl.bind("SUPER + Prior", hl.dsp.exec_cmd(ubin .. "/datetime-notify 3"))
-- SUPER+Y is already being triggered by the F5 key.
-- I don't know why, but this is the default behaviour of F5 and I didn't manage
-- to change it, so I'll make use of it as it is
hl.bind("SUPER + Y", hl.dsp.exec_cmd(ubin .. "/battery-notify show"))
-- For me, using a custom keyboard layout, "Tab" is basically "J" in terms of
-- qwerty layout
hl.bind("SUPER + TAB", toggle_menu("clipboard_float", cliphist))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
-- hl.bind("SUPER + C", hl.dsp.exec_cmd(calculator))
-- Floating TUIs, each in its own special workspace (see hyprland-float-tuis.lua)
hl.bind("SUPER + B", hl.dsp.workspace.toggle_special("bluetooth"))
hl.bind("SUPER + W", hl.dsp.workspace.toggle_special("wifi"))
hl.bind("SUPER + A", hl.dsp.workspace.toggle_special("audio"))
hl.bind("SUPER + C", hl.dsp.workspace.toggle_special("calendar"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind("SUPER + insert", hl.dsp.exec_cmd("if systemctl is-active --quiet kanata; then systemctl stop kanata && notify-send 'Kanata' 'Stopped'; else systemctl start kanata && notify-send 'Kanata' 'Started'; fi"))

-- Screenshots
-- Only one selection at a time: extra presses while selecting do nothing
hl.bind("PRINT", hl.dsp.exec_cmd("pgrep -x slurp >/dev/null || hyprshot -m region -o " .. screenshots_folder))
-- Edit a screenshot of the focused monitor in Satty
-- grim directly with an uncompressed image (ppm) instead of hyprshot.
-- GTK's OpenGL renderer gets Satty ready sooner than the default.
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd(
    "grim -o \"$(hyprctl -j activeworkspace | jq -r .monitor)\" -t ppm - | GSK_RENDERER=gl satty --filename -"
))
-- Screenshot the focused monitor
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("hyprshot -m output -m active -o " .. screenshots_folder))
-- OCR: select an area and copy its text to the clipboard
hl.bind("SUPER + Pause", hl.dsp.exec_cmd(ubin .. "/ocr-region"))

-- Move focus with SUPER + arrow keys
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with SUPER + [0-9]
-- This apostrophe is on the right side of number 1. This facilidates switching to the last workspace
hl.bind("SUPER + apostrophe", hl.dsp.focus({ workspace = 10 }))
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with SUPER + SHIFT + [0-9]
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Silently move active window to a workspace with SUPER + ALT + SHIFT + [0-9]
hl.bind("SUPER + SHIFT + ALT + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind("SUPER + SHIFT + ALT + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind("SUPER + SHIFT + ALT + 3", hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind("SUPER + SHIFT + ALT + 4", hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind("SUPER + SHIFT + ALT + 5", hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind("SUPER + SHIFT + ALT + 6", hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind("SUPER + SHIFT + ALT + 7", hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind("SUPER + SHIFT + ALT + 8", hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind("SUPER + SHIFT + ALT + 9", hl.dsp.window.move({ workspace = 9, follow = false }))
hl.bind("SUPER + SHIFT + ALT + 0", hl.dsp.window.move({ workspace = 10, follow = false }))

-- Rearrange window using SUPER + SHIFT + CTRL + arrow keys
hl.bind("SUPER + SHIFT + CTRL + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + CTRL + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + CTRL + down", hl.dsp.window.move({ direction = "d" }))

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())


--###################################
--## Laptop multimedia ("F") keys ###
--###################################

-- In order from left to right

-- F1 - XF86Sleep - Sleep the computer. logind ignores this key
-- (/etc/systemd/logind.conf.d/sleep-key.conf) so the lock screen can finish
-- fading in before the computer sleeps. If the screen is already locked, it
-- sleeps right away.
hl.bind("XF86Sleep", hl.dsp.exec_cmd(
    "pidof hyprlock || { loginctl lock-session; sleep 0.5; }; systemctl suspend"
), { locked = true })

-- F2 - XF86RFKill - Toggle airplane mode. The kernel handles this key by itself
-- (rfkill-input), so there is no bind for it. The notification is sent by
-- airplane-notify-daemon whenever the radios change.

-- F3 and F4 - Brightness control
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ubin .. "/brightness-control -10"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ubin .. "/brightness-control +10"), { locked = true, repeating = true })

-- F5 - Apparently, this is a key combo "SUPER+Y". I don't know why a media key does this, but it does.

-- F6 - Toggles the screen on and off. This key is handled by firmware, so there is no override for it
-- It does not turn the monitor completely off. It is still possible to see bright stuff on it.
-- However, I have no idea how to fix this or get the same behaviour (toggle + wake on input) using other
-- key/method, so I'll leave it as is

-- F7 - XF86TouchpadOn and XF86TouchpadOff - Toggle touchpad on and off

-- F8 - Nothing

-- F9 - Mute volume
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ubin .. "/volume-control toggle"), { locked = true })

-- F10 and F11 - Volume control
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ubin .. "/volume-control -5"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ubin .. "/volume-control +5"), { locked = true, repeating = true })
-- Fine tune volume
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd(ubin .. "/volume-control -1"), { locked = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd(ubin .. "/volume-control +1"), { locked = true })

-- Media keys (bluetooth headphones buttons come through here via AVRCP)
-- Some headphones send separate Play and Pause keys instead of
-- PlayPause, and guess which one to send, so all of them toggle
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- F12 - Scroll_Lock
-- bindl = , Scroll_Lock, ...
