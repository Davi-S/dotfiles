local colors = require("catppuccin.palettes").get_palette("mocha")

local pt_months = {
    ["janeiro"] = 1,
    ["fevereiro"] = 2,
    ["março"] = 3,
    ["abril"] = 4,
    ["maio"] = 5,
    ["junho"] = 6,
    ["julho"] = 7,
    ["agosto"] = 8,
    ["setembro"] = 9,
    ["outubro"] = 10,
    ["novembro"] = 11,
    ["dezembro"] = 12
}

---Parses an ISO 8601 date string (YYYY-MM-DD) into a Unix timestamp.
---@param date_str string
---@return integer
local function parse_iso_date(date_str)
    local year, month, day = date_str:match("(%d%d%d%d)%-(%d%d)%-(%d%d)")
    if year and month and day then
        return os.time({
            year = tonumber(year),
            month = tonumber(month),
            day = tonumber(day)
        })
    end
    error(string.format("Invalid ISO date format: '%s'. Expected YYYY-MM-DD", date_str))
end

---Parses the Portuguese filename into a Unix timestamp.
---@param filename string|nil
---@return integer
local function parse_note_date(filename)
    if not filename then error("No filename provided to parse_note_date") end

    local year, month_name, day = filename:match("(%d%d%d%d)%s+(%a+)%s+(%d+)")

    if year and month_name and day then
        local m_idx = pt_months[month_name:lower()]
        if m_idx then
            return os.time({ year = tonumber(year), month = m_idx, day = tonumber(day) })
        end
    end

    error(string.format("File '%s' is not a valid daily note (YYYY MMMM DD)", filename))
end

---Offsets a timestamp by a number of days.
---@param timestamp integer
---@param offset_days integer
---@return integer
local function offset_date(timestamp, offset_days)
    return timestamp + (offset_days * 86400)
end

---Formats a Unix timestamp into a string.
---@param timestamp integer
---@param format string
---@return string
local function format_timestamp(timestamp, format)
    return os.date(format, timestamp)
end

---Helper to get base time from the current note context.
---@param ctx table
---@return integer
local function get_base_time(ctx)
    local stem = (ctx.partial_note and ctx.partial_note.path) and ctx.partial_note.path.stem or nil
    return parse_note_date(stem)
end

---Scans the vault for persons born on the target date.
---@param target_time integer
---@param vault_path string
local function get_birthdays(target_time, vault_path)
    local birthdays = {}
    local target_date = os.date("*t", target_time)

    -- Find all markdown files in the vault
    local scan = vim.fn.globpath(vault_path, "**/*.md", true, true)

    for _, file_path in ipairs(scan) do
        local content = vim.fn.readfile(file_path)
        local meta = { is_person = false, birthday = nil, obito = false, aliases = {} }

        local in_frontmatter = false
        for _, line in ipairs(content) do
            if line:match("^---$") then
                if not in_frontmatter then in_frontmatter = true else break end
            elseif in_frontmatter then
                -- Match tags: - pessoa
                if line:match("^%s*-%s*pessoa") then meta.is_person = true end
                -- Match nascimento: YYYY-MM-DD
                local bday = line:match("^nascimento:%s*(%d%d%d%d%-%d%d%-%d%d)")
                if bday then meta.birthday = bday end
                -- Match óbito property
                if line:match("^óbito:") or line:match("^obito:") then meta.obito = true end
                -- Match aliases (simple list extraction)
                local alias = line:match("^%s*-%s*(.+)")
                if alias and not line:match("tags:") and not line:match("aliases:") then
                    table.insert(meta.aliases, alias)
                end
            end
        end

        if meta.is_person and not meta.obito and meta.birthday then
            local by, bm, bd = meta.birthday:match("(%d%d%d%d)%-(%d%d)%-(%d%d)")
            if tonumber(bm) == target_date.month and tonumber(bd) == target_date.day then
                local age = target_date.year - tonumber(by)
                local age_display = (tonumber(by) == 1) and "?? anos" or string.format("%d anos", age)

                local filename = vim.fn.fnamemodify(file_path, ":t:r")
                -- Use the first alias found or the filename
                local display_name = meta.aliases[1] or filename
                table.insert(birthdays,
                    string.format("E - Hoje é aniversário de %s de [[%s|%s]]", age_display, filename, display_name))
            end
        end
    end
    return birthdays
