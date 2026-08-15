-- =============================================================================
-- Global Keymaps and Leader Bindings
-- =============================================================================

-- Global map leader (must be configured before lazy.nvim or plugins load)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------
-- Navigation Layer Mapping (Colemak Layout Compatibility)
--------------------------------------------------------------------------------
-- Custom Colemak keyboard layout (via Kanata) uses an arrow-key navigation layer.
-- Remapping arrow keys to hjkl across all modes avoids remapping dozens of individual
-- Neovim commands, preserving standard hjkl behavior while keeping navigation comfortable.

local function map_all_modes(lhs, rhs, opts)
    for _, mode in ipairs({ "n", "i", "v", "x", "s", "o" }) do
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

-- Basic arrow key navigation -> hjkl
map_all_modes("<Up>", "k", { remap = true })
map_all_modes("<Down>", "j", { remap = true })
map_all_modes("<Left>", "h", { remap = true })
map_all_modes("<Right>", "l", { remap = true })

-- Ctrl + Arrow key navigation -> Ctrl + hjkl
map_all_modes("<C-Up>", "<C-k>", { remap = true })
map_all_modes("<C-Down>", "<C-j>", { remap = true })
map_all_modes("<C-Left>", "<C-h>", { remap = true })
map_all_modes("<C-Right>", "<C-l>", { remap = true })

-- Shift + Arrow key navigation -> Shift + HJKL
map_all_modes("<S-Up>", "K", { remap = true })
map_all_modes("<S-Down>", "J", { remap = true })
map_all_modes("<S-Left>", "H", { remap = true })
map_all_modes("<S-Right>", "L", { remap = true })

-- Alt + Arrow key navigation -> Alt + hjkl
map_all_modes("<A-Up>", "<A-k>", { remap = true })
map_all_modes("<A-Down>", "<A-j>", { remap = true })
map_all_modes("<A-Left>", "<A-h>", { remap = true })
map_all_modes("<A-Right>", "<A-l>", { remap = true })

-- Disable Home/End in all modes (prevents unintended jumps during insert mode)
map_all_modes("<Home>", "<Nop>", { remap = false })
map_all_modes("<End>", "<Nop>", { remap = false })

--------------------------------------------------------------------------------
-- Window Navigation & Management
--------------------------------------------------------------------------------
-- Explicitly map <C-w> + Shift-Arrows to swap windows (preserves <C-w> shift behavior)
vim.keymap.set("n", "<C-w><S-Left>", "<C-w>H", { desc = "Move window Left" })
vim.keymap.set("n", "<C-w><S-Down>", "<C-w>J", { desc = "Move window Down" })
vim.keymap.set("n", "<C-w><S-Up>", "<C-w>K", { desc = "Move window Up" })
vim.keymap.set("n", "<C-w><S-Right>", "<C-w>L", { desc = "Move window Right" })

-- Focus window with Ctrl + Direction
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- Move/Swap window with Alt + Direction
vim.keymap.set("n", "<A-h>", "<C-w>H", { desc = "Move window Left" })
vim.keymap.set("n", "<A-j>", "<C-w>J", { desc = "Move window Down" })
vim.keymap.set("n", "<A-k>", "<C-w>K", { desc = "Move window Up" })
vim.keymap.set("n", "<A-l>", "<C-w>L", { desc = "Move window Right" })

--------------------------------------------------------------------------------
-- General Quality-of-Life Mappings
--------------------------------------------------------------------------------
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights on Escape" })
vim.keymap.set("n", "<leader><tab>", "<C-^>", { desc = "Toggle between two most recent buffers" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete character without overwriting register/clipboard" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[w]rite (save) file" })
