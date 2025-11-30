-- Make arrow keys behave like hjkl in all relevant modes.
-- This is is necessary because I use a custom Colemak keyboard layout.
-- This make the use of hjkl impractical. To avoid remapping several keys
-- to get the navigation right, I have a navigation layer (in the keyboard
-- layout managed by Kanata) that has the arrow keys on easy access.
-- By remapping only the arrow keys to hjkl, I can have my navigation and other
-- commands all correct without many remapping on nvim or on my layout.
local function map_all_modes(lhs, rhs, opts)
    for _, mode in ipairs({ "n", "i", "v", "x", "s", "o" }) do
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end
map_all_modes("<Up>", "k", { remap = true })
map_all_modes("<Down>", "j", { remap = true })
map_all_modes("<Left>", "h", { remap = true })
map_all_modes("<Right>", "l", { remap = true })
map_all_modes("<C-Up>", "<C-k>", { remap = true })
map_all_modes("<C-Down>", "<C-j>", { remap = true })
map_all_modes("<C-Left>", "<C-h>", { remap = true })
map_all_modes("<C-Right>", "<C-l>", { remap = true })
map_all_modes("<S-Up>", "K", { remap = true })
map_all_modes("<S-Down>", "J", { remap = true })
map_all_modes("<S-Left>", "H", { remap = true })
map_all_modes("<S-Right>", "L", { remap = true })
-- Disable the home and end keys because I was using them in the insert mode for navigation
map_all_modes("<Home>", "<Nop>", { remap = false })
map_all_modes("<End>", "<Nop>", { remap = false })

-- Window navigation --
-- Explicitly map <C-w> + Shift-Arrows to Move Windows (Swap)
-- This fixes the issue where <C-w> ignores the previous mappings of
-- shift-arrow to shift-keys
vim.keymap.set("n", "<C-w><S-Left>", "<C-w>H", { desc = "Move window Left" })
vim.keymap.set("n", "<C-w><S-Down>", "<C-w>J", { desc = "Move window Down" })
vim.keymap.set("n", "<C-w><S-Up>", "<C-w>K", { desc = "Move window Up" })
vim.keymap.set("n", "<C-w><S-Right>", "<C-w>L", { desc = "Move window Right" })

vim.keymap.set("n", "<Leader>w", ":w<CR>", { desc = "[w]rite the file" })
vim.keymap.set("n", "<Leader>q", ":q<CR>", { desc = "[q]uit neovim" })

-- Set enter to *not* accept the completion. Instead, just enter a new line.
vim.keymap.set("i", "<cr>", function()
    return vim.fn.pumvisible() == 1 and "<c-e><cr>" or "<cr>"
end, { expr = true, remap = false, desc = "Set enter to *not* accept the completion. Instead, just enter a new line" })

-- Insert a blank line without entering insert mode
vim.keymap.set("n", "<Leader>o", "o<Esc>", { desc = "Insert blank line below" })
vim.keymap.set("n", "<Leader>O", "O<Esc>", { desc = "Insert blank line above" })

-- Spell check
vim.keymap.set("n", "<Leader>st", ":set spell!<CR>", { desc = "[s]pell check [t]oggle" })
vim.keymap.set("n", "<Leader>ss", "z=", { desc = "[s]pelling [s]uggestions" })

-- Drag line
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Drag line up" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Drag line down" })


vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove the highlight when leaving search mode" })


vim.keymap.set('n', '<leader><tab>', '<C-^>', { desc = 'Toggle between the two most recent buffers' })


vim.keymap.set('n', 'x', '"_x', { desc = "Make 'x' (delete char) never pollute the clipboard" })


vim.keymap.set('n', '<leader>nc', function()
    local pattern = "[“”‘’–—\u{00A0};\u{200b}\u{200c}\u{200d}−]"

    -- We use pcall to suppress the ugly "E486: Pattern not found"
    -- red error message if the file is clean.
    -- "\r" acts as the Enter key.
    local found, _ = pcall(vim.cmd, "normal! /" .. pattern .. "\r")

    if not found then
        vim.notify("No confusing characters found.", vim.log.levels.INFO)
    end
end, { desc = "Jump to [n]ext [c]onfusing char" })

