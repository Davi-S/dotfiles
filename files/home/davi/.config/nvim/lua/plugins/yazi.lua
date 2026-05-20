return {
    "mikavilpas/yazi.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
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
