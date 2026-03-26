local M = {}

local journal_format = require("nvim-obsidian.journal.format")

local reminders_data = {
    { "Pessoal",      "S1",  "T - Ver nota mensal" },
    { "Pessoal",      "S7",  "T - Lavar roupa" },
    { "Pessoal",      "M1",  "T - Ver nota anual" },
    { "Pessoal",      "M1",  "T - Limpar e organizar meu quarto e setup" },
    { "Pessoal",      "M1",  "T - Tirar fotos do corpo para comparação" },
    { "Pessoal",      "M1",  "T - Acessar emails das contas alternativas" },
    { "Pessoal",      "M15", "T - Limpar e organizar meu quarto e setup" },
    { "Profissional", "M1",  "E - Pagar cartao de credito" },
    { "Profissional", "M1",  "T - Adicionar informacoes sobre a carteira de investimentos na nota mensal" },
    { "Profissional", "M1",  "E - Pagar mensalidade da CELU e mandar comprovante para a universidade" },
    { "Profissional", "M27", "E - Pagar cheque do Candido" },
}

local function parse_daily_title_timestamp(ctx)
    local cfg = ctx.config
    local ok, ts = pcall(journal_format.parse_daily_title, ctx.note.title, cfg)
    if ok and ts then
        return ts
    end
    return ctx.time.timestamp
end

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
            local by, bm, bd = meta.birthday:match("(%d%d%d%d)%-(%d%d)%-(%d%d)")
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

local function get_reminders(ctx)
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
            table.insert(output, prefix .. name)
            for _, task in ipairs(pillars[name]) do
                table.insert(output, task)
            end
        end
    end

    return table.concat(output, "\n")
end

function M.register_journal_placeholders(obsidian)
    obsidian.journal.register_placeholder("year", function(ctx)
        return tostring(ctx.date.year)
    end, "(%d%d%d%d)")

    obsidian.journal.register_placeholder("iso_year", function(ctx)
        return tostring(ctx.date.iso_year)
    end, "(%d%d%d%d)")

    obsidian.journal.register_placeholder("month_name", function(ctx)
        return ctx.locale.month_name or ""
    end, "(.+)")

    obsidian.journal.register_placeholder("day2", function(ctx)
        return string.format("%02d", ctx.date.day or 0)
    end, "(%d%d?)")

    obsidian.journal.register_placeholder("weekday_name", function(ctx)
        return ctx.locale.weekday_name or ""
    end, "(.+)")

    obsidian.journal.register_placeholder("iso_week", function(ctx)
        return tostring(ctx.date.iso_week)
    end, "(%d%d?)")
end

function M.register_template_placeholders(obsidian)
    obsidian.template_register_placeholder("title", function(ctx)
        return ctx.note.title
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
        local ts = parse_daily_title_timestamp(ctx) - 86400
        return journal_format.daily_title(ts, ctx.config)
    end)

    obsidian.template_register_placeholder("date_tomorrow_format_02", function(ctx)
        local ts = parse_daily_title_timestamp(ctx) + 86400
        return journal_format.daily_title(ts, ctx.config)
    end)

    obsidian.template_register_placeholder("date_today_format_03", function(ctx)
        local ts = parse_daily_title_timestamp(ctx)
        return journal_format.monthly_title(ts, ctx.config)
    end)

    obsidian.template_register_placeholder("date_today_format_04", function(ctx)
        local ts = parse_daily_title_timestamp(ctx)
        return journal_format.yearly_title(ts, ctx.config)
    end)

    obsidian.template_register_placeholder("date_today_format_05", function()
        return "2024 - 2029"
    end)

    obsidian.template_register_placeholder("date_today_format_06", function()
        return os.date("%Y-%m-%dT%H:%M")
    end)

    obsidian.template_register_placeholder("date_format_06", function()
        return os.date("%Y-%m-%dT%H:%M")
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
        return get_reminders(ctx)
    end)
end

function M.register_all_placeholders(obsidian)
    M.register_journal_placeholders(obsidian)
    M.register_template_placeholders(obsidian)
end

function M.is_inside_vault(vault_root)
    local current_file = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()
    return current_file:sub(1, #vault_root) == vault_root or cwd:sub(1, #vault_root) == vault_root
end

return M
