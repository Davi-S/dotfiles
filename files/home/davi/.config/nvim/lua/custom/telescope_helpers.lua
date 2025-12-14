-- Smart definition function that switches between definitions and references
-- based on whether cursor is already at the definition
local function smart_definition()
    local builtin = require("telescope.builtin")

    -- This checks if the cursor is currently sitting on the definition.
    -- If YES: Open References.
    -- If NO:  Go to Definition.
    vim.lsp.buf_request(0, "textDocument/definition", vim.lsp.util.make_position_params(0, "utf-16"),
        function(err, result, _, _)
            -- If no definition found, just try to open definitions (will show "not found")
            if err or not result or vim.tbl_isempty(result) then
                builtin.lsp_definitions()
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
                builtin.lsp_references()
            else
                builtin.lsp_definitions()
            end
        end)
end

-- Check if the current working directory is an Obsidian vault
local function is_obsidian_vault()
    local cwd = vim.fn.getcwd()

    -- Check current directory and parent directories for .obsidian folder
    local current = cwd
    for _ = 1, 10 do -- Check up to 10 levels up
        if vim.fn.isdirectory(current .. "/.obsidian") == 1 then
            return true, current
        end
        local parent = vim.fn.fnamemodify(current, ":h")
        if parent == current then
            break
        end
        current = parent
    end

    return false, nil
end

-- Parse YAML frontmatter and extract aliases
local function extract_aliases(filepath)
    local file = io.open(filepath, "r")
    if not file then
        return {}
    end

    local content = file:read("*all")
    file:close()

    -- Check if file starts with YAML frontmatter
    if not content:match("^%-%-%-%s*\n") then
        return {}
    end

    -- Extract frontmatter (between first --- and second ---)
    local frontmatter = content:match("^%-%-%-%s*\n(.-)%-%-%-%s*\n")
    if not frontmatter then
        return {}
    end

    local aliases = {}

    -- Match list style:
    -- aliases:
    --   - alias1
    --   - alias2
    local in_aliases = false
    for line in frontmatter:gmatch("[^\n]+") do
        if line:match("^aliases%s*:%s*$") then
            in_aliases = true
        elseif in_aliases then
            if line:match("^%s*%-%s+") then
                local alias = line:match("^%s*%-%s+(.+)$")
                alias = alias:gsub('^["\'](.-)["\'"]$', '%1') -- remove quotes
                alias = alias:match('^%s*(.-)%s*$')           -- trim
                if alias ~= "" then
                    table.insert(aliases, alias)
                end
            elseif not line:match("^%s*$") then
                -- Non-empty line that's not a list item, end of aliases
                break
            end
        end
    end

    return aliases
end

-- Build entries list with files and their aliases
local function build_vault_entries(vault_root)
    -- Find all markdown files in the vault
    local find_cmd = string.format(
        "find %s -type f -name '*.md' 2>/dev/null",
        vim.fn.shellescape(vault_root)
    )

    local handle = io.popen(find_cmd)
    if not handle then
        return nil
    end

    local files = {}
    for filepath in handle:lines() do
        table.insert(files, filepath)
    end
    handle:close()

    -- Build virtual entries: real filename + aliases
    local entries = {}
    for _, filepath in ipairs(files) do
        local relative_path = filepath:sub(#vault_root + 2) -- Remove vault root + /
        local display_name = relative_path

        -- Add entry for the real filename
        table.insert(entries, {
            display = display_name,
            ordinal = display_name,
            path = filepath,
        })

        -- Add entries for each alias
        local aliases = extract_aliases(filepath)
        for _, alias in ipairs(aliases) do
            table.insert(entries, {
                display = alias .. "  " .. display_name,
                ordinal = alias,
                path = filepath,
            })
        end
    end

    return entries
end

-- Create and show Telescope picker with custom entries
local function show_vault_picker(entries)
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    pickers.new({}, {
        prompt_title = "Find Files (with aliases)",
        finder = finders.new_table({
            results = entries,
            entry_maker = function(entry)
                return entry
            end,
        }),
        sorter = conf.generic_sorter({}),
        previewer = conf.file_previewer({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    vim.cmd("edit " .. vim.fn.fnameescape(selection.path))
                end
            end)
            return true
        end,
    }):find()
end

-- Find files with aliases in Obsidian vault
local function find_files_with_aliases()
    local is_vault, vault_root = is_obsidian_vault()
    if not is_vault then
        error("Not in an Obsidian vault")
    end

    local entries = build_vault_entries(vault_root)
    if not entries then
        error("Failed to build vault entries")
    end

    show_vault_picker(entries)
end

local M = {}

M.smart_definition = smart_definition
M.is_obsidian_vault = is_obsidian_vault
M.find_files_with_aliases = find_files_with_aliases

return M
