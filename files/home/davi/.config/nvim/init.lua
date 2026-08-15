-- Keymaps must load before plugins so leader key is registered correctly
require("config.keymaps")

-- General editor options and UI preferences
require("config.options")

-- General autocommands (yank highlight, cursorline, cursor position restoration)
require("config.autocmds")

-- Plugin manager setup (Lazy.nvim)
require("config.lazy")
