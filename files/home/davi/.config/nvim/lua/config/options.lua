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
vim.opt.number = true -- show absolute line number for the current line
vim.opt.relativenumber = true -- show relative line numbers for other lines (helps with motions)
vim.opt.wrap = false -- disable line wrapping; long lines will scroll horizontally
vim.opt.scrolloff = 9
vim.opt.sidescrolloff = 30

-- Indentation
vim.opt.tabstop = 4 -- number of spaces a <Tab> in file counts for
vim.opt.shiftwidth = 4 -- number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- convert typed tabs to spaces
vim.opt.softtabstop = 4 -- number of spaces a Tab counts for while editing
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search settings
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- if ignore case in search patterns, be case-sensitive if the search contains uppercase letters

-- Visual settings
vim.opt.termguicolors = true
vim.opt.showmatch = true
vim.opt.signcolumn = "yes" -- always show the sign column to avoid text shifting when signs appear
vim.opt.winborder = "rounded" -- use rounded borders for floating windows
vim.opt.completeopt = {
	"fuzzy",
	"menuone",
	"noinsert",
	"popup",
}
vim.opt.pumheight = 10
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
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local supports_highlight = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					supports_highlight = true
					-- Found a supporting client, no need to check others
					break
				end
			end
			-- Proceed only if an LSP is active AND supports the feature
			if supports_highlight then
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end
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
	virtual_text = true,
	severity_sort = true,
})

-- File handling
vim.opt.swapfile = false
vim.opt.undofile = true
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
vim.opt.iskeyword:append("-")
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus" -- use the system clipboard for yank/copy/paste operations

-- Split behaviour
vim.opt.splitright = true
vim.opt.splitbelow = true

-- netrw options
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browsex_viewer = "xdg-open"
vim.g.netrw_hide = 0
