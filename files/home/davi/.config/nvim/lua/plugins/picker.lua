return {
    "nvim-mini/mini.pick",
    version = false,
    -- Lazy-load on Pick command or when pressing picker keybindings
    cmd = "Pick",
    keys = {
        { "<leader>ff", desc = "MiniPick [f]ind [f]iles" },
        { "<leader>fg", desc = "MiniPick [f]ind (live) [g]rep" },
        { "<leader>fb", desc = "MiniPick [f]ind [b]uffers" },
        { "<leader>fh", desc = "MiniPick [f]ind [h]elp tags" },
        { "<leader>fc", desc = "MiniPick [f]ind [c]onfig files" },
    },
    dependencies = {
        "nvim-mini/mini.icons",
    },
    config = function()
        local pick = require("mini.pick")
        pick.setup()

        vim.keymap.set("n", "<leader>ff", pick.builtin.files, { desc = "MiniPick [f]ind [f]iles" })

        vim.keymap.set("n", "<leader>fg", pick.builtin.grep_live, { desc = "MiniPick [f]ind (live) [g]rep" })

        vim.keymap.set("n", "<leader>fb", pick.builtin.buffers, { desc = "MiniPick [f]ind [b]uffers" })

        vim.keymap.set("n", "<leader>fh", pick.builtin.help, { desc = "MiniPick [f]ind [h]elp tags" })

        vim.keymap.set("n", "<leader>fc", function()
            pick.builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } })
        end, { desc = "MiniPick [f]ind [c]onfig files" })
    end,
}
