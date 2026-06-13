local function lazy_highlights(colors)
    return {
        -- Keyboard shortcuts in buttons (i.e. the I in install)
        LazySpecial = { fg = colors.sapphire },
        -- The reason indicator
        LazyReasonPlugin = { fg = colors.sapphire }
    }
end

local M = {}

M.lazy_highlights = lazy_highlights

return M
