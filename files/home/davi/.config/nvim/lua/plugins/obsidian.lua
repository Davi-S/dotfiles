return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    -- load the plugin only on markdown files or when any of its commands are
    -- used
    ft = "markdown",
    cmd = { "Obsidian *" },
    -- Setting the keys here so they work before the plugin is loaded
    keys = {
        { "<leader>dh", "<cmd>Obsidian today<cr>",     desc = "Obsidian [d]aily note for today ([h]oje)" },
        { "<leader>dy", "<cmd>Obsidian yesterday<cr>", desc = "Obsidian [d]aily note for [y]esterday" },
        { "<leader>dt", "<cmd>Obsidian tomorrow<cr>",  desc = "Obsidian [d]aily note for [t]omorrow" },
    },
    dependencies = {
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local colors = require("catppuccin.palettes").get_palette("mocha")
        local obsidian_helper = require("plugins_helpers.obsidian_helper")
        local obsidian = require("obsidian")

        obsidian.setup({
            legacy_commands = false, -- this will be removed in the next major release

            workspaces = {
                {
                    name = "ObsidianAllInVault",
                    path = "/home/davi/Documents/ObsidianAllInVault",
                }
            },

            templates = {
                folder = "08 Templates",
                substitutions = require("plugins_helpers.obsidian_helper").substitutions
            },

            daily_notes = {
                folder = "11 Diário/11.01 Diário",
                date_format = "%Y %B %d, %A",
                default_tags = { "nota_diária" },
                workdays_only = false,
                template = "Nota diária.md",
            },

            -- setting this here so the note filename is the same as the title
            note_id_func = function(title)
                return title
            end,

            checkbox = {
                -- The order in which the checkboxes cycles when toggled
                -- order = { " ", "/", "x", "-", ">", "<" },
                order = { " ", "x" },
                create_new = false
            },

            ui = {
                -- Note that some ui elements will be overridden after the
                -- plugin setup
                enable = true,

                hl_groups = {
                    ObsidianCheckbox = { fg = colors.sapphire, bold = true },
                    ObsidianBullet = { fg = colors.text, bold = true },
                    -- The group for ordered lists are defined bellow as a
                    -- native nvim group
                    ObsidianLink = { fg = colors.sapphire },
                    ObsidianTag = { fg = colors.sapphire, italic = true },
                    ObsidianBlockID = { link = "Comment" },
                    ObsidianHighlightText = { bg = colors.yellow, fg = colors.base, bold = true },
                    -- The group for latex is defined bellow as a native nvim
                    -- group
                },

                checkboxes = {
                    [" "] = { hl_group = "ObsidianCheckbox" },
                    ["/"] = { hl_group = "ObsidianCheckbox" },
                    ["x"] = { hl_group = "ObsidianCheckbox" },
                    ["-"] = { hl_group = "ObsidianCheckbox" },
                    [">"] = { hl_group = "ObsidianCheckbox" },
                    ["<"] = { hl_group = "ObsidianCheckbox" },
                },
                bullets = { hl_group = "ObsidianBullet" },
                reference_text = { hl_group = "ObsidianLink" },
                external_link_icon = { char = "", hl_group = "ObsidianLink" },
                tags = { hl_group = "ObsidianTag" },
                block_ids = { hl_group = "ObsidianBlockID" },
                highlight_text = { hl_group = "ObsidianHighlightText" }
            },

            footer = {
                enabled = false,
            },
            frontmatter = {
                enabled = false,
            }
        })

        -- Set some custom highlights here
        obsidian_helper.setup_ordered_list_highlight()
        obsidian_helper.setup_ordered_list_checkbox_highlight()
        obsidian_helper.setup_math_highlight()
        obsidian_helper.setup_checkbox_dash_highlight()
        -- Disable the concealing of bold/italic syntax in Markdown. Only links
        -- will be concealed
        vim.g.markdown_syntax_conceal = 0


        -- Keymaps for custom commands
        obsidian_helper.create_user_command_DailyNext()
        vim.keymap.set("n", "<leader>dn",
            "<cmd>DailyNext<cr>",
            { desc = "Obsidian [d]aily note for the [n]ext day" })

        obsidian_helper.create_user_command_DailyPrev()
        vim.keymap.set("n", "<leader>dp",
            "<cmd>DailyPrev<cr>",
            { desc = "Obsidian [d]aily note for the [p]revious day" })

        obsidian_helper.create_user_command_DailyAt()
        vim.keymap.set("n", "<leader>da",
            "<cmd>DailyAt<cr>",
            { desc = "Obsidian [d]aily [a]t specific date" })
    end
}
