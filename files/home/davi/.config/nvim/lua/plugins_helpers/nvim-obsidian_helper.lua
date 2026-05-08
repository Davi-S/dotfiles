local M = {}

-- nvim-obsidian helper placeholders
--
-- This module centralizes custom placeholder logic for:
-- 1) Journal title placeholders (`obsidian.journal.register_placeholder`)
-- 2) Template content placeholders (`obsidian.template_register_placeholder`)
--
-- Contract assumptions:
-- - Uses canonical template context produced by the plugin.
-- - `ctx.note` can be nil in non-note-bound flows.
-- - When `ctx.note` exists, `ctx.note.title` and `ctx.note.path` are guaranteed
--   non-empty strings.
-- - date_* and reminders placeholders are strict note-bound helpers and parse
--   temporal information from `ctx.note.title` according to `ctx.note.kind`.
-- - Locale and vault root are read from `ctx.config`.

local reminders_data = {
    { "Pessoal",      "S1",  "T - Ver nota mensal" },
    { "Pessoal",      "S7",  "T - Lavar roupa" },
    { "Pessoal",      "M1",  "T - Ver nota anual" },
    { "Pessoal",      "M1",  "T - Limpar e organizar meu quarto e setup" },
    { "Pessoal",      "M1",  "T - Tirar fotos do corpo para comparação" },
    { "Pessoal",      "M1",  "T - Acessar emails das contas alternativas" },
    { "Pessoal",      "M15", "T - Limpar e organizar meu quarto e setup" },
    { "Profissional", "M23", "T - Pagar cartao de credito da Rico" },
    { "Profissional", "M1",  "T - Pagar cartao de credito da Nubank" },
    { "Profissional", "M1",  "T - Adicionar informacoes sobre a carteira de investimentos na nota mensal" },
    { "Profissional", "M1",  "T - Pagar mensalidade da CELU e mandar comprovante para a universidade" },
    { "Social",       "S1",  "T - Ver se está tudo certo com os diretores departamentais" },
}

