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

        local function smart_definition()
            -- This checks if the cursor is currently sitting on the definition.
            -- If YES: Open References.
            -- If NO:  Go to Definition.
            vim.lsp.buf_request(0, "textDocument/definition", vim.lsp.util.make_position_params(0, "utf-16"),
                function(err, result, _, _)
                    -- If no definition found, just try to open definitions (will show "not found")
                    if err or not result or vim.tbl_isempty(result) then
                        builtin.lsp_definitions()
                        return
                    end

                    -- Ensure 'result' is always a list so we can loop over it
                    local definitions = vim.islist(result) and result or { result }

                    -- Get current cursor info
                    local current_buf = vim.api.nvim_get_current_buf()
                    local current_uri = vim.uri_from_bufnr(current_buf)
                    local current_row = vim.api.nvim_win_get_cursor(0)[1] - 1

                    local cursor_is_at_definition = false

                    -- Check every definition returned by the server
                    for _, def in ipairs(definitions) do
                        local def_uri = def.uri or def.targetUri
                        local def_range = def.range or def.targetSelectionRange

                        local is_same_file = (def_uri == current_uri)

                        if is_same_file then
                            local is_same_line = (current_row >= def_range.start.line and current_row <= def_range["end"].line)
                            if is_same_line then
                                cursor_is_at_definition = true
                                -- We found a match, no need to check others
                                break
                            end
                        end
                    end

                    -- Decide what to open
                    if cursor_is_at_definition then
                        builtin.lsp_references()
                    else
                        builtin.lsp_definitions()
                    end
                end)
        end

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
            smart_definition,
            { desc = "Telescope [f]ind [u]sages" }
        )
    end,
}
