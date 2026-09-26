return {
    "racakenon/vscode-unicode-highlight.nvim",
    -- Load right after the first screen is drawn (loading its data costs ~13 ms).
    -- On setup it scans the current buffer; other buffers are scanned on BufEnter.
    event = "VeryLazy",
    opts = {
        debounce_ms = 100, -- Rescan at most every 100 ms while typing (default 35; each scan covers the whole buffer)
        highlight_ambiguous = true, -- Highlight ambiguous homoglyph characters
        highlight_invisible = true, -- Highlight non-printable / zero-width characters
        ambiguous_hl = "DiagnosticWarn", -- Highlight group for ambiguous characters
        invisible_hl = "DiagnosticError", -- Highlight group for invisible characters
        auto_enable = true, -- Automatically enable on buffer load
        custom_ambiguous = {
            { { 226, 128, 148 }, { 45 }, 8212 }, -- '—' (Em dash U+2014) looks like '-' (hyphen)
            { { 226, 128, 156 }, { 34 }, 8220 }, -- '"' (Left double quote U+201C) looks like '"'
            { { 226, 128, 157 }, { 34 }, 8221 }, -- '"' (Right double quote U+201D) looks like '"'
            { { 226, 128, 166 }, { 46 }, 8230 }, -- '…' (Ellipsis U+2026) looks like '.'
        },
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
