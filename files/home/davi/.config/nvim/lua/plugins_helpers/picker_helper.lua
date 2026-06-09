-- Smart definition function that switches between definitions and references
-- based on whether cursor is already at the definition
local function smart_definition()
    -- mini.extra's LSP picker
    local lsp_picker = require('mini.extra').pickers.lsp

    -- This checks if the cursor is currently sitting on the definition.
    -- If YES: Open References.
    -- If NO:  Go to Definition.
    vim.lsp.buf_request(0, "textDocument/definition", vim.lsp.util.make_position_params(0, "utf-16"),
        function(err, result, _, _)
            -- If no definition found, just try to open definitions (will show "not found")
            if err or not result or vim.tbl_isempty(result) then
                lsp_picker('definition')
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

M.smart_definition = smart_definition

return M
