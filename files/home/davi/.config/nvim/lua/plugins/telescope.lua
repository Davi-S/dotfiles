return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("telescope").setup({
			extensions = {
				fzf = {},
			},
		})

		require("telescope").load_extension("fzf")
		vim.keymap.set(
			"n",
			"<leader>ff",
			require("telescope.builtin").find_files,
			{ desc = "Telescope [f]ind [f]iles" }
		)
		vim.keymap.set("n", "<leader>lg", require("telescope.builtin").live_grep, { desc = "Telescope [l]ive [g]rep" })
		vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Telescope [f]ind [b]uffers" })
		vim.keymap.set(
			"n",
			"<leader>fh",
			require("telescope.builtin").help_tags,
			{ desc = "Telescope [f]ind [h]elp tags" }
		)
		vim.keymap.set("n", "<leader>fc", function()
			require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Telescope [f]ind [c]onfig files" })
		vim.keymap.set(
			"n",
			"<leader>fs",
			require("telescope.builtin").lsp_document_symbols,
			{ desc = "Telescope [f]ind document [s]ymbols" }
		)
		vim.keymap.set(
			"n",
			"<leader>fd",
			require("telescope.builtin").lsp_definitions,
			{ desc = "Telescope [f]ind (goto) [d]efinitions" }
		)
		vim.keymap.set(
			"n",
			"<leader>fr",
			require("telescope.builtin").lsp_references,
			{ desc = "Telescope [f]ind (goto) [r]eferences" }
		)
	end,
}
