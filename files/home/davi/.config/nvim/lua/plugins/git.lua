return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				numhl = true,
				word_diff = true,
				on_attach = function(bufnr)
					vim.keymap.set(
						"n",
						"<Leader>gh",
						":Gitsigns preview_hunk<CR>",
						{ buffer = bufnr, desc = "[g]itsigns preview [h]unk in popup" }
					)
					vim.keymap.set(
						"n",
						"<Leader>gr",
						":Gitsigns reset_hunk<CR>",
						{ buffer = bufnr, desc = "[g]itsigns [r]eset hunk" }
					)
					vim.keymap.set(
						"n",
						"<Leader>gn",
						":Gitsigns nav_hunk next<CR>",
						{ buffer = bufnr, desc = "[g]itsigns [n]ext hunk" }
					)
					vim.keymap.set(
						"n",
						"<Leader>gp",
						":Gitsigns nav_hunk prev<CR>",
						{ buffer = bufnr, desc = "[g]itsigns [p]rev hunk" }
					)
				end,
			})
		end,
	},
	{
		"tpope/vim-fugitive",
	},
}
