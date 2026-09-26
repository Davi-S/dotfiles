-- Enable Lua byte-compilation cache for faster startup
if vim.loader then
    vim.loader.enable()
end

-- Navigation & Window layout compatibility (untracked in statistics)
require("config.layout_keymaps")

-- Keymap usage tracker & statistics (tracks hits across sessions)
require("config.keymap_tracker").setup()

-- General QoL keymaps & Leader key (tracked)
require("config.keymaps")

-- General editor options and UI preferences
require("config.options")

-- General autocommands (yank highlight, cursorline, cursor position restoration)
require("config.autocmds")

-- LSP setup (independent of Mason; servers are enabled when the first file opens)
require("config.lsp")

-- Plugin manager setup (Lazy.nvim)
require("config.lazy")