end

---@param target_time integer
---@param ctx obsidian.TemplateContext
local function get_reminders(target_time, ctx)
    local date_table = os.date("*t", target_time)
    local day, wday = date_table.day, date_table.wday

    -- FIX: parent is a function, not a property
    local vault_path = tostring(ctx.templates_dir:parent())

    local reminders_data = {
        { "Pessoal",      "S1",  "T - Ver nota mensal" },
        { "Pessoal",      "S7",  "T - Lavar roupa" },
        { "Pessoal",      "M1",  "T - Ver nota anual" },
        { "Pessoal",      "M1",  "T - Limpar e organizar meu quarto e setup" },
        { "Pessoal",      "M1",  "T - Tirar fotos do corpo para comparação" },
        { "Pessoal",      "M1",  "T - Acessar emails das contas alternativas" },
        { "Pessoal",      "M15", "T - Limpar e organizar meu quarto e setup" },
        { "Profissional", "M1",  "E - Pagar cartão de crédito" },
        { "Profissional", "M1",  "T - Adicionar informações sobre a carteira de investimentos na nota mensal" },
        { "Profissional", "M1",  "E - Pagar mensalidade da CELU e mandar comprovante para a universidade" },
        { "Profissional", "M13", "T - Lembrar tios de mandar o dinheiro de pagar os lotes" },
        { "Profissional", "M20", "E - Pagar os lotes" },
        { "Profissional", "M27", "E - Pagar cheque do Cândido" },
    }

    local pillars = { Pessoal = {}, Profissional = {}, Social = {} }
    local has_any = false

    -- Standard logic
    for _, r in ipairs(reminders_data) do
        local pillar, cond, text = r[1], r[2], r[3]
        local prefix, val = cond:sub(1, 1), tonumber(cond:sub(2))
        if (prefix == "M" and val == day) or (prefix == "S" and val == wday) then
            table.insert(pillars[pillar], "- [ ] " .. text)
            has_any = true
        end
    end

    -- Add Birthday Logic to Social Pillar
    local bdays = get_birthdays(target_time, vault_path)
    if #bdays > 0 then
        has_any = true
        for _, msg in ipairs(bdays) do
            table.insert(pillars["Social"], "- [ ] " .. msg)
        end
    end

    if not has_any then return "" end

    local output = {}
    local pillar_names = { "Pessoal", "Profissional", "Social" }

    for _, name in ipairs(pillar_names) do
        if #pillars[name] > 0 then
            -- Only add a leading newline if this isn't the very first pillar being added
            local prefix = #output > 0 and "\n### " or "### "
            table.insert(output, prefix .. name)

            for _, task in ipairs(pillars[name]) do
                table.insert(output, task)
            end
        end
    end

    return table.concat(output, "\n")
end

local substitutions = {
    date_today_format_01 = function(ctx)
        return format_timestamp(get_base_time(ctx), "%Y-%m-%d")
    end,

    date_yesterday_format_02 = function(ctx)
        local ts = offset_date(get_base_time(ctx), -1)
        return format_timestamp(ts, "%Y %B %d, %A")
    end,

    date_tomorrow_format_02 = function(ctx)
        local ts = offset_date(get_base_time(ctx), 1)
        return format_timestamp(ts, "%Y %B %d, %A")
    end,

    date_today_format_03 = function(ctx)
        return format_timestamp(get_base_time(ctx), "%Y %B"):lower()
    end,

    date_today_format_04 = function(ctx)
        return format_timestamp(get_base_time(ctx), "%Y")
    end,

    date_today_format_05 = function() return "2024 - 2029" end,

    date_today_format_06 = function() return os.date("%Y-%m-%dT%H:%M") end,

    reminders = function(ctx)
        return get_reminders(get_base_time(ctx), ctx)
    end
}

