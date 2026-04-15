-- Global map leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------

-- This is a single source of truth for the global formatting keymap.
-- Some keymaps should be used across the whole config or should always be defined
-- for some behavior.
-- This is useful for features/keys that are common and very used across all files
--
-- For example, the keybind for formatting has a default behavior of just warning,
-- since the actual formatting configuration is usually defined in the lsp config.
-- Doing this will show what th intended behavior of the key is even when there are
-- no lsp/formatting configured for a determined file.
-- Basically, the lsp (or any other place that defines formatting) will be able to
-- Override the warning and use a single source of truth for formatting files.
local M = {
    code_format = "<leader>cf",
    rename_symbol = "<leader>r",
}

vim.keymap.set("n", M.code_format, function()
    vim.notify("No formatter available for this buffer", vim.log.levels.WARN)
end, { desc = "[c]ode [f]ormat" })

vim.keymap.set("n", M.rename_symbol, function()
    vim.notify("No 'rename symbol' support available for this buffer", vim.log.levels.WARN)
end, { desc = "[r]rename symbol under the cursor" })

--------------------------------------------------------------------------------

-- Make arrow keys behave like hjkl in all relevant modes.
-- This is is necessary because I use a custom Colemak keyboard layout.
-- This make the use of hjkl impractical. To avoid remapping several keys
-- to get the navigation right, I have a navigation layer (in the keyboard
-- layout managed by Kanata) that has the arrow keys on easy access.
-- By remapping only the arrow keys to hjkl, I can have my navigation and other
-- commands all correct without many remapping on nvim or on my layout.
--
-- Be aware that this will change many keymaps throughout the configuration
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
map_all_modes("<A-Up>", "<A-k>", { remap = true })
map_all_modes("<A-Down>", "<A-j>", { remap = true })
map_all_modes("<A-Left>", "<A-h>", { remap = true })
map_all_modes("<A-Right>", "<A-l>", { remap = true })
-- Disable the home and end keys because I was using them in the insert
-- mode for navigation
map_all_modes("<Home>", "<Nop>", { remap = false })
map_all_modes("<End>", "<Nop>", { remap = false })

----------------------------------------------------------------------------------------------------

-- Explicitly map <C-w> + Shift-Arrows to swap windows
-- This fixes the issue where <C-w> ignores the previous mappings of
-- shift-arrow to shift-keys, preserving the default behavior
vim.keymap.set("n", "<C-w><S-Left>", "<C-w>H", { desc = "Move window Left" })
vim.keymap.set("n", "<C-w><S-Down>", "<C-w>J", { desc = "Move window Down" })
vim.keymap.set("n", "<C-w><S-Up>", "<C-w>K", { desc = "Move window Up" })
vim.keymap.set("n", "<C-w><S-Right>", "<C-w>L", { desc = "Move window Right" })

-- Change active window with Ctrl+Direction
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- Swap the current window with Alt+Direction
vim.keymap.set("n", "<A-h>", "<C-w>H", { desc = "Move window Left" })
vim.keymap.set("n", "<A-j>", "<C-w>J", { desc = "Move window Down" })
vim.keymap.set("n", "<A-k>", "<C-w>K", { desc = "Move window Up" })
vim.keymap.set("n", "<A-l>", "<C-w>L", { desc = "Move window Right" })

----------------------------------------------------------------------------------------------------

-- Spell check
vim.keymap.set("n", "<Leader>st", ":set spell!<CR>", { desc = "[s]pell check [t]oggle" })
vim.keymap.set("n", "<Leader>ss", "z=", { desc = "[s]pelling [s]uggestions" })
vim.keymap.set("n", "<Leader>sg", "zg", { desc = "Add this word to the [s]pelfile as a [g]ood word" })

----------------------------------------------------------------------------------------------------

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove the highlight when leaving search mode" })

----------------------------------------------------------------------------------------------------

vim.keymap.set("n", "<leader><tab>", "<C-^>", { desc = "Toggle between the two most recent buffers" })

----------------------------------------------------------------------------------------------------

vim.keymap.set("n", "x", "\"_x", { desc = "Make \"x\" (delete char) never pollute the clipboard" })

----------------------------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[w]rite file" })

----------------------------------------------------------------------------------------------------

-- Go to next confusing character.
-- Confusing characters are characters that are not used in programming, but
-- are similar to often used ones. This list is also defined in the general
-- config for highlighting
vim.keymap.set("n", "<leader>nc", function()
    local pattern = "[“”‘’–—\u{00A0};\u{200b}\u{200c}\u{200d}−]"

    -- We use pcall to suppress the ugly "E486: Pattern not found"
    -- red error message if the file is clean.
    -- "\r" acts as the Enter key.
    -- Wrap inside function() ... end
    local found, _ = pcall(function()
        vim.cmd("normal! /" .. pattern .. "\r")
    end)

    if not found then
        vim.notify("No confusing characters found.", vim.log.levels.INFO)
    end
end, { desc = "Jump to [n]ext [c]onfusing char" })

----------------------------------------------------------------------------------------------------

return M
