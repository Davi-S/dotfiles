-- Highlight overrides for tokyonight.
-- Export a function that builds a table of groups using the provided `colors`.
-- Keeping overrides in a separate module keeps the plugin spec tidy.

return function(colors)
    local fg = colors.fg
    return {
        Normal = { bg = colors.bg, fg = fg },
        NormalFloat = { bg = colors.bg_dark1, fg = fg },
        Pmenu = { bg = colors.bg_dark1, fg = fg },

        Bold = { bold = true, fg = fg },
        BlinkCmpDoc = { bg = "#16161e", fg = fg },
        BlinkCmpLabel = { bg = "NONE", fg = fg },
        BlinkCmpMenu = { bg = "#16161e", fg = fg },
        BlinkCmpSignatureHelp = { bg = "#16161e", fg = fg },

        BufferAlternate = { bg = "#3b4261", fg = fg },
        BufferCurrent = { bg = "#1a1b26", fg = fg },
        BufferVisible = { bg = "#16161e", fg = fg },

        CmpDocumentation = { bg = "#16161e", fg = fg },
        CmpItemAbbr = { bg = "NONE", fg = fg },

        Italic = { fg = fg, italic = true },

        MiniStarterItem = { bg = "#1a1b26", fg = fg },
        MiniStatuslineFilename = { bg = "#292e42", fg = fg },
        MiniTablineCurrent = { bg = "#3b4261", fg = fg },
        MiniTablineVisible = { bg = "#16161e", fg = fg },

        MsgArea = { fg = fg },

        NotifyBackground = { bg = "#1a1b26", fg = fg },
        NotifyDEBUGBody = { bg = "#1a1b26", fg = fg },
        NotifyERRORBody = { bg = "#1a1b26", fg = fg },
        NotifyINFOBody = { bg = "#1a1b26", fg = fg },
        NotifyTRACEBody = { bg = "#1a1b26", fg = fg },
        NotifyWARNBody = { bg = "#1a1b26", fg = fg },

        SnacksNotifierDebug = { bg = "#1a1b26", fg = fg },
        SnacksNotifierError = { bg = "#1a1b26", fg = fg },
        SnacksNotifierInfo = { bg = "#1a1b26", fg = fg },
        SnacksNotifierTrace = { bg = "#1a1b26", fg = fg },
        SnacksNotifierWarn = { bg = "#1a1b26", fg = fg },

        SnacksPickerPickWin = { bg = "#3d59a1", bold = true, fg = fg },
        SnacksPickerPickWinCurrent = { bg = "#ff007c", bold = true, fg = fg },

        TelescopeNormal = { bg = colors.bg_dark, fg = fg },
        StatusLine = { bg = colors.bg_dark, fg = fg },
        StatusLineNC = { bg = colors.bg_dark1, fg = fg },

        NavicSeparator = { bg = "NONE", fg = fg },
        NavicText = { bg = "NONE", fg = fg },
    }
end
