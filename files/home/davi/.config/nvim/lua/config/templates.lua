local M = {}

-- =============================================================================
-- HELPERS
-- =============================================================================

local utils = {}

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
    dezembro = 12
}

local month_names = {
    "janeiro", "fevereiro", "março", "abril", "maio", "junho",
    "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"
}

local weekday_names = {
    "domingo", "segunda-feira", "terça-feira", "quarta-feira",
    "quinta-feira", "sexta-feira", "sábado"
}

function utils.get_date_from_filename()
    local filename = vim.fn.expand("%:t:r")
    local year, month_str, day = filename:match("^(%d%d%d%d)%s+(%a+)%s+(%d+)")

    if not (year and month_str and day) then
        -- Return today if parsing fails (fallback)
        return os.time()
    end

    local month = month_map[month_str:lower()]
    if not month then
        error("Invalid month on file name: " .. month_str)
    end

    return os.time({ year = year, month = month, day = day })
end

function utils.get_date_components(offset)
    offset = offset or 0
    local base_time = utils.get_date_from_filename()
    local target_time = base_time + (offset * 86400)
    return os.date("*t", target_time)
end

function utils.format_date(offset, fmt)
    local comp = utils.get_date_components(offset)
    local time = os.time(comp)

    if fmt:find("{MONTH}") then
        fmt = fmt:gsub("{MONTH}", month_names[comp.month])
    end

    if fmt:find("{WEEKDAY}") then
        fmt = fmt:gsub("{WEEKDAY}", weekday_names[comp.wday])
    end

    return os.date(fmt, time)
end

-- =============================================================================
-- TEMPLATE ENGINE
-- =============================================================================

local function evaluate_template_code(code)
    local env = {
        utils = utils,
        os = os,
        string = string,
        table = table,
        math = math,
        print = print,
        pairs = pairs,
        ipairs = ipairs,
        tonumber = tonumber,
        tostring = tostring,
        vim = vim,
    }

    local chunk, err = load("return " .. code, "template_expr", "t", env)
    if chunk then
        local success, result = pcall(chunk)
        if success then return tostring(result) end
    end

    chunk, err = load(code, "template_block", "t", env)
    if not chunk then return "{{SYNTAX_ERROR: " .. err .. "}}" end

    local success, result = pcall(chunk)
    if not success then return "{{RUNTIME_ERROR: " .. result .. "}}" end

    return result and tostring(result) or ""
end

--- Core function to read, process, and insert a template file
local function apply_template_file(filepath)
    if vim.fn.filereadable(filepath) == 0 then
        vim.notify("Template file not found: " .. filepath, vim.log.levels.ERROR)
        return
    end

    local lines = vim.fn.readfile(filepath)
    local content = table.concat(lines, "\n")

    -- Execute the Lua code inside {{ }}
    local processed_content = content:gsub("%{%{([\r\n%w%W]-)%}%}", function(code)
        return evaluate_template_code(code)
    end)

    -- Insert into buffer
    local final_lines = vim.split(processed_content, "\n")
    vim.api.nvim_put(final_lines, "c", true, true)
end

local function create_template_command()
    vim.api.nvim_create_user_command("InsertTemplate", function(args)
        local template_dir = vim.g.template_dir or (vim.fn.stdpath("config") .. "/templates/")

        -- Ensure directory exists
        if vim.fn.isdirectory(template_dir) == 0 then
            vim.fn.mkdir(template_dir, "p")
        end

        -- CASE 1: Argument provided (e.g., :InsertTemplate daily.md)
        if args.args and args.args ~= "" then
            local filename = args.args
            local fullpath = template_dir .. filename

            -- Try exact match, then try adding .md extension
            if vim.fn.filereadable(fullpath) == 0 and vim.fn.filereadable(fullpath .. ".md") == 1 then
                fullpath = fullpath .. ".md"
            end

            apply_template_file(fullpath)
            return
        end

        -- CASE 2: No argument -> Show Picker
        local files = vim.fn.readdir(template_dir)
        if #files == 0 then
            vim.notify("No templates found in " .. template_dir, vim.log.levels.WARN)
            return
        end

        vim.ui.select(files, { prompt = "Select Template:" }, function(selected)
            if not selected then return end
            apply_template_file(template_dir .. selected)
        end)
    end, {
        nargs = "?", -- Allow 0 or 1 argument
        desc = "Pick and insert a template file",
        -- Add autocomplete for files in the template directory
        complete = function(ArgLead, _, _)
            local template_dir = vim.g.template_dir or (vim.fn.stdpath("config") .. "/templates/")
            local files = vim.fn.readdir(template_dir)
            local matches = {}
            -- Filter files that start with the input
            for _, f in ipairs(files) do
                if f:lower():find(ArgLead:lower(), 1, true) == 1 then
                    table.insert(matches, f)
                end
            end
            return matches
        end
    })
end

local function set_keymaps()
    vim.keymap.set("n", "<leader>it", "<cmd>InsertTemplate<CR>", { desc = "[i]nsert [t]emplate" })
end

function M.setup()
    create_template_command()
    set_keymaps()
end

return M
