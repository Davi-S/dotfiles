-- =============================================================================
-- Global Vim Options & UI Configurations
-- =============================================================================

--------------------------------------------------------------------------------
-- Line Settings
--------------------------------------------------------------------------------
vim.opt.number = true -- Show absolute line number for the current line
vim.opt.relativenumber = true -- Show relative line numbers for other lines
vim.opt.wrap = false -- Disable line wrapping; long lines scroll horizontally

--------------------------------------------------------------------------------
-- Scrolling Settings
--------------------------------------------------------------------------------
vim.opt.scrolloff = 9 -- Minimum screen lines to keep above and below cursor
vim.opt.sidescrolloff = 10 -- Minimum screen columns to keep left and right of cursor

--------------------------------------------------------------------------------
-- Spell Checking
--------------------------------------------------------------------------------
vim.opt.spell = true
vim.opt.spelllang = { "en", "pt" }
vim.opt.spelloptions = { "camel" }
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

--------------------------------------------------------------------------------
-- Indentation & Tabs
--------------------------------------------------------------------------------
vim.opt.tabstop = 4 -- Number of spaces a <Tab> in file counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindenting
vim.opt.expandtab = true -- Convert typed tabs to spaces
vim.opt.softtabstop = 4 -- Number of spaces a Tab counts for while editing
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Enable smart auto-indenting for C-like languages

--------------------------------------------------------------------------------
-- Search Settings
--------------------------------------------------------------------------------
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if search contains uppercase letters
vim.opt.inccommand = "nosplit" -- Preview substitution results dynamically in buffer

--------------------------------------------------------------------------------
-- Visual & UI Settings
--------------------------------------------------------------------------------
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the terminal
vim.opt.conceallevel = 0 -- Show concealed text normally unless custom character set
vim.opt.signcolumn = "yes" -- Always show sign column to avoid buffer layout shifting
vim.opt.colorcolumn = "80" -- Highlight column 80 as line-length guide
vim.o.winborder = "single" -- Global border style for floating windows

--------------------------------------------------------------------------------
-- File Handling & History
--------------------------------------------------------------------------------
vim.opt.swapfile = false -- Don't create swapfiles (.swp)
vim.opt.undofile = true -- Maintain persistent undo history on disk across sessions

--------------------------------------------------------------------------------
-- General Behavior
--------------------------------------------------------------------------------
vim.opt.iskeyword:append("-") -- Treat hyphenated words ('foo-bar') as single words for motions
vim.opt.mouse = "a" -- Enable full mouse support in all modes
vim.opt.clipboard = "unnamedplus" -- Sync Neovim yank/paste with system clipboard

--------------------------------------------------------------------------------
-- Split Behavior
--------------------------------------------------------------------------------
vim.opt.splitright = true -- Place new vertical splits to the right
vim.opt.splitbelow = true -- Place new horizontal splits below
