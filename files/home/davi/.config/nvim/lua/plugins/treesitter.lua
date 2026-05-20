return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.install("all")

		vim.api.nvim_create_autocmd('FileType', {
			callback = function(ev)
				-- Enable treesitter highlighting and disable regex syntax
				-- We use pcall here to avoid errors when opening from some
				-- different types of buffers. For example, when opening Telescope,
				-- it will use a buffer filetype called "TelescopePrompt", which
				-- will raise errors. These errors can be ignored silently
				local ok = pcall(vim.treesitter.start, ev.buf)
				if not ok then
					return
				end

				-- Enable treesitter-based indentation
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
