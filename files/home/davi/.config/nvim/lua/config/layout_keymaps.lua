-- =============================================================================
-- Navigation & Window Layout Compatibility (Colemak Layout via Kanata)
-- =============================================================================
-- Custom Colemak keyboard layout (via Kanata) uses an arrow-key navigation layer.
-- Remapping arrow keys to hjkl across all modes avoids remapping dozens of individual
-- Neovim commands, preserving standard hjkl behavior while keeping navigation comfortable.
-- =============================================================================

-- Currently we are mapping the arrows to keys in all modes. This makes <Up> literally
-- type a "k" and <C-Left> to <C-h> will delete a character.
-- This is intentional to prevent abuse of the arrow keys in the nav layer all the time
-- and force me to use the vim navigation instead of relying on my nav layer.

-- However, one may want the translation to only apply to the modes where hjkl are motions:
-- normal (n), visual (x) and operator-pending (o); so that in insert and select mode the
-- arrows keep their native meaning.
local function map_all_modes(lhs, rhs, opts)
    for _, mode in ipairs({ "n", "i", "v", "x", "s", "o" }) do
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

--------------------------------------------------------------------------------
-- Navigation Layer Mapping (Colemak Layout Compatibility)
--------------------------------------------------------------------------------

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
