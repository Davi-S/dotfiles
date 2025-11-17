return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.config').setup({
            ensure_installed = "all",

            -- Install parsers asynchronously
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                -- Setting this to true will run both tree-sitter and vim regex highlighting,
                -- which can slow things down and cause duplicate highlights. Keep false unless
                -- you need it for a specific language.
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true,
            },
        })
    end,
}
