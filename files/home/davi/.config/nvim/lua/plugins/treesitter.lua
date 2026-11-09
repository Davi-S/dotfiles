-- Syntax highlighting and indentation with treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    -- Lazy-load when opening an existing file or creating a new buffer, or on TS commands
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall", "TSLog" },
    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.install("all")

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
