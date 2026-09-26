return {
    "nvim-mini/mini.indentscope",
    version = false,
    -- Lazy-load when opening an existing file or creating a new buffer
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local indentscope = require("mini.indentscope")
        indentscope.setup({
            draw = {
                -- Assign the 'none' animation generator directly to the config
                animation = indentscope.gen_animation.none(),
            },
        })
    end,
}
