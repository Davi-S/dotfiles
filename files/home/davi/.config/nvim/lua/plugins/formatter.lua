return {
    "stevearc/conform.nvim",
    -- Lazy-load before writing a buffer, or when pressing format keymap
    event = { "BufWritePre" },
    keys = {
        { "<leader>cf", desc = "LSP [c]ode [f]ormat" },
    },
    config = function()
        local conform = require("conform")

        conform.setup({
            -- Only filetypes where LSP formatting is unavailable or undesirable
            -- need to be listed here. Everything else is covered by lsp_format.
            formatters_by_ft = {
                markdown = { "prettier" },
            },

            -- Applied to every conform.format() call unless overridden
            default_format_opts = {
                async = true,
                lsp_format = "fallback",
            },

            -- Formatter-specific overrides
            formatters = {
                prettier = {
                    -- prettier is only invoked for markdown (see formatters_by_ft),
                    -- so these args are always appropriate here.
                    append_args = { "--prose-wrap", "always" },
                },
            },
        })

        -- Single unified format keymap for all filetypes.
        vim.keymap.set("n", "<leader>cf", function()
            conform.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { desc = "LSP [c]ode [f]ormat" })
    end,
}
