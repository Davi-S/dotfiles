return {
    "nvim-mini/mini.pairs",
    version = false,
    -- Lazy-load when entering Insert mode 
    event = "InsertEnter",
    config = function()
        local pairs = require("mini.pairs")
        pairs.setup()
    end,
}
