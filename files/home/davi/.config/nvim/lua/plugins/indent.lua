return {
    'nvim-mini/mini.indentscope',
    version = false,
    config = function()
        local indentscope = require('mini.indentscope')
        indentscope.setup({
            draw = {
                -- Assign the 'none' animation generator directly to the config
                animation = indentscope.gen_animation.none()
            }
        })
    end

}
