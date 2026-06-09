-- This mini.input plugin here updates Neovim's built-in vim.ui.input.
--
-- No configuration is needed, and one usually does not use this directly. It
-- will just provide a better vim.ui.input.
return {
    'nvim-mini/mini.input',
    version = false,
    config = function()
        require('mini.input').setup()
        -- The setup() function automatically routes vim.ui.input() to mini.input.
    end
}
