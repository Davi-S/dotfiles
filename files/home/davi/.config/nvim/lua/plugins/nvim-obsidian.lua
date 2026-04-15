return {
    src = "https://github.com/Davi-S/nvim-obsidian",
    dependencies = {
        { src = "https://github.com/nvim-lua/plenary.nvim" },
        { src = "https://github.com/nvim-telescope/telescope.nvim" },
        { src = "https://github.com/saghen/blink.cmp" },
        { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
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
                },
                yearly = {
                    subdir = "11 Diário/11.04 Anual",
                    title_format = "{{year}}",
                },
            },
            templates = {
                standard = "08 Templates/Nova nota",
            },
        })

        obsidian_helper.register_template_placeholders(obsidian)

        -- Override Telescope's <leader>ff from this plugin config:
        -- inside vault -> ObsidianOmni, outside vault -> telescope find_files
        vim.keymap.set("n", "<leader>ff", function()
            if obsidian.is_inside_vault() then
                vim.cmd("ObsidianOmni")
                return
            end
            require("telescope.builtin").find_files()
        end, { desc = "Find files (Omni in vault)" })

        -- Override <leader>lg from this plugin config:
        -- inside vault -> ObsidianSearch, outside vault -> telescope live_grep
        vim.keymap.set("n", "<leader>lg", function()
            if obsidian.is_inside_vault() then
                vim.cmd("ObsidianSearch")
                return
            end
            require("telescope.builtin").live_grep()
        end, { desc = "Live grep (ObsidianSearch in vault)" })

        -- Override <leader>fu from this plugin config:
        -- inside vault -> Follow if on wiki-link, otherwise Backlinks
        -- outside vault -> telescope helper
        vim.keymap.set("n", "<leader>fu", function()
            if obsidian.is_inside_vault() then
                local parsed = obsidian.wiki_link_under_cursor()
                if parsed and parsed.target then
                    vim.cmd("ObsidianFollow")
                    return
                end

                vim.cmd("ObsidianBacklinks")
                return
            end
            require("plugins_helpers.telescope_helper").smart_definition()
        end, { desc = "Find usages (Follow/Backlinks in vault)" })


        ----------------------------------------------------------------------------
        -- Set keymaps
        ----------------------------------------------------------------------------
        vim.keymap.set("n", "<leader>dt", "<cmd>ObsidianToday<cr>", { desc = "Obsidian [d]aily [t]oday" })
        vim.keymap.set("n", "<leader>dn", "<cmd>ObsidianNext<cr>", { desc = "Obsidian [d]aily [n]ext" })
        vim.keymap.set("n", "<leader>dp", "<cmd>ObsidianPrev<cr>", { desc = "Obsidian [d]aily [p]revious" })
    end,
}
