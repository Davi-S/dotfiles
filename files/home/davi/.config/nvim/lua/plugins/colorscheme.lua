return {
    {
        "catppuccin/nvim",
        name = "catppuccin.nvim",
        priority = 1000,
        config = function()
            local colorscheme_helpers = require("plugins_helpers.colorscheme")

            require("catppuccin").setup({
                auto_integrations = true,
                flavour = "mocha",
                color_overrides = {
                    -- -----------------------------------------------------------------------------
                    -- CUSTOM PALETTE: High Contrast Mocha
                    -- -----------------------------------------------------------------------------
                    -- Derived from Catppuccin Mocha with the following transformations:
                    -- 1. Black Point Re-anchoring: 'Crust' mapped to Pure Black (#0d0d15).
                    -- 2. White Point Re-anchoring: 'Text' mapped to Warm White (#deddda).
                    -- 3. Lightness Remapping: All intermediate colors linearly interpolated
                    --    (lerped) via HLS space to fit the expanded contrast range.
                    -- 4. Saturation Boost: +50% saturation applied to preserve color vibrance
                    --    against the darker background. Neutrals (Surface/Overlay) preserve
                    --    the original saturation to avoid blue tint
                    -- 5. Rotations: Swapp base with crust, make the new mantle the original crust
                    --    Make the new crust the original mantle
                    -- -----------------------------------------------------------------------------
                    mocha = {
                        rosewater = "#fad5ce",
                        flamingo = "#fabbbb",
                        pink = "#ffaee8",
                        mauve = "#c391ff",
                        red = "#ff7098",
                        maroon = "#fd7f93",
                        peach = "#ffa873",
                        yellow = "#fee09d",
                        green = "#8bf283",
                        teal = "#72f4de",
                        sky = "#65e7ff",
                        sapphire = "#4fc8ff",
                        blue = "#75a9fe",
                        lavender = "#a8b4fe",
                        text = "#deddda",
                        subtext1 = "#b1bad9",
                        subtext0 = "#9ca3c1",
                        overlay2 = "#878ea9",
                        overlay1 = "#717791",
                        overlay0 = "#606377",
                        surface2 = "#4a4d5e",
                        surface1 = "#363746",
                        surface0 = "#21212e",
                        base = "#000000",
                        mantle = "#11111b",
                        crust = "#181825",
                    },
                },
                custom_highlights = function(colors)
                    return vim.tbl_deep_extend("force", {
                            -- Cursor marks
                            CursorColumn = { bg = colors.crust },
                            ColorColumn = { bg = colors.crust },
                            CursorLine = { bg = colors.crust },

                            -- Set Line Numbers to a slighter lighter color
                            LineNr = { fg = colors.overlay1 },

                            -- The color of the bar for inactive (non-current) windows.
                            -- Make the foreground a little lighter
                            StatusLineNC = { fg = colors.overlay0, bg = colors.mantle },

                        },
                        colorscheme_helpers.lazy_highlights(colors),
                        colorscheme_helpers.markdown_highlights(colors),
                        colorscheme_helpers.render_markdown_highlights(colors)
                    )
                end,
            })
        end,
    },
}
