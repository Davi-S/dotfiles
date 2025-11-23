---@brief
---
--- https://github.com/Feel-ix-343/markdown-oxide
---
--- Editor Agnostic PKM: you bring the text editor and we
--- bring the PKM.
---
--- Inspired by and compatible with Obsidian.
---
--- Check the readme to see how to properly setup.

local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
	-- Enable dynamic registration so markdown-oxide can react to files created via its own actions
	workspace = {
		didChangeWatchedFiles = {
			dynamicRegistration = true,
		},
	},
})

---@type vim.lsp.Config
return {
	root_markers = { ".git", ".obsidian", ".moxide.toml" },
	filetypes = { "markdown" },
	cmd = { "markdown-oxide" },
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		-- Create the dynamic 'Daily' command
		vim.api.nvim_buf_create_user_command(bufnr, "Daily", function(args)
			client:exec_cmd({
				command = "jump",
				arguments = { args.args },
			}, { bufnr = bufnr })
		end, { desc = "Open daily note", nargs = "*" })
	end,
}
