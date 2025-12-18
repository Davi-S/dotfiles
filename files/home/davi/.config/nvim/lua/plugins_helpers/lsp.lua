local function setup_formatting(args, client)
    -- Keymap for formatting the file
    if client:supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
        end, { buffer = args.buf, desc = "[c]ode [f]ormat" })
    end
    -- Format for markdown
    if vim.bo.filetype == "markdown" then
        -- Define a custom format function that uses Prettier for
        -- markdown formatting
        vim.keymap.set("n", "<leader>cf", function()
            local filepath = vim.api.nvim_buf_get_name(0)
            -- Construct command: prettier --stdin-filepath <path>
            -- We use stdin so it works even if you haven't saved the file yet
            local cmd = "prettier --stdin-filepath " .. vim.fn.shellescape(filepath)

            -- Get current buffer content
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            local input = table.concat(lines, "\n")

            -- Run Prettier
            local output = vim.fn.system(cmd, input)

            -- Check for success (0 = success)
            if vim.v.shell_error == 0 then
                -- Split output into lines and replace buffer content
                local new_lines = vim.split(output, "\n")
                vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
                vim.notify("Formatted with Prettier", vim.log.levels.INFO)
            else
                vim.notify("Prettier Error:\n" .. output, vim.log.levels.ERROR)
            end
        end, { buffer = args.buf, desc = "[c]ode [f]ormat" })
    end
end

local function setup_highlight_under_cursor(args, client)
    -- Highlight references under the cursor
    if client:supports_method("textDocument/documentHighlight") then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

        -- Highlight references when cursor moves
        vim.api.nvim_create_autocmd({ "CursorMoved" }, {
            buffer = args.buf,
            group = highlight_augroup,
            desc = "Highlight references when cursor moves",
            callback = function()
                vim.lsp.buf.clear_references()
                vim.lsp.buf.document_highlight()
            end,
        })

        -- Clear references when in insert mode
        vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = args.buf,
            group = highlight_augroup,
            desc = "Clear highlights when in insert mode",
            callback = function()
                vim.lsp.buf.clear_references()
            end,
        })

        -- Clean up the autocommands when the LSP detaches
        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
            end,
        })
    end
end

local M = {}

M.setup_formatting = setup_formatting
M.setup_highlight_under_cursor = setup_highlight_under_cursor

return M
