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
        attach_mappings = function(prompt_bufnr, _)
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

-- =============================================================================
-- DATE HELPERS (shared by templates and daily commands)
-- =============================================================================

-- Portuguese month name to number mapping
local month_map = {
    janeiro = 1,
    fevereiro = 2,
    ["março"] = 3,
    abril = 4,
    maio = 5,
    junho = 6,
    julho = 7,
    agosto = 8,
    setembro = 9,
    outubro = 10,
    novembro = 11,
    dezembro = 12,
}

-- Portuguese month names
local month_names = {
    "janeiro", "fevereiro", "março", "abril", "maio", "junho",
    "julho", "agosto", "setembro", "outubro", "novembro", "dezembro",
}

-- Portuguese weekday names
local weekday_names = {
    "domingo", "segunda-feira", "terça-feira", "quarta-feira",
    "quinta-feira", "sexta-feira", "sábado",
}

--- Derive a date from the current buffer filename or a provided filename.
-- Expects format: "YYYY <month> DD" (Portuguese month names)
-- @param filename string|nil Optional filename (without extension). Defaults to current buffer name.
-- @return integer os.time() value
local function get_date_from_filename(filename)
    local base = filename or vim.fn.expand("%:t:r")
    local year, month_str, day = base:match("^(%d%d%d%d)%s+(%a+)%s+(%d+)")

    if not (year and month_str and day) then
        -- Fallback to today if parsing fails
        return os.time()
    end

    local month = month_map[month_str:lower()]
    if not month then
        error("Invalid month on file name: " .. month_str)
    end

    return os.time({ year = tonumber(year), month = month, day = tonumber(day) })
end

--- Get date components for a day offset relative to filename-derived date (or today).
-- @param offset integer Day offset (default 0)
-- @return table os.date("*t") components
local function get_date_components(offset)
    offset = offset or 0
    local base_time = get_date_from_filename()
    local target_time = base_time + (offset * 86400)
    return os.date("*t", target_time)
end

--- Format a date with support for tokens {MONTH} and {WEEKDAY} (Portuguese).
-- @param offset integer Day offset
-- @param fmt string os.date format with optional tokens
-- @return string formatted date
local function format_date(offset, fmt)
    local comp = get_date_components(offset or 0)
    local time = os.time(comp)

    if fmt:find("{MONTH}") then
        fmt = fmt:gsub("{MONTH}", month_names[comp.month])
    end

    if fmt:find("{WEEKDAY}") then
        fmt = fmt:gsub("{WEEKDAY}", weekday_names[comp.wday])
    end

    return os.date(fmt, time)
end

--- Format a daily note filename-as-title string: "YYYY <mês> DD, <weekday>"
-- @param offset integer Day offset
-- @return string daily title
local function format_daily_date_string(offset)
    local comp = get_date_components(offset or 0)
    return string.format("%04d %s %02d, %s",
        comp.year, month_names[comp.month], comp.day, weekday_names[comp.wday]
    )
end

local M = {}

M.is_obsidian_vault = is_obsidian_vault
M.find_files_with_aliases = find_files_with_aliases
M.format_daily_date_string = format_daily_date_string
-- These bellow are used in the template files
M.format_date = format_date
M.get_date_components = get_date_components

return M
