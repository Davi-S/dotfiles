return {
    "nvim-mini/mini.pick",
    version = false,
    dependencies = {
        "nvim-mini/mini.icons",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local pick = require("mini.pick")
        pick.setup()

        vim.keymap.set("n", "<leader>ff", pick.builtin.files, { desc = "MiniPick [f]ind [f]iles" })

        vim.keymap.set("n", "<leader>lg", pick.builtin.grep_live, { desc = "MiniPick [l]ive [g]rep" })

        vim.keymap.set("n", "<leader>fb", pick.builtin.buffers, { desc = "MiniPick [f]ind [b]uffers" })

        vim.keymap.set("n", "<leader>fh", pick.builtin.help, { desc = "MiniPick [f]ind [h]elp tags" })

        vim.keymap.set("n", "<leader>fc", function()
            pick.builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } })
        end, { desc = "MiniPick [f]ind [c]onfig files" })
    end,
}
