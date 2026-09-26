-- Mason only installs and updates LSPs and related tools. The LSP setup itself
-- (which servers are enabled, keymaps, diagnostics) lives in lua/config/lsp.lua
-- and does not need Mason to be loaded.

return {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    "mason-org/mason.nvim",
    -- Load right after the first screen is drawn, so it never delays opening a file
    event = "VeryLazy",
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
    },
    config = function()
        -- PATH is already handled in lua/config/lsp.lua (so servers work without Mason loaded)
        require("mason").setup({ PATH = "skip" })

        local lsp_config = require("config.lsp")

        -- Install with mason: the language servers plus the non-LSP tools
        local mason_ensure_installed = {}
        vim.list_extend(mason_ensure_installed, lsp_config.mason_servers)
        vim.list_extend(mason_ensure_installed, lsp_config.mason_tools)
        require("mason-tool-installer").setup({
            ensure_installed = mason_ensure_installed,
            auto_update = true,
            start_delay = 3000, -- Delay in ms before checking updates in the background (async)
            debounce_hours = 24, -- Only check for updates once every 24 hours
        })

        -- The plugin normally starts its check on VimEnter, which has already
        -- happened when loading on VeryLazy, so start it explicitly
        require("mason-tool-installer").run_on_start()
    end,
}
