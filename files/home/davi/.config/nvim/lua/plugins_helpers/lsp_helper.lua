-- About all the lsp features configurations, this is how this config handles them:
-- Vim.lsp.codelens:                Configured here and working.
-- Vim.lsp.completion:              Not configured here. Use a dedicated plugin instead.
-- Vim.lsp.diagnostic:              Not configured here because `vim.diagnostic` is enough. Configure it here for LSPs only if you need finetunning (not usually a thing).
-- Vim.lsp.document_color:          Enabled by default. No need to configure it unless you need finetunning.
-- Vim.lsp.formatting:              Not configured here. conform.nvim formats (see lua/plugins/formatter.lua).
-- Vim.lsp.inlay_hint:              Not used.
-- Vim.lsp.inline_completion:       Not used. I prefer the normal completion instead.
-- Vim.lsp.linked_editing_range:    Configured here, but untested.
-- Vim.lsp.on_type_formatting:      Configured here and working.
-- Vim.lsp.semantic_tokens:         Enabled by default. No need to configure.

local function setup_highlight_under_cursor(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Highlight references under the cursor
    if client:supports_method("textDocument/documentHighlight") then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

        -- Highlight references once the cursor rests (after 'updatetime' ms),
        -- instead of sending a request to the server on every cursor movement
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = args.buf,
            group = highlight_augroup,
            desc = "Highlight references when cursor rests",
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
        })

        -- Clear stale highlights as soon as the cursor moves (no server request)
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = args.buf,
            group = highlight_augroup,
            desc = "Clear reference highlights when cursor moves",
            callback = function()
                vim.lsp.buf.clear_references()
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

        -- Clean up the autocmd when the LSP detaches from buffer
        vim.api.nvim_create_autocmd("LspDetach", {
            buffer = args.buf,
            callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
            end,
        })
    end
end

local function setup_renaming(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/rename") then
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = args.buf, desc = "[r]ename symbol" })
    end
end

-- This will help fixing obvious problems on the code. It shows a list with
-- contextual options on the code
local function setup_code_actions(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/codeAction") then
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "[c]ode [a]ction" })
    end
end

-- Show functions usage and other metrics on the code
-- You may need to edit the lsp config file to enable/configure this
local function setup_codelens(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/codeLens") then
        vim.lsp.codelens.enable(true, { bufnr = args.buf })
    end
end

-- TODO: Still need to test if this linked editing range thing is working
-- This is usually helpful in HTML or other files with open/close tags
local function setup_linked_editing_range(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/linkedEditingRange") then
        vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
    end
end

-- Just like the normal formatting. But instead of formatting the whole file,
-- it will do micro formatting around the cursor when a specific key is pressed.
local function setup_on_type_formatting(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/onTypeFormatting") then
        vim.lsp.on_type_formatting.enable(true, { client_id = client.id })
    end
end

-- Smart definition function that switches between definitions and references
-- based on whether cursor is already at the definition
local function smart_definition()
    -- mini.extra's LSP picker
    local lsp_picker = require("mini.extra").pickers.lsp

    -- This checks if the cursor is currently sitting on the definition.
    -- If YES: Open References.
    -- If NO:  Go to Definition.
    vim.lsp.buf_request(0, "textDocument/definition", vim.lsp.util.make_position_params(0), function(err, result, _, _)
        -- If no definition found, just try to open definitions (will show "not found")
        if err or not result or vim.tbl_isempty(result) then
            lsp_picker("definition")
            return
        end

        -- Ensure 'result' is always a list so we can loop over it
        local definitions = vim.islist(result) and result or { result }

        -- Get current cursor info
        local current_buf = vim.api.nvim_get_current_buf()
        local current_uri = vim.uri_from_bufnr(current_buf)
        local current_row = vim.api.nvim_win_get_cursor(0)[1] - 1

        local cursor_is_at_definition = false

        -- Check every definition returned by the server
        for _, def in ipairs(definitions) do
            local def_uri = def.uri or def.targetUri
            local def_range = def.range or def.targetSelectionRange

            local is_same_file = (def_uri == current_uri)

            if is_same_file then
                local is_same_line = (current_row >= def_range.start.line and current_row <= def_range["end"].line)
                if is_same_line then
                    cursor_is_at_definition = true
                    -- We found a match, no need to check others
                    break
                end
            end
        end

        -- Decide what to open
        if cursor_is_at_definition then
            lsp_picker({ scope = "references" })
        else
            lsp_picker({ scope = "definition" })
        end
    end)
end

local M = {}

M.setup_highlight_under_cursor = setup_highlight_under_cursor
M.setup_renaming = setup_renaming
M.setup_code_actions = setup_code_actions
M.setup_codelens = setup_codelens
M.setup_linked_editing_range = setup_linked_editing_range
M.setup_on_type_formatting = setup_on_type_formatting

M.smart_definition = smart_definition

return M
