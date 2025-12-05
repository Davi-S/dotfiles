-- Wrapping behavior
vim.opt_local.wrap = true
vim.opt_local.linebreak = true   -- Wrap at words, not in the middle of words
vim.opt_local.breakindent = true -- Keep indentation for wrapped lines

-- Force start treesitter for better syntax highlight
vim.treesitter.start()
