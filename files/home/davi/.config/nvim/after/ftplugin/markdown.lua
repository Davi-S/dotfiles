-- Wrapping behavior
vim.opt_local.wrap = true
vim.opt_local.linebreak = true   -- Wrap at words, not in the middle of words
vim.opt_local.breakindent = true -- Keep indentation for wrapped lines


-- Force start treesitter for better syntax highlight
vim.treesitter.start()


-- Custom paint the "$" on latex blocks
-- Get the colors from the palette
local delimiter_color = "#b1bad9"
-- Create a custom highlight group specifically for the dollar sign
vim.api.nvim_set_hl(0, "MathDelimiter", { fg = delimiter_color })
-- Apply the match ONLY to the current buffer (so it doesn't affect other files)
-- The pattern '\\$' targets the literal dollar sign.
vim.opt_local.winhighlight = "MathDelimiter:MathDelimiter" -- Safety fallback
vim.fn.matchadd("MathDelimiter", "\\$")

