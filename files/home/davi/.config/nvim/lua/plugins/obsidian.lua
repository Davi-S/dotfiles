return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false, -- this will be removed in the next major release

        workspaces = {
            {
                name = "ObsidianAllInVault",
                path = "/home/davi/Documents/ObsidianAllInVault",
            }
        },

        daily_notes = {
            folder = "11 Diário/11.01 Diário",
            date_format = "%Y %B %d, %A",
            default_tags = { "nota_diária" },
            workdays_only = false,
            template = "Nota diária.md",
        },

        templates = {
            folder = "08 Templates",
            substitutions = require("plugins_helpers.obsidian_helper").substitutions
        },

        note_id_func = function(title)
            return title
        end,

        ui = {
            enable = false
        },
        footer = {
            enabled = false,
        },
        frontmatter = {
            enabled = false,
        }
    },
    config = function(_, opts)
        local obsidian = require("obsidian")
        obsidian.setup(opts)
        local obsidian_helper = require("plugins_helpers.obsidian_helper")

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
