-- =============================================================================
-- Global Keymaps and Leader Bindings
-- =============================================================================

-- Global map leader (must be configured before lazy.nvim or plugins load)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------
-- General Quality-of-Life Mappings
--------------------------------------------------------------------------------
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights on Escape" })
vim.keymap.set("n", "<leader><tab>", "<C-^>", { desc = "Toggle between two most recent buffers" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete character without overwriting register/clipboard" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[w]rite (save) file" })
