-- =============================================================================
-- Global Autocommands
-- =============================================================================
-- This file contains editor-wide event handlers and automatic behaviors.
-- =============================================================================

-- Highlight text temporarily after yanking (copying)
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    desc = "Highlight selection post yank for visual feedback",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})

-- Display cursorline exclusively in the currently focused window/buffer
local active_cursorline_group = vim.api.nvim_create_augroup("active_cursorline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = active_cursorline_group,
    desc = "Enable cursorline on active window enter",
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = active_cursorline_group,
    desc = "Disable cursorline on inactive window leave",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- Automatically restore cursor position from last edit session when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("restore_cursor_position", { clear = true }),
    desc = "Restore cursor to file position in previous editing session",
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function()
                vim.cmd.normal({ args = { "zz" }, bang = true })
            end)
        end
    end,
})
