-- Basic settings
-- show cursorline only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = "active_cursorline",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
vim.opt.number = true         -- show absolute line number for the current line
vim.opt.relativenumber = true -- show relative line numbers for other lines (helps with motions)
vim.opt.wrap = false          -- disable line wrapping; long lines will scroll horizontally
vim.opt.scrolloff = 9         -- minimum screen lines to keep above and below cursor
vim.opt.sidescrolloff = 30    -- minimum screen columns to keep left and right of cursor

-- Indentation
vim.opt.tabstop = 4        -- number of spaces a <Tab> in file counts for
vim.opt.shiftwidth = 4     -- number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true   -- convert typed tabs to spaces
vim.opt.softtabstop = 4    -- number of spaces a Tab counts for while editing
vim.opt.autoindent = true  -- copy indent from current line when starting a new line
vim.opt.smartindent = true -- enable smart auto-indenting for C-like languages

-- Search settings
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true  -- if ignore case in search patterns, be case-sensitive if the search contains uppercase letters

-- Visual settings
vim.cmd.colorscheme("catppuccin")
vim.opt.termguicolors = true  -- enable 24-bit RGB color in the terminal
vim.opt.signcolumn = "yes"    -- always show the sign column to avoid text shifting when signs appear
vim.opt.winborder = "rounded" -- use rounded borders for floating windows
vim.opt.completeopt = {       -- completion behavior for popup menu
	"fuzzy",
	"menuone",
	"noinsert",
	"popup",
}
vim.opt.pumheight = 10 -- maximum items to show in completion popup menu
-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})
-- Highlight symbols/references under cursor
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
	desc = "Highlight references under cursor",
	callback = function()
		-- Only run if the cursor is not in insert mode
		if vim.fn.mode() ~= "i" then
			-- These functions are safe. They will do nothing if no provider is attached or capable.
			vim.lsp.buf.clear_references()
			vim.lsp.buf.document_highlight()
		end
	end,
})
vim.api.nvim_create_autocmd("InsertEnter", {
	group = "LspReferenceHighlight",
	desc = "Clear highlights when in insert mode",
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})
vim.diagnostic.config({
	virtual_text = true, -- show diagnostics as virtual text inline
	severity_sort = true, -- sort diagnostics by severity
})


-- File handling
vim.opt.swapfile = false -- don't create swapfiles for buffers
vim.opt.undofile = true  -- persist undo history to disk
-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- Behaviour settings
vim.opt.iskeyword:append("-")     -- treat words with '-' as single word for motions
vim.opt.mouse = "a"               -- enable mouse support in all modes
vim.opt.clipboard = "unnamedplus" -- use the system clipboard for yank/copy/paste operations

-- Split behaviour
vim.opt.splitright = true -- put new vertical splits to the right
vim.opt.splitbelow = true -- put new horizontal splits below

-- netrw options
vim.g.netrw_liststyle = 3               -- use tree-style listing
vim.g.netrw_banner = 0                  -- disable the netrw banner
vim.g.netrw_browsex_viewer = "xdg-open" -- external program to open files
vim.g.netrw_hide = 0                    -- show hidden files (0 = don't hide dotfiles)
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'  -- Show line numbers
