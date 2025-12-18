local obsidian_helpers = require("obsidian.helpers")

local function set_keymaps()
    vim.keymap.set(
        "n",
        "<leader>ff",
        function()
            if obsidian_helpers.is_obsidian_vault() then
                obsidian_helpers.find_files_with_aliases()
            else
                require("telescope.builtin").find_files()
            end
        end,
        { desc = "Telescope [f]ind [f]iles" }
    )
end

local M = {}

function M.setup()
    set_keymaps()
end

return M
