return {
    {
        "lewis6991/gitsigns.nvim",
        -- Load right after the first screen is drawn, so it never delays opening a file.
        -- On setup it attaches to buffers that are already open, then to new ones itself.
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                word_diff = true,
                on_attach = function(bufnr)
                    vim.keymap.set(
                        "n",
                        "<Leader>gv",
                        ":Gitsigns preview_hunk<CR>",
                        { buffer = bufnr, desc = "[g]itsigns [v]iew hunk in popup" }
                    )
                    vim.keymap.set(
                        "n",
                        "<Leader>gr",
                        ":Gitsigns reset_hunk<CR>",
                        { buffer = bufnr, desc = "[g]itsigns [r]eset hunk" }
                    )
                    vim.keymap.set(
                        "n",
                        "<Leader>gn",
                        ":Gitsigns nav_hunk next<CR>",
                        { buffer = bufnr, desc = "[g]itsigns [n]ext hunk" }
                    )
                    vim.keymap.set(
                        "n",
                        "<Leader>gp",
                        ":Gitsigns nav_hunk prev<CR>",
                        { buffer = bufnr, desc = "[g]itsigns [p]rev hunk" }
                    )
                end,
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
        config = function()
            -- lazygit.nvim positions its float with
            --     row = (vim.o.lines - height) / 2        (lua/lazygit/window.lua)
            -- which centers the *content* inside the *whole* screen. It ignores
            -- the border (2 extra rows) and the command line (rows a float can
            -- never use), so the box ends up half a row too low -- one row more
            -- space above than below, at every terminal size. The column math
            -- happens to come out symmetric, so only `row` is recomputed here.
            local function recenter(win)
                if not win or not vim.api.nvim_win_is_valid(win) then
                    return
                end
                local cfg = vim.api.nvim_win_get_config(win)
                if cfg.relative == "" then
                    return
                end
                local border = (cfg.border and cfg.border ~= "none") and 1 or 0
                -- A float may occupy rows 0 .. (lines - cmdheight - 1)
                local usable = vim.o.lines - vim.o.cmdheight
                local outer = cfg.height + 2 * border
                vim.api.nvim_win_set_config(win, {
                    relative = "editor",
                    row = math.floor((usable - outer) / 2) + border,
                    col = cfg.col,
                    width = cfg.width,
                    height = cfg.height,
                })
            end

            local group = vim.api.nvim_create_augroup("lazygit-center-float", { clear = true })

            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                pattern = "lazygit",
                callback = function()
                    recenter(vim.api.nvim_get_current_win())
                end,
            })

            -- The plugin re-applies its own geometry 20ms after a resize; undo it after that.
            vim.api.nvim_create_autocmd("VimResized", {
                group = group,
                callback = function()
                    vim.defer_fn(function()
                        for _, win in ipairs(vim.api.nvim_list_wins()) do
                            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "lazygit" then
                                recenter(win)
                            end
                        end
                    end, 60)
                end,
            })
        end,
    },
}
