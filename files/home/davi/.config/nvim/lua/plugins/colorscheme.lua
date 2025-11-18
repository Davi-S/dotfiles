return {
    {
        "folke/tokyonight.nvim",
        config = function()
            -- Apply setup with the declarative opts table
            require("tokyonight").setup {
                style = "night",
                on_colors = function(colors)
                    colors.bg = "#000000"
                    colors.fg = "#deddda"
                end,
                on_highlights = function(highlights, colors)
                    -- Load overrides from a dedicated module.
                    local build_overrides = require("colors.tokyonight_overrides")
                    local overrides = build_overrides(colors)
                    for group, spec in pairs(overrides) do
                        highlights[group] = spec
                    end
                end,
            }
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin.nvim",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                flavour = "mocha",
                color_overrides = {
                    -- -----------------------------------------------------------------------------
                    -- CUSTOM PALETTE: High Contrast Mocha
                    -- -----------------------------------------------------------------------------
                    -- Derived from Catppuccin Mocha with the following transformations:
                    -- 1. Black Point Re-anchoring: 'Crust' mapped to Pure Black (#000000).
                    -- 2. White Point Re-anchoring: 'Text' mapped to Warm White (#deddda).
                    -- 3. Lightness Remapping: All intermediate colors linearly interpolated
                    --    (lerped) via HLS space to fit the expanded contrast range.
                    -- 4. Saturation Boost: +50% saturation applied to preserve color vibrance
                    --    against the darker background. Neutrals (Surface/Overlay) preserve 
                    --    the original saturation to avoid blue tint
                    -- 5. Swapped base with crust.
                    -- -----------------------------------------------------------------------------
                    mocha = {
                        rosewater = "#fad5ce",
                        flamingo  = "#fabbbb",
                        pink      = "#ffaee8",
                        mauve     = "#c391ff",
                        red       = "#ff7098",
                        maroon    = "#fd7f93",
                        peach     = "#ffa873",
                        yellow    = "#fee09d",
                        green     = "#8bf283",
                        teal      = "#72f4de",
                        sky       = "#65e7ff",
                        sapphire  = "#4fc8ff",
                        blue      = "#75a9fe",
                        lavender  = "#a8b4fe",
                        text      = "#deddda",
                        subtext1  = "#b1bad9",
                        subtext0  = "#9ca3c1",
                        overlay2  = "#878ea9",
                        overlay1  = "#717791",
                        overlay0  = "#606377",
                        surface2  = "#4a4d5e",
                        surface1  = "#363746",
                        surface0  = "#21212e",
                        base      = "#000000", -- "#0d0d15",
                        mantle    = "#07070b",
                        crust     = "#0d0d15", -- "#000000",
                    },
                }
            }
        end,
    }
}
