return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        vim.opt.termguicolors = true
        local colorizer = require("colorizer")
        colorizer.setup({
            names = true,
        })
    end
}
