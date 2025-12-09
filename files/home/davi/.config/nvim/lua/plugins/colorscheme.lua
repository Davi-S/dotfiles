return {
    {
        "catppuccin/nvim",
        name = "catppuccin.nvim",
        priority = 1000,
        config = function()
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
                    return {
                        -- Keyboard shortcuts in buttons (e.g., the "(I)" in Install)
                        LazySpecial = { fg = colors.blue },
                        -- The reason indicator
                        LazyReasonPlugin = { fg = colors.blue },

                        -- Cursor marks
                        CursorColumn = { bg = colors.crust },
                        ColorColumn = { bg = colors.crust },
                        CursorLine = { bg = colors.crust },

                        -- Set Line Numbers to a slighter lighter color
                        LineNr = { fg = colors.overlay1 },

                        -- -----------------------------------------------------
                        -- MARKDOWN OVERRIDES
                        -- -----------------------------------------------------

                        -- Headings
                        ["@markup.heading.1.markdown"] = { fg = colors.green, bold = true },
                        ["@markup.heading.2.markdown"] = { fg = colors.green, bold = true },
                        ["@markup.heading.3.markdown"] = { fg = colors.green, bold = true },
                        ["@markup.heading.4.markdown"] = { fg = colors.green, bold = true },
                        ["@markup.heading.5.markdown"] = { fg = colors.green, bold = true },
                        ["@markup.heading.6.markdown"] = { fg = colors.green, bold = true },

                        -- Code blocks
                        ["@markup.raw.block.markdown"] = { fg = colors.subtext1 },
                        ["@markup.raw.markdown_inline"] = { fg = colors.subtext1 },
                        ["@label.markdown"] = { fg = colors.subtext1 },

                        -- Latex
                        -- This @markup.math.latex will affect the "$" and the
                        -- numbers, so I'm painting the "$", manually in the
                        -- ftplugin file for markdown
                        ["@markup.math.latex"] = { fg = colors.red },
                        ["@function.latex"] = { fg = colors.red },
                        ["@punctuation.bracket.latex"] = { fg = colors.red },
                        ["@punctuation.delimiter.latex"] = { fg = colors.red },
                        ["@operator.latex"] = { fg = colors.red },
                        ["@label.latex"] = { fg = colors.red },
                        ["@module.latex"] = { fg = colors.red },

                        -- URL links
                        ["@markup.link.url.markdown_inline"] = { fg = colors.sapphire },
                        ["@markup.link.label.markdown_inline"] = { fg = colors.sapphire },
                        ["@markup.link.markdown_inline"] = { fg = colors.sapphire },
                        ["@markup.link.label.markdown"] = { fg = colors.sapphire },
                        ["@markup.link.url.markdown"] = { fg = colors.sapphire },

                        -- Internal link
                        ["@lsp.type.decorator.markdown"] = { fg = colors.sapphire },
                        ["@lsp.type.class.markdown"] = { fg = colors.sapphire },

                        -- Text decoration
                        ["@markup.strong.markdown_inline"] = { fg = colors.text, bold = true },
                        ["@markup.italic.markdown_inline"] = { fg = colors.text, italic = true },
                        ["@markup.strikethrough.markdown_inline"] = { fg = colors.text, strikethrough = true },

                        -- Quotes
                        ["@markup.quote.markdown"] = { fg = colors.peach },
                        -- This is for ">", "---", and tables
                        ["@punctuation.special.markdown"] = { fg = colors.peach },

                        -- List and table
                        ["@markup.list.markdown"] = { fg = colors.text },
                        ["@markup.list.unchecked.markdown"] = { fg = colors.sapphire },
                        ["@markup.list.checked.markdown"] = { fg = colors.sapphire },

                        -- YAML
                        ["@keyword.directive.markdown"] = { fg = colors.peach },


                        -- -----------------------------------------------------
                        -- RENDER-MARKDOWN PLUGIN OVERRIDES
                        -- -----------------------------------------------------

                        -- Headings
                        RenderMarkdownH1 = { link = "@markup.heading.1.markdown" },
                        RenderMarkdownH2 = { link = "@markup.heading.2.markdown" },
                        RenderMarkdownH3 = { link = "@markup.heading.3.markdown" },
                        RenderMarkdownH4 = { link = "@markup.heading.4.markdown" },
                        RenderMarkdownH5 = { link = "@markup.heading.5.markdown" },
                        RenderMarkdownH6 = { link = "@markup.heading.6.markdown" },

                        -- Code blocks
                        RenderMarkdownCode = { link = "@markup.raw.block.markdown" },
                        RenderMarkdownCodeInline = { link = "@markup.raw.markdown_inline" },
                        RenderMarkdownHTMLContent = { link = "@markup.raw.markdown_inline" },

                        -- Latex
                        RenderMarkdownMath = { link = "@markup.math.latex" },

                        -- URL Links
                        RenderMarkdownLink = { link = "@markup.link.url.markdown_inline" },

                        -- Internal Links
                        RenderMarkdownWikiLink = { link = "@markup.link.label.markdown_inline" },

                        -- Text decoration

                        -- Quotes
                        RenderMarkdownQuote = { link = "@markup.quote.markdown" },
                        RenderMarkdownDash = { link = "@markup.quote.markdown" },

                        -- Lists and tables
                        RenderMarkdownBullet = { link = "@markup.list.markdown" },
                        RenderMarkdownTableHead = { link = "@punctuation.special.markdown" },
                        RenderMarkdownTableRow = { link = "@punctuation.special.markdown" },
                        RenderMarkdownChecked = { link = "@markup.list.checked.markdown" },
                        RenderMarkdownUnchecked = { link = "@markup.list.unchecked.markdown" },

                        -- YAML

                    }
                end,
            })
        end,
    },
}
