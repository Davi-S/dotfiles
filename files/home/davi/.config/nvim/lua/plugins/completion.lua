return {
    "saghen/blink.cmp",
    version = "v1",
    dependencies = {
        "moyiz/blink-emoji.nvim",
        "onsails/lspkind.nvim",
        "nvim-mini/mini.icons",
    },
    opts = function()
        local unpack_fn = table.unpack or unpack

        -- Helper to check if cursor is currently inside a code comment block
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

        -- Helper to fetch file/OS icon from mini.icons for Path completions
        local UNKNOWN_TYPES = { "link", "socket", "fifo", "char", "block", "unknown" }
        local function get_path_icon(ctx)
            local is_unknown = vim.tbl_contains(UNKNOWN_TYPES, ctx.item.data and ctx.item.data.type)
            local icon_type = is_unknown and "os" or (ctx.item.data and ctx.item.data.type)
            local icon_name = is_unknown and "" or ctx.label
            return require("mini.icons").get(icon_type, icon_name)
        end

        return {
            --------------------------------------------------------------------
            -- COMPLETION TRIGGER & MATCHING RULES
            --------------------------------------------------------------------
            completion = {
                keyword = {
                    range = "full", -- Fuzzy match text before and after cursor
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
                        auto_insert = false,
                    },
                },

                ----------------------------------------------------------------
                -- MENU DRAWING & ICONS (lspkind + mini.icons)
                ----------------------------------------------------------------
                menu = {
                    draw = {
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    if ctx.source_name ~= "Path" then
                                        local symbol = require("lspkind").symbol_map[ctx.kind] or ""
                                        return symbol .. ctx.icon_gap
                                    end

                                    local mini_icon, _ = get_path_icon(ctx)
                                    return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
                                end,

                                highlight = function(ctx)
                                    if ctx.source_name ~= "Path" then
                                        return ctx.kind_hl
                                    end

                                    local mini_icon, mini_hl = get_path_icon(ctx)
                                    return mini_icon ~= nil and mini_hl or ctx.kind_hl
                                end,
                            },
                        },
                    },
                },

                ----------------------------------------------------------------
                -- DOCUMENTATION & GHOST TEXT
                ----------------------------------------------------------------
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                ghost_text = {
                    enabled = true,
                },
            },

            --------------------------------------------------------------------
            -- KEYMAPS, FUZZY SEARCH & SIGNATURE HELP
            --------------------------------------------------------------------
            keymap = {
                preset = "default",
            },
            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
            signature = {
                enabled = true,
            },

            --------------------------------------------------------------------
            -- SOURCES & CUSTOM PROVIDERS
            --------------------------------------------------------------------
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
                    -- Suppress LSP and Buffer completion when typing inside code comments
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

                    -- Custom Emoji provider (triggered with ':')
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

                    -- Custom Obsidian vault adapter provider
                    nvim_obsidian = {
                        name = "nvim_obsidian",
                        module = "nvim_obsidian.adapters.completion.blink_source",
                    },
                },
            },

            --------------------------------------------------------------------
            -- COMMAND-LINE COMPLETION
            --------------------------------------------------------------------
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
        }
    end,
}
