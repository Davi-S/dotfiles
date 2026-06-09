return {
    'nvim-mini/mini.trailspace',
    version = false,
    config = function()
        local trailspace = require('mini.trailspace')
        trailspace.setup()

        vim.keymap.set(
            "n",
            "<leader>ts",
            trailspace.trim,
            { desc = "[t]rim [t]ail [s]paces" }
        )
    end
}
