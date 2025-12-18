-- Reference:
-- - https://github.com/hendrikmi/neovim-kickstart-config/blob/main/lua/plugins/lsp.lua
-- - https://youtu.be/oBiBEx7L000?si=s7zOaXS8f7RguRR2
-- - https://neovim.io/doc/user/lsp.html
-- - https://neovim.io/doc/user/lsp.html#lsp-completion
-- - https://neovim.io/doc/user/lsp.html#lsp-attach

return {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    "mason-org/mason.nvim",
    dependencies = {
        -- mason-lspconfig:
        -- - Bridges the gap between LSP config names (e.g. "lua_ls") and actual Mason package names (e.g. "lua-language-server").
        -- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed` used by 'WhoIsSethDaniel/mason-tool-installer.nvim.'
        -- - It is a optional dependency of the 'WhoIsSethDaniel/mason-tool-installer.nvim' plugin. it does not even need to be setup; only need to be installed.
        -- - It does not auto-configure servers; we use vim.lsp.enable() explicitly for full control.
        "mason-org/mason-lspconfig.nvim",

        -- mason-tool-installer:
        -- - Installs LSPs, linters, formatters, etc. by their Mason package name.
        -- - We use it to ensure all desired tools are present.
        -- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup()
        local lsp_helpers = require("plugins_helpers.lsp")

        -- Enable the following language servers
        local servers_list = {
            "lua_ls",         -- Lua
            "basedpyright",   -- Python
            "ruff",           -- Python
            "bashls",         -- Bash
            "markdown_oxide", -- Markdown
            "dockerls",       -- Docker
            "clangd",         -- C
            "taplo",          -- TOML
            "hyprls",         -- Hyprland config
        }

        -- Enable the following tools
        local tools_list = {
            "shfmt",      -- Bash
            "shellcheck", -- Bash
            "prettier",   -- Markdown
        }

        -- Combine the server list and tool list for mason-tool-installer
        local ensure_installed = {}
        vim.list_extend(ensure_installed, servers_list)
        vim.list_extend(ensure_installed, tools_list)

        require("mason-tool-installer").setup({
            ensure_installed = ensure_installed,
            auto_update = true,
        })

        -- Loop through the server list and configure each one
        for _, server_name in ipairs(servers_list) do
            -- Neovim automatically loads the configuration from 'nvim/lsp/[server_name].lua',
            -- so there is no need to call `vim.lsp.config()`. The configurations under
            -- 'nvim/lsp/[server_name].lua' were downloaded from the lspconfig and edited as I
            -- please. I prefer to have the settings locally instead of a plugin dependency.
            vim.lsp.enable(server_name)
        end

        -- Doing this to override the max size of the `lsp.hover` window (and
        -- any other lsp floating windows apparently)
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            -- width same as the recommended max line width
            opts.max_width = 80
            -- height same as the completion window
            opts.max_height = 10
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        -- Create a autocommand for when a lsp server attaches a buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            desc = "LSP on_attach setup",
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                lsp_helpers.setup_formatting(args, client)
                lsp_helpers.setup_highlight_under_cursor(args, client)
            end,
        })
    end,
}
