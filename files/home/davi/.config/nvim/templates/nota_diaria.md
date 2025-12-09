---
tags:
  - nota_diária
date: {{ utils.format_date(0, "%Y-%m-%d") }}
---
[[{{ utils.format_date(-1, "%Y {MONTH} %d, {WEEKDAY}") }}|< Anterior]] | {{ vim.fn.expand("%:t:r") }} | [[{{ utils.format_date(1, "%Y {MONTH} %d, {WEEKDAY}") }}|Próximo >]]

Mês: [[{{ utils.format_date(0, "%Y {MONTH}") }}]]
Ano: [[{{ utils.format_date(0, "%Y") }}]]
Quinquênio: [[2024 - 2029]]

## Objetivos
{{ 
    local d = utils.get_date_components(0) 
    local last_day_of_month = os.date("*t", os.time({year=d.year, month=d.month+1, day=0})).day

    local reminders = {
        {"Pessoal", "S1", "T - Ver nota mensal"},
        {"Pessoal", "S6", "T - Lavar roupa"},
        {"Pessoal", "M1", "T - Ver nota anual"},
        {"Pessoal", "M1", "T - Limpar e organizar meu quarto e setup"},
        {"Pessoal", "M1", "T - Tirar fotos do corpo para comparação"},
        {"Pessoal", "M1", "T - Acessar emails das contas alternativas"},
        {"Pessoal", "M15", "T - Limpar e organizar meu quarto e setup"},
        
        {"Profissional", "M1", "E - Pagar cartão de crédito"},
        {"Profissional", "M1", "T - Adicionar informações sobre a carteira de investimentos na nota mensal"},
        {"Profissional", "M1", "E - Pagar mensalidade da CELU e mandar comprovante para a universidade"},
        {"Profissional", "M13", "T - Lembrar tios de mandar o dinheiro de pagar os lotes"},
        {"Profissional", "M20", "E - Pagar os lotes"},
        {"Profissional", "M27", "E - Pagar cheque do Cândido"},
    }

    local groups = {}
    for _, r in ipairs(reminders) do
        local pillar, cond, text = r[1], r[2], r[3]
        local trigger = false
        local type = cond:sub(1,1)
        local val = tonumber(cond:sub(2))
        
        if type == "M" then 
            if val > 0 then trigger = (d.day == val)
            else trigger = (d.day == (last_day_of_month + val + 1)) end
        elseif type == "S" then
            trigger = (d.wday == val)
        end
        
        if trigger then
            if not groups[pillar] then groups[pillar] = {} end
            table.insert(groups[pillar], text)
        end
    end

    local output = ""
    local sorted_pillars = {}
    for k in pairs(groups) do table.insert(sorted_pillars, k) end
    table.sort(sorted_pillars)

    for _, pillar in ipairs(sorted_pillars) do
        output = output .. "\n### " .. pillar .. "\n"
        for _, t in ipairs(groups[pillar]) do
            output = output .. "- [ ] " .. t .. "\n"
        end
    end
    
    if output == "" then
        return "\n"
    else
        return output
    end
}}

## Próximos objetivos

```dataview
TASK
FROM "11 Diário/11.01 Diário"
WHERE !checked AND file.link.date > date({{ utils.format_date(0, "%Y-%m-%d") }}) AND file.link.date < date({{ utils.format_date(7, "%Y-%m-%d") }})
GROUP BY file.link AS foo
SORT foo.date ASC
```

## Escrita livre
