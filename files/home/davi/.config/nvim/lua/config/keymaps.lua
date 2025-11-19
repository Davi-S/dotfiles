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

-- Set enter to *not* accept the completion. Instead, just enter a new line.
vim.keymap.set('i', '<cr>', function()
    return vim.fn.pumvisible() == 1 and '<c-e><cr>' or '<cr>'
end, { expr = true, noremap = true, desc = "Set enter to *not* accept the completion. Instead, just enter a new line" })


-- ============================================================================
-- NETRW CONFIGURATION
-- ============================================================================
-- Strategy:
-- We distinguish between two modes of opening Netrw:
-- 1. "Drawer Mode" (<leader>ve/he): A temporary side split. Should CLOSE when toggled.
-- 2. "Browser Mode" (<leader>e): Opening in the current window. Should GO BACK when toggled.
--
-- We use a window-local variable `vim.w.is_netrw_drawer` to "tag" the window
-- so we know how to behave when closing it.

-- Helper function: Only open a split if we aren't already in Netrw
local function safe_netrw_split(command)
    if vim.bo.filetype == "netrw" then
        return
    end
    vim.cmd(command)
end

-- Standard Open (Browser Mode)
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open N[e]trw" })

-- Vertical Split (Drawer Mode)
vim.keymap.set("n", "<leader>ve", function()
    safe_netrw_split("Vex")
    vim.w.is_netrw_drawer = true -- Mark this window as a "drawer"
end, { desc = "[v]ertically open N[e]trw" })

-- Horizontal Split (Drawer Mode)
vim.keymap.set("n", "<leader>he", function()
    safe_netrw_split("Hex")
    vim.w.is_netrw_drawer = true -- Mark this window as a "drawer"
end, { desc = "Horizontally open N[e]trw" })

-- NETRW BUFFER KEYMAPS
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    group = vim.api.nvim_create_augroup("NetrwKeymaps", { clear = true }),
    callback = function()
        -- <leader>e (Exit Netrw)
        vim.keymap.set("n", "<leader>e", function()
            if vim.w.is_netrw_drawer then
                vim.cmd("close") -- It's a drawer, so delete the window.
            else
                vim.cmd("Rex")   -- It's a normal window, so go Back.
            end
        end, { buffer = true, desc = "Close N[e]trw or Return to File" })

        -- Enter File/Directory
        vim.keymap.set("n", "<CR>", function()
            -- Capture the drawer state BEFORE the buffer potentially changes
            local is_drawer = vim.w.is_netrw_drawer

            -- Trigger Netrw's internal open logic
            local key = vim.api.nvim_replace_termcodes("<Plug>NetrwLocalBrowseCheck", true, true, true)
            vim.api.nvim_feedkeys(key, "m", false)

            -- Post-action logic (run after Netrw handles the key)
            vim.schedule(function()
                -- If we have moved from Netrw to a real file
                if vim.bo.filetype ~= "netrw" then
                    -- And if this window used to be a drawer
                    if is_drawer then
                        vim.cmd("wincmd =")         -- Expand window to 50/50
                        vim.w.is_netrw_drawer = nil -- Remove the tag (it is now a main window)
                    end
                end
            end)
        end, { buffer = true, desc = "Smart open file/dir" })
    end,
})
