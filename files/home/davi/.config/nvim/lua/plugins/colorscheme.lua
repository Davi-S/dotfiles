return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            local colorscheme_helpers = require("plugins_helpers.colorscheme_helper")
            require("catppuccin").setup({
                flavour = "mocha",
                default_integrations = true,
                auto_integrations = true,
                custom_highlights = function(colors)
                    return vim.tbl_deep_extend("force", {
                        -- Set Line Numbers to a slighter lighter color
                        LineNr = { fg = colors.overlay1 },

                        -- Set some elements as the accent color (sapphire)
                        -- Floating window borders (Mason, Lazy, LSP Info)
                        FloatBorder = { fg = colors.sapphire },
                        -- Autocompletion Menu (blink.cmp)
                        BlinkCmpMenuBorder = { fg = colors.sapphire },
                    }, colorscheme_helpers.lazy_highlights(colors), colorscheme_helpers.markdown_highlights(
                        colors
                    ))
                end,
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
