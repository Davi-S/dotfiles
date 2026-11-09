-- Obsidian vault in Neovim: daily notes, links, templates (my own plugin)

return {
    "Davi-S/nvim-obsidian",
    -- Lazy-load when opening markdown files, running Obsidian commands, or pressing vault shortcuts
    ft = { "markdown" },
    cmd = {
        "ObsidianToday",
        "ObsidianNext",
        "ObsidianPrev",
        "ObsidianJournalCalendarFloat",
        "ObsidianOmni",
        "ObsidianSearch",
        "ObsidianFollow",
        "ObsidianBacklinks",
    },
    keys = {
        { "<leader>dt", desc = "[d]aily note: [t]oday" },
        { "<leader>dn", desc = "[d]aily note: [n]ext" },
        { "<leader>dp", desc = "[d]aily note: [p]revious" },
        { "<leader>dc", desc = "[d]aily note: [c]alendar" },
    },
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
        -- Inside the vault, the picker keymaps (mini.pick) use the vault's own
        -- finders instead
        ----------------------------------------------------------------------------
        local vault_keymaps_group = vim.api.nvim_create_augroup("nvim-obsidian-vault-keymaps", {
            clear = true,
        })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
            group = vault_keymaps_group,
            desc = "Set the vault keymaps once per vault buffer",
            callback = function(args)
                if vim.b[args.buf].obsidian_vault_keymaps or not obsidian.is_inside_vault() then
                    return
                end
                vim.b[args.buf].obsidian_vault_keymaps = true

                -- <leader>ff inside the vault -> ObsidianOmni
                vim.keymap.set("n", "<leader>ff", function()
                    vim.cmd("ObsidianOmni")
                end, { buffer = args.buf, desc = "[f]ind [f]iles in the vault" })

                -- <leader>fg inside the vault -> ObsidianSearch
                vim.keymap.set("n", "<leader>fg", function()
                    vim.cmd("ObsidianSearch")
                end, { buffer = args.buf, desc = "[f]ind with live [g]rep in the vault" })

                -- <leader>fu inside the vault -> Follow if on a wiki-link, otherwise Backlinks
                vim.keymap.set("n", "<leader>fu", function()
                    local parsed = obsidian.wiki_link_under_cursor()
                    if parsed and parsed.target then
                        vim.cmd("ObsidianFollow")
                        return
                    end

                    vim.cmd("ObsidianBacklinks")
                end, { buffer = args.buf, desc = "[f]ind [u]sages in the vault (link or backlinks)" })
            end,
        })

        ----------------------------------------------------------------------------
        -- Set keymaps
        ----------------------------------------------------------------------------
        vim.keymap.set("n", "<leader>dt", "<cmd>ObsidianToday<CR>", { desc = "[d]aily note: [t]oday" })
        vim.keymap.set("n", "<leader>dn", "<cmd>ObsidianNext<CR>", { desc = "[d]aily note: [n]ext" })
        vim.keymap.set("n", "<leader>dp", "<cmd>ObsidianPrev<CR>", { desc = "[d]aily note: [p]revious" })
        vim.keymap.set(
            "n",
            "<leader>dc",
            "<cmd>ObsidianJournalCalendarFloat<CR>",
            { desc = "[d]aily note: [c]alendar" }
        )
    end,
}