local function open_relative_daily(offset)
    local daily = require("obsidian.daily")
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r")

    local base_time = parse_note_date(filename)
    local target_time = offset_date(base_time, offset)

    local diff_days = math.floor((target_time - os.time()) / 86400 + 0.5)
    daily.daily(diff_days, {}):open()
end

local function create_user_command_DailyNext()
    vim.api.nvim_create_user_command("DailyNext", function() open_relative_daily(1) end, {})
end

local function create_user_command_DailyPrev()
    vim.api.nvim_create_user_command("DailyPrev", function() open_relative_daily(-1) end, {})
end

---Opens or creates a daily note for a specific timestamp.
---@param timestamp integer
local function open_daily_at(timestamp)
    local daily = require("obsidian.daily")

    -- Calculate the difference in days from 'now' for the plugin API
    local diff_days = math.floor((timestamp - os.time()) / 86400 + 0.5)

    -- Open/Create the note using the internal plugin logic
    daily.daily(diff_days, {}):open()
end

---Creates the user command :DailyAt YYYY-MM-DD
---Prompts for a date if none is provided.
local function create_user_command_DailyAt()
    vim.api.nvim_create_user_command("DailyAt", function(opts)
        -- Helper function to process the date string
        local function process_date(date_str)
            if not date_str or date_str == "" then
                return
            end
            -- Translate string to timestamp and then open
            local timestamp = parse_iso_date(date_str)
            open_daily_at(timestamp)
        end

        if opts.args == "" then
            -- Prompt the user for input if no argument was provided
            vim.ui.input({
                prompt = "Enter date (YYYY-MM-DD): ",
            }, function(input)
                process_date(input)
            end)
        else
            -- Process the argument provided directly in the command
            process_date(opts.args)
        end
    end, { nargs = "?" })
end

local function setup_math_highlight()
    vim.api.nvim_set_hl(0, "ObsidianMath", { fg = colors.maroon })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = "*.md",
        callback = function()
            -- Multiline $$ ... $$
            -- This looks for $$ followed by anything (including newlines) until the next $$
            vim.fn.matchadd("ObsidianMath", [[\$\$\_.\{-}\$\$]])

            -- Inline $ ... $
            -- This looks for $ followed by non-newline characters until the next $
            vim.fn.matchadd("ObsidianMath", [[\$[^$]\{-}\$]])
        end,
    })
end

local function setup_ordered_list_checkbox_highlight()
    vim.api.nvim_set_hl(0, "ObsidianOrderedBracket", { link = "ObsidianCheckbox" })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = "*.md",
        callback = function()
            -- Match brackets [ ] or [x] only if preceded by an ordered list number (e.g., 1. [ ])
            -- Regex breakdown:
            -- \%(\d\+\.\s\+\) matches a digit, a dot, and spaces (non-capturing)
            -- \zs starts the actual highlight at the bracket
            -- \[[^\]]\] matches the brackets and whatever is inside them
            vim.fn.matchadd("ObsidianOrderedBracket", [=[\%(\d\+\.\s\+\)\zs\[[^\]]\]]=])
        end,
    })
end

local function setup_ordered_list_highligh()
    vim.api.nvim_set_hl(0, "markdownOrderedListMarker", { fg = colors.text, bold = true })
end

local M = {}

M.create_user_command_DailyNext = create_user_command_DailyNext
M.create_user_command_DailyPrev = create_user_command_DailyPrev
M.create_user_command_DailyAt = create_user_command_DailyAt
M.setup_math_highlight = setup_math_highlight
M.setup_ordered_list_checkbox_highlight = setup_ordered_list_checkbox_highlight
M.setup_ordered_list_highlight = setup_ordered_list_highligh
M.substitutions = substitutions

return M
