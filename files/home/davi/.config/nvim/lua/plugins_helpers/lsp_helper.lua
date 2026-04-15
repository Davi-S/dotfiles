-- About all the lsp features configurations, this is how this config handles them:
-- Vim.lsp.codelens:                Configured here and working.
-- Vim.lsp.completion:              Not configured here. Use a dedicated plugin instead.
-- Vim.lsp.diagnostic:              Not configured here because `vim.diagnostic` is enough. Configure it here for LSPs only if you need finetunning (not usually a thing).
-- Vim.lsp.document_color:          Enabled by default. No need to configure it unless you need finetunning.
-- Vim.lsp.inlay_hint:              Configured here and working.
-- Vim.lsp.inline_completion:       Configured here, but untested. I probably wont use as I prefer the normal completion instead.
-- Vim.lsp.linked_editing_range:    Configured here, but untested.
-- Vim.lsp.on_type_formatting:      Configured here and working.
-- Vim.lsp.semantic_tokens:         Enabled by default. No need to configure.

-- Get the default keymap for formatting
local keymaps = require("config.keymaps")
local FORMAT_KEY = keymaps.code_format
local RENAME_KEY = keymaps.rename_symbol

-- Auto format the file.
-- You may need to edit the lsp config file to enable/configure this
local function setup_formatting(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Keymap for formatting the file
    if client:supports_method("textDocument/formatting") then
        vim.keymap.set("n", FORMAT_KEY, function()
            vim.lsp.buf.format({ async = true, bufnr = args.buf })
        end, { buffer = args.buf, desc = "LSP [c]ode [f]ormat" })
    end

    -- Format for markdown
    -- Override the keybind for Markdown to use other formatter, since it the
    -- one I usually use (markdown-oxide) does not supports "textDocument/formatting"
    if vim.bo[args.buf].filetype == "markdown" then
        -- Define a custom format function that uses Prettier for
        -- markdown formatting
        vim.keymap.set("n", FORMAT_KEY, function()
            local filepath = vim.api.nvim_buf_get_name(args.buf)
            -- Construct command: prettier --stdin-filepath <path>
            -- We use stdin so it works even if you haven't saved the file yet
            local cmd = "prettier --stdin-filepath " .. vim.fn.shellescape(filepath)

            -- Get current buffer content
            local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
            local input = table.concat(lines, "\n")

            -- Run Prettier
            local output = vim.fn.system(cmd, input)

            -- Check for success (0 = success)
            if vim.v.shell_error == 0 then
                -- Split output into lines and replace buffer content
                local new_lines = vim.split(output, "\n")
                vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, new_lines)
            else
                vim.notify("Prettier Error:\n" .. output, vim.log.levels.ERROR)
            end
        end, { buffer = args.buf, desc = "LSP [c]ode [f]ormat" })
    end
end

local function setup_highlight_under_cursor(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

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
-- This is a function to create a pretty floating window bellow the cursor.
-- It will receive a input and call the given function with that input.
local function _wininput(default_text, on_confirm)
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

local function setup_renaming(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Basically renames the symbol that is under the cursor to have the new given name
    if client:supports_method('textDocument/rename') then
        vim.keymap.set("n", RENAME_KEY,
            function()
                local curr_name = vim.fn.expand("<cword>")
                -- This function will open a pretty floating window where the user can
                -- type the new name it wants and the rename function will be called
                -- with this input.
                _wininput(
                    curr_name,
                    function(input)
                        if input and #input > 0 and input ~= curr_name then
                            -- "rename" receives the new name. It acts upon the symbol
                            -- That is under the cursor
                            vim.lsp.buf.rename(input)
                        end
                    end
                )
            end,
            { desc = "LSP [r]ename" })
    end
end

-- This will help fixing obvious problems on the code. It shows a list with
-- contextual options on the code
local function setup_code_actions(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method('textDocument/codeAction') then
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
            { desc = "LSP [c]ode [a]ction" })
    end
end

-- Show functions usage and other metrics on the code
-- You may need to edit the lsp config file to enable/configure this
local function setup_codelens(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method 'textDocument/codeLens' then
        vim.lsp.codelens.enable(true, { bufnr = args.bufnr })
    end
end

-- TODO: Still need to test if this linked editing range thing is working
-- This is usually helpful in HTML or other files with open/close tags
local function setup_linked_editing_range(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method 'textDocument/linkedEditingRange' then
        vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
    end
end

-- Show the type of the parameters of the functions and other hints
-- You may need to edit the lsp config file to enable/configure this
local function setup_inlay_hint(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method 'textDocument/inlayHint' then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.bufnr })
    end
end

-- TODO: Still need to test if this inline completion thing is working
-- This is like vim.lsp.completion, but shows only one option which can be
-- accepted of denied. It is like copilot suggestions, while vim.lsp.completion
-- Is a table of options.
local function setup_inline_completion(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method 'textDocument/inlineCompletion' then
        vim.lsp.inline_completion.enable(true, { bufnr = args.bufnr })
    end
end

-- Just like the normal formatting. But instead of formatting the whole file,
-- it will do micro formatting around the cursor when a specific key is pressed.
local function setup_on_type_formatting(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method 'textDocument/onTypeFormatting' then
        vim.lsp.on_type_formatting.enable(true, { bufnr = args.bufnr })
    end
end

local M = {}

M.setup_formatting = setup_formatting
M.setup_highlight_under_cursor = setup_highlight_under_cursor
M.setup_renaming = setup_renaming
M.setup_code_actions = setup_code_actions
M.setup_codelens = setup_codelens
M.setup_linked_editing_range = setup_linked_editing_range
M.setup_inlay_hint = setup_inlay_hint
M.setup_inline_completion = setup_inline_completion
M.setup_on_type_formatting = setup_on_type_formatting

return M
