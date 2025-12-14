return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("telescope").setup({
            extensions = {
                fzf = {},
            },
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close
                    },
                },
            }

        })

        require("telescope").load_extension("fzf")

        local builtin = require("telescope.builtin")
        local telescope_helpers = require("custom.telescope_helpers")

        vim.keymap.set(
            "n",
            "<leader>ff",
            function()
                if telescope_helpers.is_obsidian_vault() then
                    telescope_helpers.find_files_with_aliases()
                else
                    builtin.find_files()
                end
            end,
            { desc = "Telescope [f]ind [f]iles" }
        )
        vim.keymap.set("n",
            "<leader>lg",
            builtin.live_grep,
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
            "<leader>fd",
            builtin.lsp_definitions,
            { desc = "Telescope [f]ind (goto) [d]efinitions" }
        )
        vim.keymap.set(
            "n",
            "<leader>fr",
            builtin.lsp_references,
            { desc = "Telescope [f]ind (goto) [r]eferences" }
        )
        vim.keymap.set(
            "n",
            "<leader>lc",
            builtin.git_commits,
            { desc = "Telescope [l]ist [c]ommits" }
        )
        vim.keymap.set(
            "n",
            "<leader>fu",
            telescope_helpers.smart_definition,
            { desc = "Telescope [f]ind [u]sages" }
        )
    end,
}
