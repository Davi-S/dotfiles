local function create_daily_command()
    vim.api.nvim_create_user_command('Daily', function(args)
        -- Validation of input
        local input = args.args
        local offset = 0
        if input ~= "" then
            if not input:match("^[+-]%d+$") then
                vim.notify(
                    "Invalid argument: '" ..
                    input .. "'.\nUsage: :Daily (for today), :Daily +1 (tomorrow), :Daily -1 (yesterday), etc.",
                    vim.log.levels.ERROR)
                return
            end
            offset = tonumber(input) or 0
        end

        -- Portuguese translation tables
        local months = {
            "janeiro", "fevereiro", "março", "abril", "maio", "junho",
            "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"
        }
        local weekdays = {
            "domingo", "segunda-feira", "terça-feira", "quarta-feira",
            "quinta-feira", "sexta-feira", "sábado"
        }

        -- Calculate target date
        local current_time = os.time()
        local target_time = current_time + (offset * 86400)
        local d = os.date("*t", target_time)

        -- Format: "2025 novembro 26, quarta-feira"
        local date_string = string.format("%04d %s %02d, %s",
            d.year, months[d.month], d.day, weekdays[d.wday]
        )

        -- Paths
        local root = "/home/davi/Documents/ObsidianAllInVault/"
        local journal_dir = "11 Diário/11.01 Diário/"
        local full_dir = string.format("%s/%s", root, journal_dir)
        local filepath = string.format("%s/%s.md", full_dir, date_string)

        -- Check if root and journal directories exists
        if vim.fn.isdirectory(root) == 0 then
            vim.notify("Error: Vault root not found: " .. root, vim.log.levels.ERROR)
            return
        end
        if vim.fn.isdirectory(full_dir) == 0 then
            vim.notify("Error: Journal directory not found: " .. full_dir, vim.log.levels.ERROR)
            return
        end

        -- Open file
        vim.cmd("edit " .. vim.fn.fnameescape(filepath))

        -- ---------------------------------------------------------------------
        -- NEW: Check if file is empty and insert template
        -- ---------------------------------------------------------------------
        local line_count = vim.api.nvim_buf_line_count(0)
        local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]

        -- If buffer has 1 line and it is empty, it's a new file
        if line_count == 1 and first_line == "" then
            -- Safely try to run the InsertTemplate command
            -- Ensure the filename here matches EXACTLY what is in your templates folder
            -- (e.g. "Nota diária.md" or "nota_diaria.md")
            local success, _ = pcall(vim.cmd, "InsertTemplate nota_diaria.md")

            if not success then
                vim.notify(
                    "Daily Note created, but failed to insert 'nota_diaria.md'. Check if the template file exists.",
                    vim.log.levels.WARN)
            end
        end
    end, { nargs = "?", desc = "Open Daily Note" })
end

local function set_keymaps()
    vim.keymap.set("n", "<leader>dn", ":Daily<CR>", { desc = "[d]aily [n]ote (Today)" })
    vim.keymap.set("n", "<leader>dy", ":Daily -1<CR>", { desc = "[d]aily [y]esterday" })
    vim.keymap.set("n", "<leader>dt", ":Daily +1<CR>", { desc = "[d]aily [t]omorrow" })

    vim.keymap.set("n", "<leader>dp", function()
        vim.ui.input({ prompt = "Days Offset (+/-): " }, function(input)
            if input then vim.cmd("Daily " .. input) end
        end)
    end, { desc = "[d]aily [p]ick Offset" })
end

local M = {}

function M.setup()
    create_daily_command()
    set_keymaps()
    vim.notify("Obsidian Daily commands loaded", vim.log.levels.DEBUG)
end

return M
