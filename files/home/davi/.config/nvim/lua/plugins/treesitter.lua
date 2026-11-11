-- Syntax highlighting and indentation with treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- The main branch does not support lazy-loading. If it loads on BufReadPost, the
    -- FileType autocmd below is created too late for the first file opened, and that
    -- file never gets treesitter highlighting.
    lazy = false,
    -- Runs only when the plugin is installed or updated, not on every launch:
    -- install any missing parsers, then update the installed ones
    build = function()
        local treesitter = require("nvim-treesitter")
        treesitter.install("all"):wait(300000) -- wait max. 5 minutes
        treesitter.update():wait(300000)
    end,
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
            desc = "Enable treesitter highlighting and indentation",
            callback = function(ev)
                -- Enable treesitter highlighting and disable regex syntax
                -- We use pcall here to avoid errors in buffers whose filetype
                -- has no parser (e.g. plugin buffers like the picker's prompt).
                -- These errors can be ignored silently
                local ok = pcall(vim.treesitter.start, ev.buf)
                if not ok then
                    return
                end

                -- Enable treesitter-based indentation
                vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
