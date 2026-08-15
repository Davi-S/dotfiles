return {
    "Davi-S/nvim-obsidian",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-mini/mini.pick",
        "saghen/blink.cmp",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local vault_root = "/home/davi/Documents/ObsidianAllInVault"
        local obsidian = require("nvim_obsidian")
        local obsidian_helper = require("plugins_helpers.nvim-obsidian_helper")

        -- Register journal placeholders before setup so title formats can resolve them.
        -- Template placeholders registered after setup consume canonical template ctx fields.
        obsidian_helper.register_journal_placeholders(obsidian)

        obsidian.setup({
            vault_root = vault_root,
            log_level = "warn",
            locale = "pt-BR",
            new_notes_subdir = "10 Novas notas",
            dataview = {
                highlights = {
                    header = "@lsp.type.decorator.markdown",
                    table_link = "markdownLinkText",
                    task_no_results = "Comment",
                    error = "WarningMsg",
                },
            },
            journal = {
                daily = {
                    subdir = "11 Diário/11.01 Diário",
                    title_format = "{{year}} {{month_name}} {{day2}}, {{weekday_name}}",
                    template = "08 Templates/Nota diária",
                },
                weekly = {
                    subdir = "11 Diário/11.02 Semanal",
                    title_format = "{{iso_year}} semana {{iso_week_unpadded}}",
                },
                monthly = {
                    subdir = "11 Diário/11.03 Mensal",
                    title_format = "{{year}} {{month_name}}",
                    template = "08 Templates/Nota mensal",
                },
                yearly = {
                    subdir = "11 Diário/11.04 Anual",
                    title_format = "{{year}}",
                },
            },
            templates = {
                standard = "08 Templates/Nova nota",
            },
            calendar = {
                confirm_before_create = true,
                floating = {
                    height = 20,
                    width = 50,
                },
            },
        })

        obsidian_helper.register_template_placeholders(obsidian)

        ----------------------------------------------------------------------------
        -- Override telescope keymaps
        ----------------------------------------------------------------------------
        local vault_keymaps_group = vim.api.nvim_create_augroup("nvim-obsidian-vault-keymaps", {
            clear = true,
        })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
            group = vault_keymaps_group,
            callback = function(args)
                if not obsidian.is_inside_vault() then
                    return
                end

                -- Override Telescope's <leader>ff from this plugin config:
                -- inside vault -> ObsidianOmni
                vim.keymap.set("n", "<leader>ff", function()
                    vim.cmd("ObsidianOmni")
                end, { buffer = args.buf, desc = "Find files (Omni in vault)" })

                -- Override <leader>lg from this plugin config:
                -- inside vault -> ObsidianSearch
                vim.keymap.set("n", "<leader>lg", function()
                    vim.cmd("ObsidianSearch")
                end, { buffer = args.buf, desc = "Live grep (ObsidianSearch in vault)" })

                -- Override <leader>fu from this plugin config:
                -- inside vault -> Follow if on wiki-link, otherwise Backlinks
                vim.keymap.set("n", "<leader>fu", function()
                    local parsed = obsidian.wiki_link_under_cursor()
                    if parsed and parsed.target then
                        vim.cmd("ObsidianFollow")
                        return
                    end

                    vim.cmd("ObsidianBacklinks")
                end, { buffer = args.buf, desc = "Find usages (Follow/Backlinks in vault)" })
            end,
        })

        ----------------------------------------------------------------------------
        -- Set keymaps
        ----------------------------------------------------------------------------
        vim.keymap.set("n", "<leader>dt", "<cmd>ObsidianToday<cr>", { desc = "Obsidian [d]aily [t]oday" })
        vim.keymap.set("n", "<leader>dn", "<cmd>ObsidianNext<cr>", { desc = "Obsidian [d]aily [n]ext" })
        vim.keymap.set("n", "<leader>dp", "<cmd>ObsidianPrev<cr>", { desc = "Obsidian [d]aily [p]revious" })
        vim.keymap.set(
            "n",
            "<leader>dc",
            "<cmd>ObsidianJournalCalendarFloat<cr>",
            { desc = "Obsidian [d]aily [c]alendar" }
        )
    end,
}
