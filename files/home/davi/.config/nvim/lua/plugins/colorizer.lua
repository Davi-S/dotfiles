return {
    "norcalli/nvim-colorizer.lua",
    enabled = false,
    config = function()
        vim.opt.termguicolors = true
        local colorizer = require("colorizer")
        colorizer.setup({
            names = true,
        })
    end
}
