return {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    dependencies = {
        { src = "https://github.com/nvim-lua/plenary.nvim" },
        {
            src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
            build = function(ctx, done)
                -- Build with make
                if not ctx.plugin_dir or ctx.plugin_dir == "" then
                    done(false, "telescope-fzf-native directory not found")
                    return true
                end

                vim.system({ "make" }, { cwd = ctx.plugin_dir }, function(result)
                    vim.schedule(function()
                        if result.code == 0 then
                            done(true)
                            return
                        end

                        done(false, result.stderr or result.stdout or "Unknown build error")
                    end)
                end)

                return "async"
            end,
        },
        { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    },
    config = function()
        require("telescope").setup({
            extensions = {
                fzf = {},
            },
            defaults = {
                mappings = {
                    i = {
                        -- Make esc quit telescope instead of entering normal
                        -- mode inside telescope
                        ["<esc>"] = require("telescope.actions").close
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
            "<leader>fu",
            -- This is basically builtin.lsp_definitions and builtin.lsp_references together
            telescope_helpers.smart_definition,
            { desc = "Telescope [f]ind [u]sages" }
        )
    end,
}
