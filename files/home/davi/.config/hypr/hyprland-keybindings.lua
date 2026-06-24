-- Hyprland Keybindings
-- ====================
-- Reference: https://wiki.hyprland.org/Configuring/Keywords
-- Reference: https://wiki.hyprland.org/Configuring/Binds/


--#################################
--## Define apps and constants ####
--#################################

-- Remember to always use uwsm to start apps
local uwsm = "uwsm app -t service --"

-- Not using uwsm to launch calculator because it will run just for a
-- short period of time; making it open quickly is more important
local calculator = "qalculate-gtk"

local terminal = uwsm .. " kitty"

-- Set rofi to use uwsm to launch apps, but not using uwsm to launch rofi it self
-- because rofi will run just for a short period of time, and making it open
-- quickly is more important. The point is to make the app that rofi will open to
-- be managed by uwsm.
local menu = "rofi -show drun -run-command \"" .. uwsm .. " {cmd}\""

-- clipboard history
-- Not using uwsm to launch rofi or cliphist because it will run just for a
-- short period of time; making it open quickly is more important
--
-- Disable the icon configuration entirely for that single instance. Because
-- cliphist does not provide icons, rofi will just show an empty space if this
-- options is not set.
local cliphist =
"cliphist list | rofi -dmenu -theme-str 'configuration { show-icons: false; }' | cliphist decode | wl-copy"

-- Folder where the user custom commands and scripts are
local ubin = "~/bin"

local screenshots_folder = "~/Pictures/screenshots"

-- Not using uwsm here because these terminal/apps will run for a short period of
-- time. It is more important to make them open faster.
local bluetooth = ubin ..
    "/toggle-float-app bluetui_float \"kitty -o confirm_os_window_close=0 --class bluetui_float -e bluetui\""
local wifi = ubin ..
    "/toggle-float-app impala_float \"kitty -o confirm_os_window_close=0 --class impala_float -e impala\""
local audio = ubin ..
    "/toggle-float-app pulsemixer_float \"kitty -o confirm_os_window_close=0 --class pulsemixer_float -e pulsemixer\""


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
hl.bind("SUPER + Home", hl.dsp.exec_cmd(menu))
-- Prior = PageUp
-- For me, using a custom keyboard layout, "PageUp" is basically "U" in terms of
-- qwerty layout
hl.bind("SUPER + Prior", hl.dsp.exec_cmd(ubin .. "/datetime-notify 3"))
-- SUPER+Y is already being triggered by the F5 key.
-- I don't know why, but this is the default behaviour of F5 and I didn't manage
-- to change it, so I'll make use of it as it is
hl.bind("SUPER + Y", hl.dsp.exec_cmd("battery-notify"))
-- For me, using a custom keyboard layout, "Tab" is basically "J" in terms of
-- qwerty layout
hl.bind("SUPER + TAB", hl.dsp.exec_cmd(cliphist))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + C", hl.dsp.exec_cmd(calculator))
hl.bind("SUPER + B", hl.dsp.exec_cmd(bluetooth))
hl.bind("SUPER + W", hl.dsp.exec_cmd(wifi))
hl.bind("SUPER + A", hl.dsp.exec_cmd(audio))
hl.bind("SUPER + M", hl.dsp.exec_cmd(ubin .. "/toggle-bluetooth-mic"))
hl.bind("SUPER + I", hl.dsp.exec_cmd("expresso menu"))
hl.bind("SUPER + SHIFT + I", hl.dsp.exec_cmd("decaf menu"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t"))

-- Screenshots
-- bind = SUPER SHIFT, PRINT, exec, hyprshot -m window -o $screenshots_folder  # Screenshot a window
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o " .. screenshots_folder))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("hyprshot -m output -m eDP-1 -o " .. screenshots_folder))

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
-- Special workspace (scratchpad)
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("hub"))

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
-- Special workspace (scratchpad)
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:hub" }))

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

-- F1 - XF86Sleep - Sleep the computer

-- F2 - XF86RFKill - Toggle airplane mode
hl.bind("XF86RFKill", hl.dsp.exec_cmd(ubin .. "/airplane-mode-control status"), { locked = true, repeating = true })

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

-- F12 - Scroll_Lock
-- bindl = , Scroll_Lock, ...
