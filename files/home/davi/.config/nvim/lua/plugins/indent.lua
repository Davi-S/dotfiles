-- Highlights the indentation scope around the cursor

return {
    "nvim-mini/mini.indentscope",
    version = false,
    -- Lazy-load when opening an existing file or creating a new buffer
    event = { "BufReadPre", "BufNewFile" },
    -- A function, because the animation generator comes from the module itself
    opts = function()
        return {
            draw = {
                -- No animation when the scope line appears
                animation = require("mini.indentscope").gen_animation.none(),
            },
        }
    end,
}
