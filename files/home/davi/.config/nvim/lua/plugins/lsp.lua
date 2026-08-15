-- Reference:
-- - https://github.com/hendrikmi/neovim-kickstart-config/blob/main/lua/plugins/lsp.lua
-- - https://youtu.be/oBiBEx7L000?si=s7zOaXS8f7RguRR2
-- - https://neovim.io/doc/user/lsp.html
-- - https://neovim.io/doc/user/lsp.html#lsp-completion
-- - https://neovim.io/doc/user/lsp.html#lsp-attach
-- - https://neovim.io/doc/user/lsp/#_quickstart

return {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    "mason-org/mason.nvim",
    dependencies = {
        -- mason-lspconfig:
        -- - Bridges the gap between LSP config names (e.g. "lua_ls" in https://github.com/neovim/nvim-lspconfig/tree/master/lsp) and actual Mason package names (e.g. "lua-language-server").
        -- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed` used by 'WhoIsSethDaniel/mason-tool-installer.nvim.'
        -- - It is a optional dependency of the 'WhoIsSethDaniel/mason-tool-installer.nvim' plugin. it does not even need to be setup; only need to be installed.
        -- - It does not auto-configure servers; we use vim.lsp.enable() explicitly for full control.
        "mason-org/mason-lspconfig.nvim",

        -- mason-tool-installer:
        -- - Installs LSPs, linters, formatters, etc. by their Mason package name.
        -- - We use it to ensure all desired tools are present.
        -- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- This is for the keybind that picks lsp definitions
        "nvim-mini/mini.extra",
    },
    config = function()
        require("mason").setup()
        local lsp_helpers = require("plugins_helpers.lsp_helper")

        -- Enable the following language servers
        -- These will be managed by Mason
        local mason_servers_list = {
            -- Python
            "basedpyright", -- Type checker
            "ruff", -- Linter and code formatter
            -- JS/TS
            "vtsls", -- LSP
            "oxlint", -- Linter
            "oxfmt", -- Formatter
            -- HTML
            "html", -- LSP
            -- CSS
            "cssls", -- LSP
            "tailwindcss", -- LSP
            -- TOML
            "taplo", -- LSP/Formatter/Linter
            -- JSON
            "jsonls", -- LSP
            -- BASH
            "bashls", -- LSP
            "shfmt", -- Bash
            "shellcheck", -- Bash

            -- LUA
            "lua_ls", -- LSP
            "stylua", -- Formatter
            -- MARKDOWN
            "markdown_oxide", -- LSP
            "prettier", -- Formatter
            -- C
            "clangd", -- LSP
            -- HYPRLAND
            "hyprls", -- LSP
        }

        -- Other servers that will be enable, but not managed by Mason; they
        -- need to be installed manually
        local other_servers_list = {}

        -- Install with mason
        local mason_ensure_installed = {}
        vim.list_extend(mason_ensure_installed, mason_servers_list)
        require("mason-tool-installer").setup({
            ensure_installed = mason_ensure_installed,
            auto_update = true,
        })

        -- Combine all servers (the ones managed by mason, and the ones not
        -- managed by mason)
        local all_servers = {}
        vim.list_extend(all_servers, mason_servers_list)
        vim.list_extend(all_servers, other_servers_list)

        -- Loop through the server list and configure each one
        for _, server_name in ipairs(all_servers) do
            -- Neovim automatically loads the configuration from 'nvim/lsp/[server_name].lua',
            -- so there is no need to call `vim.lsp.config()`. The configurations under
            -- 'nvim/lsp/[server_name].lua' were downloaded from the lspconfig and edited as I
            -- please. I prefer to have the settings locally instead of a plugin dependency.
            vim.lsp.enable(server_name, true)
        end

        ------------------------------------------------------------------------

        -- Override maximum width and height for all LSP floating windows (hover, signature help)
        local orig_open_floating_preview = vim.lsp.util.open_floating_preview
        ---@diagnostic disable-next-line: duplicate-set-field
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            -- width same as the recommended max line width
            opts.max_width = 80
            -- height same as the completion window
            opts.max_height = 10
            return orig_open_floating_preview(contents, syntax, opts, ...)
        end

        -- More layout configurations
        -- Diagnostic UI appearance settings
        vim.diagnostic.config({
            virtual_text = true,
            severity_sort = true,
            float = { source = true },
        })

        ------------------------------------------------------------------------

        -- Create a autocmd for when a lsp server attaches a buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            desc = "LSP on_attach setup",
            callback = function(args)
                -- Enable features
                lsp_helpers.setup_formatting(args)
                lsp_helpers.setup_highlight_under_cursor(args)
                lsp_helpers.setup_renaming(args)
                lsp_helpers.setup_code_actions(args)
                lsp_helpers.setup_codelens(args)
                lsp_helpers.setup_linked_editing_range(args)
                -- lsp_helpers.setup_inlay_hint(args)
                -- lsp_helpers.setup_inline_completion(args)
                lsp_helpers.setup_on_type_formatting(args)
            end,
        })

        ------------------------------------------------------------------------

        vim.keymap.set("n", "<leader>fu", lsp_helpers.smart_definition, { desc = "MiniPick [f]ind [u]sages" })
    end,
}
