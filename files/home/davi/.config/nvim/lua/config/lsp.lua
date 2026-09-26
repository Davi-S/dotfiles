-- =============================================================================
-- LSP Configuration
-- =============================================================================
-- Reference:
-- - https://github.com/hendrikmi/neovim-kickstart-config/blob/main/lua/plugins/lsp.lua
-- - https://youtu.be/oBiBEx7L000?si=s7zOaXS8f7RguRR2
-- - https://neovim.io/doc/user/lsp.html
-- - https://neovim.io/doc/user/lsp.html#lsp-completion
-- - https://neovim.io/doc/user/lsp.html#lsp-attach
-- - https://neovim.io/doc/user/lsp/#_quickstart
--
-- This file does not depend on Mason. Mason (lua/plugins/lsp.lua) only installs
-- and updates the tools; the servers are started by Neovim's built-in LSP client,
-- which only needs their executables to be on PATH.
-- =============================================================================

local M = {}

-- Language servers to enable. These are also installed by Mason (see
-- lua/plugins/lsp.lua). Each name must match a config file in 'nvim/lsp/[server_name].lua'.
M.mason_servers = {
    -- Python
    "basedpyright", -- Type checker
    "ruff", -- Linter and code formatter
    -- JS/TS
    "vtsls", -- LSP
    "oxlint", -- Linter
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
    -- LUA
    "lua_ls", -- LSP
    "stylua", -- Formatter (runs as a language server)
    -- MARKDOWN
    "markdown_oxide", -- LSP
    -- C
    "clangd", -- LSP
    -- HYPRLAND
    "hyprls", -- LSP
}

-- Tools installed by Mason that are not language servers (formatters/linters
-- used by conform.nvim or by other servers). They are not passed to vim.lsp.enable().
M.mason_tools = {
    "oxfmt", -- JS/TS formatter
    "shfmt", -- Bash formatter
    "shellcheck", -- Bash linter (used by bashls)
    "prettier", -- Markdown formatter
}

-- Other servers that will be enabled, but not managed by Mason; they
-- need to be installed manually
M.other_servers = {}

-- Make Mason-installed executables available to the LSP client without loading Mason.
-- This is the only thing the servers need from Mason at runtime.
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

local function setup()
    local lsp_helpers = require("plugins_helpers.lsp_helper")

    -- Loop through the server list and enable each one
    for _, server_name in ipairs(vim.list_extend(vim.list_extend({}, M.mason_servers), M.other_servers)) do
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
            lsp_helpers.setup_highlight_under_cursor(args)
            lsp_helpers.setup_renaming(args)
            lsp_helpers.setup_code_actions(args)
            lsp_helpers.setup_codelens(args)
            lsp_helpers.setup_linked_editing_range(args)
            lsp_helpers.setup_on_type_formatting(args)
            -- Formatting is already covered by conform-nvim plugin. If the plugin is not configured, you can use it from lsp_helpers.setup_formatting(args)
            -- lsp_helpers.setup_inlay_hint(args)
            -- lsp_helpers.setup_inline_completion(args)
        end,
    })

    ------------------------------------------------------------------------

    -- mini.extra is loaded automatically by lazy.nvim when smart_definition requires it
    vim.keymap.set("n", "<leader>fu", lsp_helpers.smart_definition, { desc = "MiniPick [f]ind [u]sages" })

    -- Diagnostic navigation (next / previous error, warning, hint, diagnostic)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1 })
    end, { desc = "Next [d]iagnostic" })
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1 })
    end, { desc = "Previous [d]iagnostic" })
    vim.keymap.set("n", "]e", function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Next [e]rror" })
    vim.keymap.set("n", "[e", function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Previous [e]rror" })
    vim.keymap.set("n", "]w", function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
    end, { desc = "Next [w]arning" })
    vim.keymap.set("n", "[w", function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
    end, { desc = "Previous [w]arning" })
    vim.keymap.set("n", "]h", function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.HINT })
    end, { desc = "Next [h]int" })
    vim.keymap.set("n", "[h", function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.HINT })
    end, { desc = "Previous [h]int" })
end

-- Set up LSP when the first file is opened, so starting Neovim without a file
-- does not pay for loading vim.lsp
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("lsp-setup", { clear = true }),
    once = true,
    desc = "Enable language servers on first file open",
    callback = setup,
})

return M
