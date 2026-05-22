return {
    "mikavilpas/yazi.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    init = function()
        -- Fake netrw being loaded already so it wont load.
        vim.g.loaded_netrwPlugin = 1
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwSettings = 1
        vim.g.loaded_netrwFileHandlers = 1
        vim.g.loaded_netrw_gitignore = 1
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
