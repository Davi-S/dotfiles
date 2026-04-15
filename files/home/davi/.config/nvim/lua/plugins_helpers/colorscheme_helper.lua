-- Highlights for the Lazy plugin interface
local function lazy_highlights(colors)
    return {
        -- Keyboard shortcuts in buttons
        -- (e.g., the "(I)" in Install)
        LazySpecial = { fg = colors.sapphire },
        -- The reason indicator
        LazyReasonPlugin = { fg = colors.sapphire },
    }
end

local function markdown_highlights(colors)
    return {
        -- Headings
        -- ["@markup.heading.1.markdown"] = { fg = colors.green, bold = true },
        -- ["@markup.heading.2.markdown"] = { fg = colors.green, bold = true },
        -- ["@markup.heading.3.markdown"] = { fg = colors.green, bold = true },
        -- ["@markup.heading.4.markdown"] = { fg = colors.green, bold = true },
        -- ["@markup.heading.5.markdown"] = { fg = colors.green, bold = true },
        -- ["@markup.heading.6.markdown"] = { fg = colors.green, bold = true },
        ["markdownHeadingDelimiter"] = { fg = colors.green, bold = true },
        ["rainbow1"] = { fg = colors.green, bold = true },
        ["rainbow2"] = { fg = colors.green, bold = true },
        ["rainbow3"] = { fg = colors.green, bold = true },
        ["rainbow4"] = { fg = colors.green, bold = true },
        ["rainbow5"] = { fg = colors.green, bold = true },
        ["rainbow6"] = { fg = colors.green, bold = true },

        -- Code blocks
        -- ["@markup.raw.block.markdown"] = { fg = colors.subtext1 },
        -- ["@markup.raw.markdown_inline"] = { fg = colors.subtext1 },
        -- ["@label.markdown"] = { fg = colors.subtext1 },
        ["markdownCodeBlock"] = { fg = colors.subtext1 },
        ["markdownCode"] = { fg = colors.subtext1 },

        -- Latex
        -- This @markup.math.latex will affect the "$" and the
        -- numbers, so I'm painting the "$", manually in the
        -- ftplugin file for markdown
        -- ["@markup.math.latex"] = { fg = colors.red },
        -- ["@function.latex"] = { fg = colors.red },
        -- ["@punctuation.bracket.latex"] = { fg = colors.red },
        -- ["@punctuation.delimiter.latex"] = { fg = colors.red },
        -- ["@operator.latex"] = { fg = colors.red },
        -- ["@label.latex"] = { fg = colors.red },
        -- ["@module.latex"] = { fg = colors.red },

        -- URL links
        -- ["@markup.link.url.markdown_inline"] = { fg = colors.sapphire },
        -- ["@markup.link.label.markdown_inline"] = { fg = colors.sapphire },
        -- ["@markup.link.markdown_inline"] = { fg = colors.sapphire },
        -- ["@markup.link.label.markdown"] = { fg = colors.sapphire },
        -- ["@markup.link.url.markdown"] = { fg = colors.sapphire },

        -- Internal link
        ["@lsp.type.decorator.markdown"] = { fg = colors.sapphire },
        ["@lsp.type.class.markdown"] = { fg = colors.sapphire },
        ["markdownLinkText"] = { fg = colors.sapphire },

        -- Text decoration
        -- ["@markup.strong.markdown_inline"] = { fg = colors.text, bold = true },
        -- ["@markup.italic.markdown_inline"] = { fg = colors.text, italic = true },
        -- ["@markup.strikethrough.markdown_inline"] = { fg = colors.text, strikethrough = true },

        -- Quotes
        -- ["@markup.quote.markdown"] = { fg = colors.peach },
        -- This is for ">", "---", and tables
        -- ["@punctuation.special.markdown"] = { fg = colors.peach },

        -- List and table
        -- ["@markup.list.markdown"] = { fg = colors.text },
        -- ["@markup.list.unchecked.markdown"] = { fg = colors.sapphire },
        -- ["@markup.list.checked.markdown"] = { fg = colors.sapphire },

        -- YAML
        -- ["@keyword.directive.markdown"] = { fg = colors.peach },
        ["yamlDocumentStart"] = { fg = colors.peach },
        ["yamlBlockMappingKey"] = { fg = colors.peach },
    }
end

local function render_markdown_highlights(colors)
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim
    return {
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
    }
end

local M = {}

M.lazy_highlights = lazy_highlights
M.markdown_highlights = markdown_highlights
M.render_markdown_highlights = render_markdown_highlights

return M
