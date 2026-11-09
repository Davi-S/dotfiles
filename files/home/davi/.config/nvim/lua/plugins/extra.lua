-- Extra pickers (mini.extra): spelling suggestions, and the LSP pickers used by
-- "find usages" (lua/plugins_helpers/lsp_helper.lua)

return {
    "nvim-mini/mini.extra",
    version = false,
    -- Lazy-load when invoking spelling suggestions or toggle keymaps
    keys = {
        { "<leader>st", desc = "[s]pell check [t]oggle" },
        { "<leader>ss", desc = "[s]pelling [s]uggestions" },
        { "<leader>sg", desc = "[s]pelling: mark as [g]ood word" },
    },
    config = function()
        local extra = require("mini.extra")
        extra.setup()

        vim.keymap.set("n", "<leader>st", "<cmd>set spell!<CR>", { desc = "[s]pell check [t]oggle" })
        vim.keymap.set("n", "<leader>ss", extra.pickers.spellsuggest, { desc = "[s]pelling [s]uggestions" })
        vim.keymap.set("n", "<leader>sg", "zg", { desc = "[s]pelling: mark as [g]ood word" })
    end,
}
