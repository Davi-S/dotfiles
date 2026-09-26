-- Note on arrow keys (see lua/config/layout_keymaps.lua):
-- The Colemak/Kanata navigation layer sends <Up>/<Down>/<Left>/<Right>, which
-- layout_keymaps.lua remaps to k/j/h/l with `remap = true`. Hardtime's default
-- `disabled_keys` turns the arrows into a hard <Nop>, which kills that layer.
-- Disabling those four entries restores them, and because the remap resolves to
-- real h/j/k/l, hardtime's `restricted_keys` still rate-limits them. The nagging
-- is preserved; only the blanket block is gone.

return {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
        { "<leader>th", "<cmd>Hardtime toggle<CR>", desc = "[t]oggle [h]ardtime" },
        { "<leader>tH", "<cmd>Hardtime report<CR>", desc = "Hardtime report" },
    },
    opts = {
        -- `false` per key removes hardtime's mapping entirely (an empty table
        -- here would be migrated to `disabled_keys = false`, which breaks setup).
        disabled_keys = {
            ["<Up>"] = false,
            ["<Down>"] = false,
            ["<Left>"] = false,
            ["<Right>"] = false,
        },

        -- Required for the arrows above to actually be rate-limited.
        -- Hardtime compares the key its handler receives (the remapped "k")
        -- against the last *typed* key, which `vim.on_key` reports as "<Up>".
        -- They never match, so with `allow_different_key = true` every arrow
        -- press looks like a fresh key and the counter resets. Turning it off
        -- makes the counter depend only on how fast restricted keys are pressed,
        -- so arrows are restricted exactly like h/j/k/l.
        -- Side effect: quickly alternating between different restricted keys
        -- (e.g. j k j k) is now also blocked.
        allow_different_key = false,

        -- The mouse is enabled on purpose in lua/config/options.lua
        disable_mouse = false,

        -- Filetypes of the plugins used in this config where hardtime must not
        -- interfere 
        disabled_filetypes = {
            ["minipick"] = true,
            ["ministarter"] = true,
            ["gitsigns%-blame"] = true,
        },
    },
}
