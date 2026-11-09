-- Hyprland Floating TUIs
-- ======================
-- Reference: https://wiki.hyprland.org/Configuring/Window-Rules/
--
-- Small TUIs that float over the current workspace,
-- toggled with keybinds (see hyprland-keybindings.lua). Each one lives in its
-- own special workspace:
--     - Toggling hides the app instead of closing it, so it keeps its state and
--       shows up instantly the next time.
--     - If the app was closed (e.g. with "q"), its special workspace is created
--       empty on the next toggle, and the "workspace.created" handler below
--       launches the app again.
--     - Apps with "autostart" are launched hidden when Hyprland starts (through
--       autostart() below, called from hyprland-autostart.lua), so even the
--       first toggle is instant.
--
-- They share a kitty config that makes them look consistent with each other
-- (see ~/.config/kitty/float-tui.conf), and one kitty process (instance group
-- "float-tui"), which saves memory and makes new windows open faster.
--
-- The window rule (matched by class) is what sends each app to its special
-- workspace. Exec rules would not work: with --single-instance the window
-- belongs to the kitty process that is already running, not to the one that
-- was launched, so Hyprland would not recognize it.


local M = {}

local float_tui = "uwsm-app -t service -- kitty --single-instance --instance-group float-tui"
    .. " --config ~/.config/kitty/float-tui.conf"

local tuis = {
    { workspace = "bluetooth", class = "bluetui_float", command = "bluetui", autostart = true },
    { workspace = "wifi",      class = "impala_float",  command = "impala",  autostart = true },
    { workspace = "audio",     class = "wiremix_float", command = "wiremix", autostart = true },
    { workspace = "calendar",  class = "calcurse_float", command = "calcurse", autostart = true },
}

-- Launch commands of the apps with "autostart"
local autostart_commands = {}

-- Special workspace name -> { class, launch command }
local by_workspace = {}

for _, tui in ipairs(tuis) do
    local special = "special:" .. tui.workspace
    local launch = float_tui .. " --class " .. tui.class .. " -e " .. tui.command

    by_workspace[special] = { class = tui.class, launch = launch }

    hl.window_rule({
        name = "float-tui-" .. tui.workspace,
        match = {
            class = "^" .. tui.class .. "$",
        },
        workspace = special .. " silent",
        float = true,
        size = "800 500",
        center = true,
    })

    if tui.autostart then
        table.insert(autostart_commands, launch)
    end
end

-- Returns true if a window of the given class exists
local function has_window(class)
    for _, window in ipairs(hl.get_windows()) do
        if window.class == class then
            return true
        end
    end
    return false
end

-- When a special workspace of a TUI is created empty (toggled after the app was
-- closed), launch the app in it. The window check avoids a second copy when the
-- workspace is created by the window rule moving the app there (at startup).
hl.on("workspace.created", function(workspace)
    local tui = workspace and by_workspace[workspace.name]
    if tui and workspace.is_empty and not has_window(tui.class) then
        hl.exec_cmd(tui.launch)
    end
end)

-- Launches the apps with "autostart". The window rules above send them, hidden,
-- to their special workspaces.
function M.autostart()
    for _, launch in ipairs(autostart_commands) do
        hl.exec_cmd(launch)
    end
end

return M
