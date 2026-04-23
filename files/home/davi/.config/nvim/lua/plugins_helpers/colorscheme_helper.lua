local function markdown_highlights(colors)
    return {
        -- Headings
        ["@markup.heading.1.markdown"] = { fg = colors.sapphire, bold = true },
        ["@markup.heading.2.markdown"] = { fg = colors.sapphire, bold = true },
        ["@markup.heading.3.markdown"] = { fg = colors.sapphire, bold = true },
        ["@markup.heading.4.markdown"] = { fg = colors.sapphire, bold = true },
        ["@markup.heading.5.markdown"] = { fg = colors.sapphire, bold = true },
        ["@markup.heading.6.markdown"] = { fg = colors.sapphire, bold = true },
        -- ["markdownHeadingDelimiter"] = { fg = colors.green, bold = true },
        -- ["rainbow1"] = { fg = colors.green, bold = true },
        -- ["rainbow2"] = { fg = colors.green, bold = true },
        -- ["rainbow3"] = { fg = colors.green, bold = true },
        -- ["rainbow4"] = { fg = colors.green, bold = true },
        -- ["rainbow5"] = { fg = colors.green, bold = true },
        -- ["rainbow6"] = { fg = colors.green, bold = true },

        -- Code blocks
        ["@markup.raw.block.markdown"] = { fg = colors.subtext1 },
        ["@markup.raw.markdown_inline"] = { fg = colors.subtext1 },
        ["@label.markdown"] = { fg = colors.subtext1 },
        -- ["markdownCodeBlock"] = { fg = colors.subtext1 },
        -- ["markdownCode"] = { fg = colors.subtext1 },

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
        ["@markup.strong.markdown_inline"] = { fg = colors.text, bold = true },
        ["@markup.italic.markdown_inline"] = { fg = colors.text, italic = true },
        ["@markup.strikethrough.markdown_inline"] = { fg = colors.text, strikethrough = true },

        -- Quotes
        -- ["@markup.quote.markdown"] = { fg = colors.peach },
        -- This is for ">", "---", and tables
        -- ["@punctuation.special.markdown"] = { fg = colors.peach },

        -- List
        ["@markup.list.markdown"] = { fg = colors.text },
        ["@markup.list.unchecked.markdown"] = { fg = colors.text },
        ["@markup.list.checked.markdown"] = { fg = colors.text },
        ["@markup.link.label.markdown_inline"] = { fg = colors.text },
        ["@markup.link.markdown_inline"] = { fg = colors.text },

        -- Table
        ["@punctuation.special.markdown"] = { fg = colors.subtext1 },
        ["@markup.raw.markdown_inline"] = { fg = colors.text },

        -- YAML
        ["@keyword.directive.markdown"] = { fg = colors.subtext1 },
        -- ["yamlDocumentStart"] = { fg = colors.peach },
        -- ["yamlBlockMappingKey"] = { fg = colors.peach },
    }
end

local M = {}

M.markdown_highlights = markdown_highlights

return M
