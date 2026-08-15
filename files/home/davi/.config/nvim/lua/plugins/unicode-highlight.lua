return {
    "racakenon/vscode-unicode-highlight.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        highlight_ambiguous = true, -- Highlight ambiguous homoglyph characters
        highlight_invisible = true, -- Highlight non-printable / zero-width characters
        ambiguous_hl = "DiagnosticWarn", -- Highlight group for ambiguous characters
        invisible_hl = "DiagnosticError", -- Highlight group for invisible characters
        auto_enable = true, -- Automatically enable on buffer load
    },
    main = "init",
    config = function(_, opts)
        require("init").setup(opts)

        -- Jump to next confusing character using plugin's diagnostic namespace
        vim.keymap.set("n", "<leader>nc", function()
            local ns_diag = vim.api.nvim_create_namespace("unicode_highlight_diag")
            local diagnostics = vim.diagnostic.get(0, { namespace = ns_diag })

            if #diagnostics == 0 then
                vim.notify("No confusing characters found.", vim.log.levels.INFO)
                return
            end

            -- Jump to next diagnostic in unicode-highlight namespace
            vim.diagnostic.jump({ count = 1, namespace = ns_diag, wrap = true })
        end, { desc = "Jump to [n]ext [c]onfusing char" })
    end,
}
