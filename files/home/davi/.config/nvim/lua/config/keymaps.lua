-- Make arrow keys behave like hjkl in all relevant modes.
-- This is is necessary because I use a custom Colemak keyboard layout.
-- This make the use of hjkl impractical. To avoid remapping several keys
-- to get the navigation right, I have a navigation layer (in the keyboard
-- layout managed by Kanata) that has the arrow keys on easy access.
-- By remapping only the arrow keys to hjkl, I can have my navigation and other
-- commands all correct without many remapping on nvim or on my layout.
local function map_all_modes(lhs, rhs, opts)
    for _, mode in ipairs({ "n", "i", "v", "x", "s", "o"}) do
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end
map_all_modes("<Up>", "k", { noremap = true })
map_all_modes("<Down>", "j", { noremap = true })
map_all_modes("<Left>", "h", { noremap = true })
map_all_modes("<Right>", "l", { noremap = true })
map_all_modes("<C-Up>", "<C-k>", { noremap = true })
map_all_modes("<C-Down>", "<C-j>", { noremap = true })
map_all_modes("<C-Left>", "<C-h>", { noremap = true })
map_all_modes("<C-Right>", "<C-l>", { noremap = true })
-- Disable the home and end keys because I was using them in the insert mode for navigation
map_all_modes("<Home>", "<Nop>", { noremap = true })
map_all_modes("<End>", "<Nop>", { noremap = true })

-- Format file
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { desc = '[F]ormat [F]ile' })

-- Set enter to *not* accept the completion. Instead, just enter a new line.
vim.keymap.set('i', '<cr>', function()
    return vim.fn.pumvisible() == 1 and '<c-e><cr>' or '<cr>'
end, { expr = true, noremap = true })
