return {
    "nvim-mini/mini.files",
    version = false,
    lazy = false, 
    dependencies = {
        "nvim-mini/mini.icons",
    },
    init = function()
        -- Disable netrw completely
        vim.g.loaded_netrwPlugin = 1
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwSettings = 1
        vim.g.loaded_netrwFileHandlers = 1
        vim.g.loaded_netrw_gitignore = 1
    end,
    config = function()
        local files = require("mini.files")
        files.setup({
            options = {
                use_as_default_explorer = true,
            },
        })

        -- Auto-open mini.files when starting Neovim on a directory (e.g. `nvim .`)
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function(data)
                if vim.fn.isdirectory(data.file) == 1 then
                    files.open(data.file, false)
                end
            end,
        })

        -- Custom split mappings inside explorer
        local map_split = function(buf_id, lhs, direction)
            local rhs = function()
                local cur_target = MiniFiles.get_explorer_state().target_window
                local new_target = vim.api.nvim_win_call(cur_target, function()
                    vim.cmd(direction .. " split")
                    return vim.api.nvim_get_current_win()
                end)
                MiniFiles.set_target_window(new_target)
                MiniFiles.go_in()
            end
            vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id
                map_split(buf_id, "<C-j>", "belowright horizontal")
                map_split(buf_id, "<C-l>", "belowright vertical")
            end,
        })

        vim.keymap.set({ "n", "v" }, "<leader>y", files.open, { desc = "Open file explorer" })
        vim.keymap.set({ "n", "v" }, "<leader>cy", function()
            files.open(vim.api.nvim_buf_get_name(0))
        end, { desc = "Open file explorer in current file's directory" })
    end,
}
