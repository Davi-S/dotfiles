return {
    'nvim-mini/mini.extra',
    version = false,
    config = function()
        local extra = require('mini.extra')
        extra.setup()

        vim.keymap.set(
            "n",
            "<Leader>st",
            "<cmd>set spell!<CR>",
            { desc = "[s]pell check [t]oggle" }
        )
        vim.keymap.set(
            "n",
            "<leader>ss",
            extra.pickers.spellsuggest,
            { desc = "[s]pelling [s]uggestions" }
        )
        vim.keymap.set(
            "n",
            "<Leader>sg",
            "zg",
            { desc = "Add this word to the [s]pelfile as a [g]ood word" }
        )
    end
}
