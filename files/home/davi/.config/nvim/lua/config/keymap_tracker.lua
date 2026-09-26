-- =============================================================================
-- Keymap Usage Tracker & Profiler
-- =============================================================================
-- Tracks every `vim.keymap.set` invocation, counts hits in real-time,
-- persists stats across Neovim sessions, and identifies dead keymaps.
-- =============================================================================

local M = {}

local stats_file = vim.fn.stdpath("state") .. "/keymap_stats.json"
local keymaps = {}
local hits = {}

-- Load existing statistics from disk
local function load_stats()
    local f = io.open(stats_file, "r")
    if f then
        local content = f:read("*a")
        f:close()
        local ok, data = pcall(vim.json.decode, content)
        if ok and type(data) == "table" then
            hits = data
        end
    end
end

-- Save statistics to disk
local function save_stats()
    local dir = vim.fn.fnamemodify(stats_file, ":h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
    local f = io.open(stats_file, "w")
    if f then
        f:write(vim.json.encode(hits))
        f:close()
    end
end

local function record_hit(key)
    hits[key] = (hits[key] or 0) + 1
end

function M.setup()
    load_stats()

    local orig_keymap_set = vim.keymap.set

    -- Intercept vim.keymap.set calls
    vim.keymap.set = function(mode, lhs, rhs, opts)
        opts = opts or {}
        local modes = type(mode) == "table" and mode or { mode }
        local desc = opts.desc or ""
        local info = debug.getinfo(2, "Sl")
        local source = "unknown"
        if info and info.short_src then
            local file = vim.fn.fnamemodify(info.short_src, ":t")
            source = file .. ":" .. (info.currentline or 0)
        end

        -- Skip internal typing pair hooks (e.g. mini.pairs / autopairs typing keys in insert mode)
        if source:find("mini.pairs") or source:find("pairs") then
            return orig_keymap_set(mode, lhs, rhs, opts)
        end

        for _, m in ipairs(modes) do
            local key = string.format("[%s] %s", m, lhs)
            if not keymaps[key] then
                keymaps[key] = {
                    mode = m,
                    lhs = lhs,
                    desc = desc,
                    source = source,
                }
            end
        end

        local wrapped_rhs = rhs
        if type(rhs) == "function" then
            wrapped_rhs = function(...)
                local cur_mode = vim.api.nvim_get_mode().mode:sub(1, 1)
                record_hit(string.format("[%s] %s", cur_mode, lhs))
                return rhs(...)
            end
        elseif type(rhs) == "string" then
            if rhs:lower() == "<nop>" then
                wrapped_rhs = function()
                    local cur_mode = vim.api.nvim_get_mode().mode:sub(1, 1)
                    record_hit(string.format("[%s] %s", cur_mode, lhs))
                end
            elseif opts.expr then
                wrapped_rhs = function(...)
                    local cur_mode = vim.api.nvim_get_mode().mode:sub(1, 1)
                    record_hit(string.format("[%s] %s", cur_mode, lhs))
                    return vim.api.nvim_eval(rhs)
                end
            else
                wrapped_rhs = function()
                    local cur_mode = vim.api.nvim_get_mode().mode:sub(1, 1)
                    record_hit(string.format("[%s] %s", cur_mode, lhs))
                    local keys = vim.api.nvim_replace_termcodes(rhs, true, true, true)
                    local feed_mode = opts.remap and "m" or "n"
                    vim.api.nvim_feedkeys(keys, feed_mode, false)
                end
            end
        end

        return orig_keymap_set(mode, lhs, wrapped_rhs, opts)
    end

    -- Automatically save stats on exit
    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("keymap_tracker_save", { clear = true }),
        callback = save_stats,
    })

    -- User commands
    vim.api.nvim_create_user_command("KeymapStats", M.show_stats, { desc = "Show keymap usage statistics" })
    vim.api.nvim_create_user_command("KeymapStatsReset", M.reset_stats, { desc = "Reset keymap usage statistics" })
end

function M.reset_stats()
    hits = {}
    save_stats()
    vim.notify("Keymap usage statistics have been reset.", vim.log.levels.INFO)
end

function M.show_stats()
    local items = {}
    for key, info in pairs(keymaps) do
        local count = hits[key] or 0
        table.insert(items, {
            key = key,
            count = count,
            mode = info.mode,
            lhs = info.lhs,
            desc = info.desc,
            source = info.source,
        })
    end

    -- Sort by hit count descending, then key name
    table.sort(items, function(a, b)
        if a.count ~= b.count then
            return a.count > b.count
        end
        return a.key < b.key
    end)

    local lines = {}
    table.insert(lines, string.format("%-6s | %-6s | %-16s | %-32s | %s", "HITS", "MODE", "KEYMAP", "DESCRIPTION", "DEFINED IN"))
    table.insert(lines, string.rep("-", 90))

    local zero_count = 0
    for _, item in ipairs(items) do
        if item.count == 0 then
            zero_count = zero_count + 1
        end
        local desc = item.desc ~= "" and item.desc or "(no description)"
        table.insert(lines, string.format("%-6d | [%-4s] | %-16s | %-32s | %s", item.count, item.mode, item.lhs, desc:sub(1, 32), item.source))
    end

    table.insert(lines, string.rep("=", 90))
    table.insert(lines, string.format("Total Tracked: %d | Used: %d | Never Used (Dead Keymaps): %d", #items, #items - zero_count, zero_count))

    -- Create floating window
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].filetype = "keymapstats"

    local width = math.min(100, vim.o.columns - 4)
    local height = math.min(#lines + 2, vim.o.lines - 4)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = " Keymap Usage Statistics ",
        title_pos = "center",
    })

    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
    vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
end

return M
