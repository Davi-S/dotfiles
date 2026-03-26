return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "kdheepak/cmp-latex-symbols",
            "hrsh7th/cmp-nvim-lua",
            "nvim-web-devicons",
        },

        config = function()
            local cmp = require("cmp")
            local context = require("cmp.config.context")
            local completion_helpers = require("plugins_helpers.completions_helper")

            -- Completion options from nvim --
            -- completion behavior for pop up menu
            vim.opt.completeopt = {
                -- Fuzzy is not strictly necessary, since nvim-cmp already has a
                -- completion logic
                "fuzzy",
                "menuone",
                "noinsert",
            }
            -- maximum items to show in completion pop up menu
            vim.opt.pumheight = 10

            -- Setup for main mode, this is, the insert mode
            cmp.setup({
                -- Setup the menu appearance --
                window = {
                    completion = cmp.config.window.bordered({
                        scrollbar = false,
                    }),
                    documentation = cmp.config.window.bordered({
                        scrollbar = false,
                    }),
                },

                -- By default, the custom completion menu's order is top-down;
                -- The highest scoring entry appears at the top of the menu.
                -- However, when in cmdline mode, or when the cursor is near the
                -- bottom of the screen, and the menu opens above the cursor, it
                -- sometimes can be preferable if the menu used a bottom down
                -- approach
                -- view = {
                --     entries = { name = "custom", selection_order = "near_cursor" }
                -- },

                -- Use web-devicon for files and file types; use the custom
                -- icons defined above for everything else
                formatting = {
                    format = function(entry, vim_item)
                        -- Use web-devicons for path completions
                        if entry.source.name == "path" then
                            local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item()
                                .label)
                            if icon then
                                vim_item.kind = icon
                                vim_item.kind_hl_group = hl_group
                            end
                        else
                            -- Fallback to custom icons for all other sources
                            -- This uses your specific kind_icons table
                            local icon = completion_helpers.kind_icons[vim_item.kind] or ""
                            vim_item.kind = string.format("%s %s", icon, vim_item.kind)
                        end

                        -- Source Menu Labels
                        vim_item.menu = ({
                            buffer                      = "[Buffer]",
                            nvim_lsp                    = "[LSP]",
                            path                        = "[Path]",
                            nvim_lua                    = "[Lua]",
                            latex_symbols               = "[LaTeX]",
                            emoji                       = "[Emoji]",
                            calc                        = "[Calc]",
                            ["nvim-lsp-signature-help"] = "[Sig]",
                        })[entry.source.name]

                        return vim_item
                    end,
                },

                -- Defines a set of conditional rules that determine exactly
                -- when the completion menu is allowed to pop up.
                enabled = function()
                    local disabled = false
                    -- Disable for prompt buffers (like Telescope)
                    disabled = disabled or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
                    -- Disables completion while recording a macro
                    disabled = disabled or (vim.fn.reg_recording() ~= '')
                    -- Disables completion while a macro is playing back
                    disabled = disabled or (vim.fn.reg_executing() ~= '')
                    return not disabled
                end,

                -- Use nvim default snippet support
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },

                -- Set the key mapping
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    -- Disable Enter (<CR>) for completion
                    ["<CR>"] = nil,
                    -- Disable arrow keys from selecting items
                    ["<Down>"] = cmp.config.disable,
                    ["<Up>"] = cmp.config.disable,
                }),

                -- Set the sources --
                sources = cmp.config.sources({
                    {
                        name = "nvim_lsp",
                        -- Do not show lsp suggestions in comments
                        entry_filter = function()
                            return not (
                                context.in_treesitter_capture("comment") or
                                context.in_syntax_group("Comment")
                            )
                        end
                    },
                }, {
                    -- My own obsidian plugin for nvim
                    { name = "nvim_obsidian" },
                    {
                        name = "buffer",
                        -- Do not show buffer suggestions in comments or in
                        -- markdown files
                        entry_filter = function()
                            return not (
                                context.in_treesitter_capture("comment") or
                                context.in_syntax_group("Comment") or
                                vim.bo.filetype == 'markdown'
                            )
                        end
                    },
                    { name = "emoji" },
                    { name = "calc" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "path" },
                    { name = "latex_symbols" },
                    { name = "nvim_lua" },
                }),
            })

            -- Setup for command line in search mode
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } }
            })

            -- Setup for command line command mode
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })
        end,
    },
}
