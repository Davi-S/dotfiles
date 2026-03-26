return {
    dir = "~/Documents/nvim-obsidian",
    name = "nvim-obsidian",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-treesitter/nvim-treesitter",
    },
    -- 'cmd' tells lazy.nvim when to load this plugin via commands.
    -- When any of these commands are invoked, the plugin loads automatically.
    cmd = {
        "ObsidianOmni",
        "ObsidianToday",
        "ObsidianNext",
        "ObsidianPrev",
        "ObsidianFollow",
        "ObsidianBacklinks",
        "ObsidianSearch",
        "ObsidianReindex",
        "ObsidianInsertTemplate",
    },
    -- Also load when opening files inside the vault
    init = function()
        local group = vim.api.nvim_create_augroup("ObsidianVaultLoad", { clear = true })
        vim.api.nvim_create_autocmd("BufReadPre", {
            group = group,
            pattern = "/home/davi/Documents/ObsidianAllInVault/**",
            callback = function()
                require("lazy").load({ plugins = { "nvim-obsidian" } })
            end,
        })
    end,
    keys = {
        { "<leader>dt", "<cmd>ObsidianToday<cr>", desc = "Obsidian [d]aily [t]oday" },
        { "<leader>dn", "<cmd>ObsidianNext<cr>",  desc = "Obsidian [d]aily [n]ext" },
        { "<leader>dp", "<cmd>ObsidianPrev<cr>",  desc = "Obsidian [d]aily [p]revious" },
    },
    config = function()
        local vault_root = "/home/davi/Documents/ObsidianAllInVault"
        local obsidian = require("nvim-obsidian")
        local obsidian_helper = require("plugins_helpers.nvim-obsidian_helper")

        obsidian_helper.register_journal_placeholders(obsidian)

        obsidian.setup({
            vault_root = "/home/davi/Documents/ObsidianAllInVault",
            locale = "pt-BR",
            new_notes_subdir = "10 Novas notas",
            -- force_create_key defaults to <S-CR>, no need to specify here
            journal = {
                daily = {
                    subdir = "11 Diário/11.01 Diário",
                    title_format = "{{year}} {{month_name}} {{day2}}, {{weekday_name}}",
                    template = "08 Templates/Nota diária",
                },
                weekly = {
                    subdir = "11 Diário/11.02 Semanal",
                    title_format = "{{iso_year}} semana {{iso_week}}",
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
            if obsidian_helper.is_inside_vault(vault_root) then
                vim.cmd("ObsidianOmni")
                return
            end
            require("telescope.builtin").find_files()
        end, { desc = "Find files (Omni in vault)" })

        -- Override <leader>lg from this plugin config:
        -- inside vault -> ObsidianSearch, outside vault -> telescope live_grep
        vim.keymap.set("n", "<leader>lg", function()
            if obsidian_helper.is_inside_vault(vault_root) then
                vim.cmd("ObsidianSearch")
                return
            end
            require("telescope.builtin").live_grep()
        end, { desc = "Live grep (ObsidianSearch in vault)" })

        -- Override <leader>fu from this plugin config:
        -- inside vault -> Follow if on wiki-link, otherwise Backlinks
        -- outside vault -> telescope helper
        vim.keymap.set("n", "<leader>fu", function()
            if obsidian_helper.is_inside_vault(vault_root) then
                local link = require("nvim-obsidian.link.wiki").link_under_cursor()
                if link and link ~= "" then
                    vim.cmd("ObsidianFollow")
                    return
                end

                vim.cmd("ObsidianBacklinks")
                return
            end
            require("plugins_helpers.telescope_helper").smart_definition()
        end, { desc = "Find usages (Follow/Backlinks in vault)" })
    end,
}
