-- Fuzzy picker for files, grep, buffers and help

return {
    "nvim-mini/mini.pick",
    version = false,
    -- Lazy-load on Pick command or when pressing picker keybindings
    cmd = "Pick",
    keys = {
        { "<leader>ff", desc = "[f]ind [f]iles" },
        { "<leader>fg", desc = "[f]ind with live [g]rep" },
        { "<leader>fb", desc = "[f]ind [b]uffers" },
        { "<leader>fh", desc = "[f]ind [h]elp tags" },
        { "<leader>fc", desc = "[f]ind [c]onfig files" },
    },
    dependencies = {
        "nvim-mini/mini.icons",
    },
    config = function()
        local pick = require("mini.pick")
        pick.setup()

        vim.keymap.set("n", "<leader>ff", pick.builtin.files, { desc = "[f]ind [f]iles" })

        vim.keymap.set("n", "<leader>fg", pick.builtin.grep_live, { desc = "[f]ind with live [g]rep" })

        vim.keymap.set("n", "<leader>fb", pick.builtin.buffers, { desc = "[f]ind [b]uffers" })

        vim.keymap.set("n", "<leader>fh", pick.builtin.help, { desc = "[f]ind [h]elp tags" })

        vim.keymap.set("n", "<leader>fc", function()
            pick.builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } })
        end, { desc = "[f]ind [c]onfig files" })
    end,
}
