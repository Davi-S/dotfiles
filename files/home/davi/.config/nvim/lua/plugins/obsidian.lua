return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local colors = require("catppuccin.palettes").get_palette("mocha")
        local obsidian_helper = require("plugins_helpers.obsidian_helper")

        -- Require and set options
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

            note_id_func = function(title)
                return title
            end,

            checkbox = {
                -- The order in which [ ] cycles when you toggle
                order = { " ", "/", "x", "-", ">", "<" },
            },

            ui = {
                enable = true,

                hl_groups = {
                    -- `bold = true' wont make too much difference in itens that
                    -- uses an icon to conceal, but it makes sense that they
                    -- would be bold if possible.
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
                    -- The key is the char inside [ ], the value is the icon and color
                    [" "] = { char = "󰄰", hl_group = "ObsidianCheckbox" },
                    ["/"] = { char = "󱎕", hl_group = "ObsidianCheckbox" },
                    ["x"] = { char = "󰄴", hl_group = "ObsidianCheckbox" },
                    ["-"] = { char = "󰜺", hl_group = "ObsidianCheckbox" },
                    [">"] = { char = "󰁔", hl_group = "ObsidianCheckbox" },
                    ["<"] = { char = "󰃭", hl_group = "ObsidianCheckbox" },
                },
                bullets = { char = "•", hl_group = "ObsidianBullet" },
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

        -- Set this for ordered lists as the UI module of the Obsidian plugin
        -- does not support these groups
        obsidian_helper.setup_ordered_list_checkbox_highlight()
        obsidian_helper.setup_ordered_list_highlight()
        obsidian_helper.setup_math_highlight()

        -- Obsidian daily related keymaps
        vim.keymap.set("n", "<leader>dh",
            "<cmd>Obsidian today<cr>",
            { desc = "Obsidian [d]aily note for today ([h]oje)" })
        vim.keymap.set("n", "<leader>dy",
            "<cmd>Obsidian yesterday<cr>",
            { desc = "Obsidian [d]aily note for [y]esterday" })
        vim.keymap.set("n", "<leader>dt",
            "<cmd>Obsidian tomorrow<cr>",
            { desc = "Obsidian [d]aily note for [t]omorrow" })

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