local function escape_lua_pattern(text)
    return (tostring(text or ""):gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
end

-- Weekly/monthly reminder rules:
-- - S<n>: fires on weekday number from `os.date("*t").wday` (1=Sunday ... 7=Saturday)
-- - M<n>: fires on day-of-month

local function parse_daily_title_timestamp(ctx)
    local note = ctx.note
    if type(note) ~= "table" then
        error("reminders/date_* placeholders require note-bound template context")
    end

    local title = tostring(note.title or "")
    local kind = tostring(note.kind or "note")
    local locale = type(ctx.config) == "table" and ctx.config.locale or nil

    local function make_ts(year, month, day)
        local y = tonumber(year)
        local m = tonumber(month) or 1
        local d = tonumber(day) or 1
        if not y then
            return nil
        end
        return os.time({ year = y, month = m, day = d, hour = 12 })
    end

    local function parse_month_token(token)
        local numeric = tonumber(tostring(token or ""))
        if numeric and numeric >= 1 and numeric <= 12 then
            return numeric
        end

        local ok, obsidian = pcall(require, "nvim_obsidian")
        if ok and type(obsidian) == "table" and type(obsidian.journal) == "table"
            and type(obsidian.journal.parse_month_token) == "function" then
            return obsidian.journal.parse_month_token(token, locale)
        end

        return nil
    end

    local function iso_week_start_ts(iso_year, iso_week)
        local year_num = tonumber(iso_year)
        local week_num = tonumber(iso_week)
        if not year_num or not week_num then
            return nil
        end

        local jan4 = os.time({ year = year_num, month = 1, day = 4, hour = 12 })
        local jan4_iso_wday = tonumber(os.date("%u", jan4)) or 1
        local week1_monday = jan4 - ((jan4_iso_wday - 1) * 86400)
        return week1_monday + ((week_num - 1) * 7 * 86400)
    end

    local function parse_with_title_format(kind_name, value)
        local journal_cfg = type(ctx.config) == "table" and type(ctx.config.journal) == "table"
            and ctx.config.journal[kind_name] or nil
        local format = type(journal_cfg) == "table" and journal_cfg.title_format or nil
        if type(format) ~= "string" or format == "" then
            return nil
        end

        local token_patterns = {
            year = "(%d%d%d%d)",
            iso_year = "(%d%d%d%d)",
            month = "(%d%d?)",
            day = "(%d%d?)",
            day2 = "(%d%d?)",
            iso_week = "(%d%d?)",
            iso_week_unpadded = "(%d%d?)",
            iso_weekday = "(%d)",
            month_name = "(.-)",
            weekday_name = "(.-)",
        }

        local captures = {}
        local cursor = 1
        local pattern_parts = { "^" }

        while true do
            local s, e, token = format:find("{{([%a_][%w_]*)}}", cursor)
            if not s then
                table.insert(pattern_parts, escape_lua_pattern(format:sub(cursor)))
                break
            end

            table.insert(pattern_parts, escape_lua_pattern(format:sub(cursor, s - 1)))
            table.insert(pattern_parts, token_patterns[token] or "(.-)")
            table.insert(captures, token)
            cursor = e + 1
        end

        table.insert(pattern_parts, "$")
        local compiled_pattern = table.concat(pattern_parts)
        local values = { value:match(compiled_pattern) }
        if #values == 0 then
            return nil
        end

        local fields = {}
        for idx, token in ipairs(captures) do
            fields[token] = values[idx]
        end

        local year = tonumber(fields.year or fields.iso_year)
        local month = tonumber(fields.month)
        if not month and fields.month_name then
            month = parse_month_token(fields.month_name)
        end
        local day = tonumber(fields.day or fields.day2)
        local iso_week = tonumber(fields.iso_week or fields.iso_week_unpadded)
        local iso_weekday = tonumber(fields.iso_weekday)

        if kind_name == "weekly" then
            local week_start = iso_week_start_ts(fields.iso_year or fields.year, iso_week)
            if not week_start then
                return nil
            end
            if iso_weekday and iso_weekday >= 1 and iso_weekday <= 7 then
                return week_start + ((iso_weekday - 1) * 86400)
            end
            return week_start
        end

        if not year then
            return nil
        end

        if kind_name == "yearly" then
            return make_ts(year, 1, 1)
        end

        if kind_name == "monthly" then
            return make_ts(year, month or 1, 1)
        end

        if kind_name == "daily" then
            return make_ts(year, month or 1, day or 1)
        end

        -- Generic fallback for non-journal note kinds.
        return make_ts(year, month or 1, day or 1)
    end

    local function parse_daily_from_title(value)
        local y, m, d = value:match("^(%d%d%d%d)%-(%d%d?)%-(%d%d?)$")
        if y and m and d then
            return make_ts(y, m, d)
        end

        y, m, d = value:match("^(%d%d%d%d)/(%d%d?)/(%d%d?)$")
        if y and m and d then
            return make_ts(y, m, d)
        end

        local year, month_token, day = value:match("^(%d%d%d%d)%s+([^%s,]+)%s+(%d%d?)")
        if year and month_token and day then
            local month = parse_month_token(month_token)
            if month then
                return make_ts(year, month, day)
            end
        end

        return nil
    end

    local function parse_monthly_from_title(value)
        local y, m = value:match("^(%d%d%d%d)%-(%d%d?)$")
        if y and m then
            return make_ts(y, m, 1)
        end

        y, m = value:match("^(%d%d%d%d)/(%d%d?)$")
        if y and m then
            return make_ts(y, m, 1)
        end

        local year, month_token = value:match("^(%d%d%d%d)%s+([^%s,]+)$")
        if year and month_token then
            local month = parse_month_token(month_token)
            if month then
                return make_ts(year, month, 1)
            end
        end

        return nil
    end

    local function parse_weekly_from_title(value)
        local iso_year, iso_week = value:match("^(%d%d%d%d)[%- ]W(%d%d?)$")
        if not (iso_year and iso_week) then
            iso_year, iso_week = value:match("^(%d%d%d%d)%-?(%d%d?)$")
        end
        if not (iso_year and iso_week) then
            return nil
        end

        local year_num = tonumber(iso_year)
        local week_num = tonumber(iso_week)
        if not year_num or not week_num then
            return nil
        end

        local jan4 = os.time({ year = year_num, month = 1, day = 4, hour = 12 })
        local jan4_iso_wday = tonumber(os.date("%u", jan4)) or 1
        local week1_monday = jan4 - ((jan4_iso_wday - 1) * 86400)
        return week1_monday + ((week_num - 1) * 7 * 86400)
    end

    local ts = nil
    ts = parse_with_title_format(kind, title)

    if ts then
        return ts
    end

    if kind == "daily" then
        ts = parse_daily_from_title(title)
    elseif kind == "monthly" then
        ts = parse_monthly_from_title(title)
    elseif kind == "yearly" then
        local y = title:match("^(%d%d%d%d)$") or title:match("(%d%d%d%d)")
        ts = make_ts(y, 1, 1)
    elseif kind == "weekly" then
        ts = parse_weekly_from_title(title)
    else
        -- Fallback for non-journal notes: try full date first, then month/year, then year.
        ts = parse_daily_from_title(title) or parse_monthly_from_title(title)
        if not ts then
            local y = title:match("(%d%d%d%d)")
            ts = make_ts(y, 1, 1)
        end
    end

    if not ts then
        error("could not derive note timestamp from title for note kind '" .. kind .. "': " .. title)
    end

    return ts
end

-- Render a journal title format for an arbitrary timestamp and inject
-- `{{iso_week_unpadded}}` because the upstream formatter only exposes padded week.
local function render_journal_title(format, ts, locale, journal)
    local rendered = journal.render_title(format, os.date("*t", ts), locale)
    local iso_week = tonumber(os.date("%V", ts)) or 0
    return tostring(rendered):gsub("{{iso_week_unpadded}}", tostring(iso_week))
end

-- Scan vault markdown files and collect birthday reminders for `target_time`.
-- Reads frontmatter keys: `nascimento`, optional `obito`/`óbito`, and aliases list.
local function get_birthdays(target_time, vault_path)
    local birthdays = {}
    local target_date = os.date("*t", target_time)
    local scan = vim.fn.globpath(vault_path, "**/*.md", true, true)

    for _, file_path in ipairs(scan) do
        local content = vim.fn.readfile(file_path)
        local meta = { is_person = false, birthday = nil, obito = false, aliases = {} }

        local in_frontmatter = false
        for _, line in ipairs(content) do
            if line:match("^---$") then
                if not in_frontmatter then
                    in_frontmatter = true
                else
                    break
                end
            elseif in_frontmatter then
                if line:match("^%s*-%s*pessoa") then
                    meta.is_person = true
                end
                local bday = line:match("^nascimento:%s*(%d%d%d%d%-%d%d%-%d%d)")
                if bday then
                    meta.birthday = bday
                end
                if line:match("^obito:") or line:match("^óbito:") then
                    meta.obito = true
                end
                local alias = line:match("^%s*-%s*(.+)")
                if alias and (not line:match("tags:")) and (not line:match("aliases:")) then
                    table.insert(meta.aliases, alias)
                end
            end
        end

        if meta.is_person and (not meta.obito) and meta.birthday then
            local birthday = tostring(meta.birthday)
            local by, bm, bd = birthday:match("(%d%d%d%d)%-(%d%d)%-(%d%d)")
            if tonumber(bm) == target_date.month and tonumber(bd) == target_date.day then
                local age = target_date.year - tonumber(by)
                local age_display = (tonumber(by) == 1) and "?? anos" or string.format("%d anos", age)
                local filename = vim.fn.fnamemodify(file_path, ":t:r")
                local display_name = meta.aliases[1] or filename
                table.insert(
                    birthdays,
                    string.format("E - Hoje e aniversario de %s de [[%s|%s]]", age_display, filename, display_name)
                )
            end
        end
    end

    return birthdays
end

-- Build grouped reminder markdown for the current note date.
-- Output format:
-- ### Pessoal
-- - [ ] ...
-- ### Profissional
-- - [ ] ...
local function get_reminders(ctx, journal)
    local target_time = parse_daily_title_timestamp(ctx)
    local date_table = os.date("*t", target_time)
    local day = date_table.day
    local wday = date_table.wday
    local pillars = { Pessoal = {}, Profissional = {}, Social = {} }
    local has_any = false

    for _, r in ipairs(reminders_data) do
        local pillar = r[1]
        local cond = r[2]
        local text = r[3]
        local prefix = cond:sub(1, 1)
        local val = tonumber(cond:sub(2))
        if (prefix == "M" and val == day) or (prefix == "S" and val == wday) then
            table.insert(pillars[pillar], "- [ ] " .. text)
            has_any = true
        end
    end

    local bdays = get_birthdays(target_time, ctx.config.vault_root)
    if #bdays > 0 then
        has_any = true
        for _, msg in ipairs(bdays) do
            table.insert(pillars.Social, "- [ ] " .. msg)
        end
    end

    if not has_any then
        return ""
    end

    local output = {}
    local pillar_names = { "Pessoal", "Profissional", "Social" }

    for _, name in ipairs(pillar_names) do
        if #pillars[name] > 0 then
            local prefix = #output > 0 and "\n### " or "### "
            table.insert(output, prefix .. name .. "\n")
            for _, task in ipairs(pillars[name]) do
                table.insert(output, task)
            end
        end
    end

    return table.concat(output, "\n")
end

---Shift a note-bound timestamp by whole months while preserving the day at 1.
---@param ctx table
---@param month_offset integer
---@return integer
local function shifted_month_timestamp(ctx, month_offset)
    local note = ctx.note
    if type(note) ~= "table" then
        error("monthly placeholders require note-bound template context")
    end

    local title = tostring(note.title or "")
    local kind = tostring(note.kind or "monthly")
    local base_ts = parse_daily_title_timestamp(ctx)
    local base_date = os.date("*t", base_ts)

    local year = base_date.year
    local month = base_date.month + tonumber(month_offset or 0)
    while month > 12 do
        month = month - 12
        year = year + 1
    end
    while month < 1 do
        month = month + 12
        year = year - 1
    end

    local ts = os.time({ year = year, month = month, day = 1, hour = 12 })
    if not ts then
        error("failed to derive monthly timestamp for note kind '" .. kind .. "': " .. title)
    end

    return ts
end

---Render a monthly title using the configured journal locale.
---@param ctx table
---@param month_offset integer
---@return string
local function render_month_title(ctx, month_offset)
    local journal = require("nvim_obsidian").journal
    local ts = shifted_month_timestamp(ctx, month_offset)
    local locale = type(ctx.config) == "table" and ctx.config.locale or "en-US"
    return render_journal_title("{{year}} {{month_name}}", ts, locale, journal)
end

---Return the next-month end date as YYYY-MM-DD.
---@param ctx table
---@return string
local function next_month_end_iso(ctx)
    local ts = shifted_month_timestamp(ctx, 1)
    local next_month = os.date("*t", ts)
    local year = next_month.year
    local month = next_month.month + 1
    if month > 12 then
        month = month - 12
        year = year + 1
    end
    local end_ts = os.time({ year = year, month = month, day = 0, hour = 12 })
    return os.date("%Y-%m-%d", end_ts)
end

-- Journal placeholders are used by `journal.*.title_format` in plugin setup.
-- `regex_fragment` arguments let the plugin parse values back from generated titles.
function M.register_journal_placeholders(obsidian)
    local journal = obsidian.journal

    obsidian.journal.register_placeholder("year", function(ctx)
        return tostring(ctx.date.year)
    end, "(%d%d%d%d)")

    obsidian.journal.register_placeholder("iso_year", function(ctx)
        local d = ctx.date
        local ts = os.time({ year = d.year, month = d.month, day = d.day, hour = 12 })
        return tostring(tonumber(os.date("%G", ts)) or d.year)
    end, "(%d%d%d%d)")

    obsidian.journal.register_placeholder("month_name", function(ctx)
        local d = ctx.date
        local locale = tostring(ctx.config.locale)
        return journal.month_name(d.month, locale)
    end, "(.+)")

    obsidian.journal.register_placeholder("day2", function(ctx)
        local day = tonumber(ctx.date.day) or 0
        return string.format("%02d", day)
    end, "(%d%d?)")

    obsidian.journal.register_placeholder("weekday_name", function(ctx)
        local d = ctx.date
        local locale = tostring(ctx.config.locale)
        local wday = tonumber(d.wday) or 1
        return journal.weekday_name(wday, locale)
    end, "(.+)")

    obsidian.journal.register_placeholder("iso_week", function(ctx)
        local d = ctx.date
        local ts = os.time({ year = d.year, month = d.month, day = d.day, hour = 12 })
        return tostring(tonumber(os.date("%V", ts)) or 0)
    end, "(%d%d?)")

    obsidian.journal.register_placeholder("iso_week_unpadded", function(ctx)
        local d = ctx.date
        local ts = os.time({ year = d.year, month = d.month, day = d.day, hour = 12 })
        return tostring(tonumber(os.date("%V", ts)) or 0)
    end, "(%d%d?)")
end

-- Template placeholders are used inside note templates (e.g. `{{date}}`, `{{reminders}}`).
-- Keep names stable because template files depend on these identifiers.
function M.register_template_placeholders(obsidian)
    local journal = obsidian.journal

    -- `ctx.note` is nullable by contract in non-note-bound flows.
    obsidian.template_register_placeholder("title", function(ctx)
        if type(ctx.note) == "table" then
            return ctx.note.title
        end
        return ""
    end)

    obsidian.template_register_placeholder("date", function(ctx)
        return ctx.time.format_local("%Y-%m-%d")
    end)

    obsidian.template_register_placeholder("weekday", function(ctx)
        return ctx.time.format_local("%A")
    end)

    obsidian.template_register_placeholder("date_today_format_01", function(ctx)
        local ts = parse_daily_title_timestamp(ctx)
        return os.date("%Y-%m-%d", ts)
    end)

    obsidian.template_register_placeholder("date_yesterday_format_02", function(ctx)
        local locale = ctx.config.locale
        local ts = parse_daily_title_timestamp(ctx) - 86400
        return render_journal_title("{{year}} {{month_name}} {{day2}}, {{weekday_name}}", ts, locale, journal)
    end)

    obsidian.template_register_placeholder("date_tomorrow_format_02", function(ctx)
        local locale = ctx.config.locale
        local ts = parse_daily_title_timestamp(ctx) + 86400
        return render_journal_title("{{year}} {{month_name}} {{day2}}, {{weekday_name}}", ts, locale, journal)
    end)

    obsidian.template_register_placeholder("date_today_format_03", function(ctx)
        local locale = tostring(ctx.config.locale)
        local ts = parse_daily_title_timestamp(ctx)
        return render_journal_title("{{year}} {{month_name}}", ts, locale, journal)
    end)

    obsidian.template_register_placeholder("date_today_format_04", function(ctx)
        local locale = tostring(ctx.config.locale)
        local ts = parse_daily_title_timestamp(ctx)
        return render_journal_title("{{year}}", ts, locale, journal)
    end)

    obsidian.template_register_placeholder("date_today_format_05", function()
        return "2024 - 2029"
    end)

    obsidian.template_register_placeholder("date_today_format_06", function(ctx)
        return ctx.time.format_local("%Y-%m-%dT%H:%M")
    end)

    obsidian.template_register_placeholder("date_format_06", function(ctx)
        return ctx.time.format_local("%Y-%m-%dT%H:%M")
    end)

    obsidian.template_register_placeholder("date_today_format_07", function(ctx)
        local ts = parse_daily_title_timestamp(ctx)
        return os.date("%Y-%m-%d", ts)
    end)

    obsidian.template_register_placeholder("date_next_week_format_07", function(ctx)
        local ts = parse_daily_title_timestamp(ctx) + (7 * 86400)
        return os.date("%Y-%m-%d", ts)
    end)

    obsidian.template_register_placeholder("reminders", function(ctx)
        return get_reminders(ctx, journal)
    end)

    -- Monthly template helpers keep the monthly note format declarative in the
    -- vault template file while still using the same plugin placeholder system.
    obsidian.template_register_placeholder("date_prev_month_format_02", function(ctx)
        return render_month_title(ctx, -1)
    end)

    obsidian.template_register_placeholder("date_next_month_format_02", function(ctx)
        return render_month_title(ctx, 1)
    end)

    obsidian.template_register_placeholder("date_next_month_end_format_07", function(ctx)
        return next_month_end_iso(ctx)
    end)

    obsidian.template_register_placeholder("date_today_format_04", function(ctx)
        local ts = parse_daily_title_timestamp(ctx)
        return os.date("%Y", ts)
    end)

    obsidian.template_register_placeholder("date_today_format_05", function()
        return "2024 - 2029"
    end)

    obsidian.template_register_placeholder("date_today_format_06", function(ctx)
        local ts = parse_daily_title_timestamp(ctx)
        return os.date("%m", ts)
    end)

    obsidian.template_register_placeholder("date_next_month_format_06", function(ctx)
        local ts = shifted_month_timestamp(ctx, 1)
        return os.date("%m", ts)
    end)
end

return M
