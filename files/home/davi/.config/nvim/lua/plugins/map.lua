return {
    'nvim-mini/mini.map',
    version = false,
    config = function()
        local map = require('mini.map')
        map.setup({
            symbols = {
                -- Encode symbols. See `:h MiniMap.config` for specification and
                -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
                -- Default: solid blocks with 3x2 resolution.
                encode = map.gen_encode_symbols.dot("4x2"),
            }
        })

        -- Start with map open
        map.open()

        vim.keymap.set('n', '<leader>mc', map.close, { desc = "Mini[m]ap [close]" })
        vim.keymap.set('n', '<leader>mf', map.toggle_focus, { desc = "Mini[m]ap toggle [f]ocus" })
        vim.keymap.set('n', '<leader>mo', map.open, { desc = "Mini[m]ap [o]open" })
        vim.keymap.set('n', '<leader>mr', map.refresh, { desc = "Mini[m]ap [r]efresh" })
        vim.keymap.set('n', '<leader>ms', map.toggle_side, { desc = "Mini[m]ap toggle [s]ide" })
        vim.keymap.set('n', '<leader>mt', map.toggle, { desc = "Mini[m]ap [t]oggle" })
    end

}
