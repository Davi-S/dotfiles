return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            extensions = {
                fzf = {},
            },
            defaults = {
                mappings = {
                    i = {
                        -- Make esc quit telescope instead of entering normal
                        -- mode inside telescope
                        ["<esc>"] = actions.close,
                    },
                },
            }

        })

        require("telescope").load_extension("fzf")

        local builtin = require("telescope.builtin")
        local telescope_helpers = require("plugins_helpers.telescope_helper")

        vim.keymap.set(
            "n",
            "<leader>ff",
            builtin.find_files,
            { desc = "Telescope [f]ind [f]iles" }
        )
        vim.keymap.set("n",
            "<leader>lg",
            function()
                builtin.live_grep({
                    hidden = true,
                    no_ignore = true,
                })
            end,
            { desc = "Telescope [l]ive [g]rep" }
        )
        vim.keymap.set("n",
            "<leader>fb",
            builtin.buffers,
            { desc = "Telescope [f]ind [b]uffers" }
        )
        vim.keymap.set(
            "n",
            "<leader>fh",
            builtin.help_tags,
            { desc = "Telescope [f]ind [h]elp tags" }
        )
        vim.keymap.set("n",
            "<leader>fc",
            function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end,
            { desc = "Telescope [f]ind [c]onfig files" }
        )
        vim.keymap.set(
            "n",
            "<leader>fs",
            builtin.lsp_document_symbols,
            { desc = "Telescope [f]ind document [s]ymbols" }
        )
        vim.keymap.set(
            "n",
            "<leader>fu",
            -- This is basically builtin.lsp_definitions and builtin.lsp_references together
            telescope_helpers.smart_definition,
            { desc = "Telescope [f]ind [u]sages" }
        )
    end,
}
