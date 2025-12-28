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

        -- Clean up the autocmd when the LSP detaches
        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
            end,
        })
    end
end

-- original by tLaw101 on `https://www.reddit.com/r/neovim/comments/ua6826/3_lua_override_vimuiinput_in_40_lines/`
-- This is a function to override the default input. This will set the input of
-- the command to be a pretty floating window.
local function wininput(default_text, on_confirm)
    -- create a "prompt" buffer that will be deleted once focus is lost
    local buf = vim.api.nvim_create_buf(false, false)
    vim.bo[buf].buftype = "prompt"
    vim.bo[buf].bufhidden = "wipe"

    -- defer the on_confirm callback so that it is
    -- executed after the prompt window is closed
    local deferred_callback = function(input)
        vim.defer_fn(function()
            on_confirm(input)
        end, 10)
    end

    -- set callback (CR) for prompt buffer, and the prompt character
    vim.fn.prompt_setcallback(buf, deferred_callback)
    vim.fn.prompt_setprompt(buf, "")

    -- set some keymaps:
    -- Enter to confirm and exit
    vim.keymap.set({ "i", "n" }, "<CR>", "<CR><Esc>:close!<CR>:stopinsert<CR>", {
        silent = true,
        buffer = buf,
    })
    -- ESC to quit
    vim.keymap.set("n", "<esc>", function()
        return vim.fn.mode() == "n" and "ZQ" or "<esc>"
    end, { expr = true, silent = true, buffer = buf })
    -- q to quit
    vim.keymap.set("n", "q", function()
        return vim.fn.mode() == "n" and "ZQ" or "<esc>"
    end, { expr = true, silent = true, buffer = buf })

    -- Get the current line and cursor position
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1

    -- matchstrpos returns { matched_string, start_idx, end_idx }
    local match = vim.fn.matchstrpos(line, [[\k*\%]] .. col .. [[c\k*]])
    local start_col = match[2]
    local end_col = match[3]

    -- If no match found (e.g., on empty space), default to current column
    if start_col == -1 then
        start_col = col - 1
        end_col = col - 1
    end

    -- Calculate relative offset
    -- start_col is 0-indexed from matchstrpos
    local col_offset = start_col - vim.fn.col(".")
    local width_offset = math.max(#default_text, (end_col - start_col)) + 10

    local win_opts = {
        relative = "cursor",
        row = 1,
        col = col_offset,
        width = width_offset,
        height = 1,
        style = "minimal",
        border = "rounded",
    }

    -- open the floating window pointing to our buffer and show the prompt
    vim.api.nvim_open_win(buf, true, win_opts)
    vim.cmd("startinsert")

    -- set the default text
    vim.defer_fn(function()
        vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, { default_text })
        vim.cmd("stopinsert")
        vim.api.nvim_win_set_cursor(0, { 1, 0 })
    end, 5)
end

local function setup_lsp_renaming_keymap(args, client)
    if client:supports_method('textDocument/rename') then
        vim.keymap.set("n", "<leader>r",
            function()
                local curr_name = vim.fn.expand("<cword>")
                wininput(
                    curr_name,
                    function(input)
                        if input and #input > 0 and input ~= curr_name then
                            vim.lsp.buf.rename(input)
                        end
                    end
                )
            end,
            { desc = "LSP [r]ename" })
    end
end

local function setup_code_actions_keymap(args, client)
    if client:supports_method('textDocument/codeAction') then
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
            { desc = "LSP [c]ode [a]ction" })
    end
end

local M = {}

M.setup_formatting = setup_formatting
M.setup_highlight_under_cursor = setup_highlight_under_cursor
M.setup_lsp_renaming_keymap = setup_lsp_renaming_keymap
M.setup_code_actions_keymap = setup_code_actions_keymap

return M
