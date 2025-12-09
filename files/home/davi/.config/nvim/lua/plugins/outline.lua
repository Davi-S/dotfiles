return {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
        { "<leader>oo", "<cmd>OutlineOpen<CR>",      desc = "[o]utline [o]pen" },
        { "<leader>oc", "<cmd>OutlineClose<CR>",     desc = "[o]utline [c]lose" },
        { "<leader>os", "<cmd>OutlineFocusCode<CR>", desc = "[o]utline focus on [s]ource" },
        { "<leader>of", "<cmd>OutlineFollow<CR>",    desc = "[o]utline [f]ollow the corresponding node in outline" },
    },
    opts = {
        symbol_folding = {
            autofold_depth = false,
        },
    },
}
