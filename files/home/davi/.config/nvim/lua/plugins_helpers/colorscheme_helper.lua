local function lazy_highlights(colors)
    return {
        -- Keyboard shortcuts in buttons (i.e. the I in install)
        LazySpecial = { fg = colors.sapphire },
        -- The reason indicator
        LazyReasonPlugin = { fg = colors.sapphire }
    }
end

local function markdown_highlights(colors)
    return {
        ["@lsp.type.decorator.markdown"] = { fg = colors.sapphire },
    }
end

local M = {}

M.lazy_highlights = lazy_highlights
M.markdown_highlights = markdown_highlights

return M
