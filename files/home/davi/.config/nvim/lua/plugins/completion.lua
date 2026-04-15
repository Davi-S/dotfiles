return {
    src = "https://github.com/saghen/blink.cmp",
    version = "v1",
    dependencies = {
        { src = "https://github.com/moyiz/blink-emoji.nvim" },
        { src = "https://github.com/onsails/lspkind.nvim" },
        { src = "https://github.com/nvim-mini/mini.icons" },
    },
    config = function()
        local unpack_fn = table.unpack or unpack

        local function is_comment_context()
            local row, col = unpack_fn(vim.api.nvim_win_get_cursor(0))
            local ts_ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, row - 1, math.max(col - 1, 0))
            if ts_ok and captures then
                for _, capture in ipairs(captures) do
                    local name = type(capture) == "string" and capture or capture.capture
                    if type(name) == "string" and name:find("comment", 1, true) then
                        return true
                    end
                end
            end

            local syn_id = vim.fn.synID(row, math.max(col, 1), 1)
            local syn_name = vim.fn.synIDattr(vim.fn.synIDtrans(syn_id), "name")
            return type(syn_name) == "string" and syn_name:find("Comment", 1, true) ~= nil
        end

        require("blink.cmp").setup({


            completion = {

                --------------------------------------------------------------
                -- General completion
                --------------------------------------------------------------

                keyword = {
                    -- 'prefix' will fuzzy match on the text before the cursor
                    -- 'full' will fuzzy match on the text before _and_ after the cursor
                    -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
                    range = 'full',
                },
                trigger = {
                    -- Prefetch completions when entering insert mode so the menu is ready immediately.
                    prefetch_on_insert = true,
                    -- Show completions right away when entering insert mode.
                    show_on_insert = true,
                    -- Keep showing completions as keyword characters are typed.
                    show_on_keyword = true,
                    -- Also react to LSP trigger characters.
                    show_on_trigger_character = true,
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false
                    }
                },

                --------------------------------------------------------------
                -- Menu
                --------------------------------------------------------------

                -- Uses mini.icons to display icons for filetypes and lspkind for LSP kinds.
                menu = {
                    draw = {
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    if ctx.source_name ~= "Path" then
                                        return require("lspkind").symbol_map[ctx.kind] or "" .. ctx.icon_gap
                                    end

                                    local is_unknown_type = vim.tbl_contains(
                                        { "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
                                    local mini_icon, _ = require("mini.icons").get(
                                        is_unknown_type and "os" or ctx.item.data.type,
                                        is_unknown_type and "" or ctx.label
                                    )

                                    return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
                                end,

                                highlight = function(ctx)
                                    if ctx.source_name ~= "Path" then return ctx.kind_hl end

                                    local is_unknown_type = vim.tbl_contains(
                                        { "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
                                    local mini_icon, mini_hl = require("mini.icons").get(
                                        is_unknown_type and "os" or ctx.item.data.type,
                                        is_unknown_type and "" or ctx.label
                                    )
                                    return mini_icon ~= nil and mini_hl or ctx.kind_hl
                                end,
                            }
                        }
                    }
                },

                --------------------------------------------------------------
                -- Other
                --------------------------------------------------------------

                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500
                },
                ghost_text = {
                    enabled = true
                },
            },

            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },

            keymap = {
                preset = "default"
            },

            signature = {
                enabled = true,
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                    "emoji",
                    "nvim_obsidian",
                },
                per_filetype = {
                    markdown = {
                        "lsp",
                        "path",
                        "emoji",
                        "nvim_obsidian",
                    },
                },
                providers = {
                    -- Disable only LSP fallback so it does not implicitly chain into
                    -- buffer suggestions. Other providers keep defaults for their
                    -- normal behavior and source-specific fallback semantics.
                    lsp = {
                        fallbacks = {},
                        should_show_items = function()
                            return not is_comment_context()
                        end,
                    },
                    buffer = {
                        should_show_items = function()
                            return not is_comment_context()
                        end,
                    },

                    emoji = {
                        name = "Emoji",
                        module = "blink-emoji",
                        score_offset = 15,
                        opts = {
                            insert = true,
                            trigger = function()
                                return { ":" }
                            end,
                        },
                    },
                    nvim_obsidian = {
                        name = "nvim_obsidian",
                        module = "nvim_obsidian.adapters.completion.blink_source",
                    },
                },
            },

            cmdline = {
                sources = function()
                    local cmd_type = vim.fn.getcmdtype()
                    if cmd_type == "/" or cmd_type == "?" then
                        return { "buffer" }
                    end
                    if cmd_type == ":" or cmd_type == "@" then
                        return { "path", "cmdline" }
                    end
                    return {}
                end,
            },

        })
    end,
}
