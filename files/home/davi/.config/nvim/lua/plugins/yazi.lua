return {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },

    -- INIT runs at startup (Before plugin load)
    init = function()
        -- If you use `open_for_directories=true`, this is recommended
        -- Mark netrw as loaded so it's not loaded at all.
        -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
        vim.g.loaded_netrwPlugin = 1
    end,

    config = function()
        vim.keymap.set({ "n", "v" }, "<leader>y", "<cmd>Yazi<cr>", { desc = "Open yazi" })
        vim.keymap.set({ "n" }, "<leader>cy", "<cmd>Yazi cwd<cr>", { desc = "Open yazi in cwd" })

        require("yazi").setup({
            open_for_directories = true,
            keymaps = {
                show_help = "<f1>",
            },
        })
    end,
}
