return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
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
        },
        config = function(_, opts)
            -- Apply setup with the declarative opts table
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
}
