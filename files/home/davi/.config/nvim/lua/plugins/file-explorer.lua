return {
    "nvim-mini/mini.files",
    version = false,
    dependencies = {
        "nvim-mini/mini.icons",
        "nvim-tree/nvim-web-devicons"
    },
    init = function()
        -- Fake netrw being loaded already so it wont load.
        vim.g.loaded_netrwPlugin = 1
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwSettings = 1
        vim.g.loaded_netrwFileHandlers = 1
        vim.g.loaded_netrw_gitignore = 1
    end,
    config = function()
        local files = require("mini.files")
        files.setup()

        -- https://nvim-mini.org/mini.nvim/doc/mini-files.html#minifiles-examples-createmappingstomodifytargetwindowviasplit
        -- Open the file in a split
        local map_split = function(buf_id, lhs, direction)
            local rhs = function()
                -- Make new window and set it as target
                local cur_target = MiniFiles.get_explorer_state().target_window
                local new_target = vim.api.nvim_win_call(cur_target, function()
                    vim.cmd(direction .. ' split')
                    return vim.api.nvim_get_current_win()
                end)

                MiniFiles.set_target_window(new_target)

                -- This intentionally doesn't act on file under cursor in favor of
                -- explicit "go in" action (`l` / `L`). To immediately open file,
                -- add appropriate `MiniFiles.go_in()` call instead of this comment.
                MiniFiles.go_in()
            end

            -- Adding `desc` will result into `show_help` entries
            local desc = 'Split ' .. direction
            vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
        end

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesBufferCreate',
            callback = function(args)
                local buf_id = args.data.buf_id
                -- Tweak keys to your liking
                map_split(buf_id, '<C-j>', 'belowright horizontal')
                map_split(buf_id, '<C-l>', 'belowright vertical')
            end,
        })

        vim.keymap.set(
            { "n", "v" },
            "<leader>y",
            files.open,
            { desc = "Open file explorer (legacy used [y]azi)" }
        )
        vim.keymap.set(
            { "n", "v" },
            "<leader>cy",
            function()
                files.open(vim.api.nvim_buf_get_name(0))
            end,
            { desc = "Open file explorer in [c]urrent file's directory (legacy used [y]azi" }
        )
    end,
}
