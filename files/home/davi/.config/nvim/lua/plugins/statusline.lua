return {
    "nvim-mini/mini.statusline",
    version = false,
    dependencies = {
        "nvim-mini/mini.icons",
    },
    config = function()
        local statusline = require("mini.statusline")

        -- Get file icon from mini.icons based on current buffer
        local function get_file_icon()
            local filename = vim.api.nvim_buf_get_name(0)
            if filename == "" then
                return "󰈔 "
            end
            local extension = vim.fn.fnamemodify(filename, ":e")
            local icon, _ = require("mini.icons").get("extension", extension)
            return (icon or "󰈔") .. " "
        end

        -- Get formatted diagnostic count by severity
        local function get_diagnostics()
            if not vim.diagnostic.is_enabled() then
                return ""
            end

            local counts = {
                errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
                warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
                info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }),
                hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }),
            }

            local parts = {}
            if counts.errors > 0 then
                table.insert(parts, "%#DiagnosticError#󰅚 " .. counts.errors)
            end
            if counts.warnings > 0 then
                table.insert(parts, "%#DiagnosticWarn#󰀪 " .. counts.warnings)
            end
            if counts.info > 0 then
                table.insert(parts, "%#DiagnosticInfo#󰋼 " .. counts.info)
            end
            if counts.hints > 0 then
                table.insert(parts, "%#DiagnosticHint#󰌵 " .. counts.hints)
            end

            if #parts == 0 then
                return "%#DiagnosticOk#󰄬 0"
            end

            return table.concat(parts, " ")
        end

        -- Get attached LSP server names
        local function get_lsp_servers()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
                return ""
            end

            local names = {}
            for _, client in ipairs(clients) do
                table.insert(names, client.name)
            end

            return "󰒋 " .. table.concat(names, ", ")
        end

        -- Formats cursor location and scroll percentage (Line:Column │ Percentage%)
        local function get_location()
            return "%l:%c │ %p%%"
        end

        statusline.setup({
            use_icons = true,
            set_vim_settings = true,
            content = {
                active = function()
                    local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
                    local git = statusline.section_git({ trunc_width = 75 })
                    local diff = statusline.section_diff({ trunc_width = 75 })
                    local diagnostics = get_diagnostics()
                    local lsp = get_lsp_servers()

                    -- File information
                    local icon = get_file_icon()
                    local filename = statusline.section_filename({ trunc_width = 140 })
                    local file_display = icon .. filename

                    -- Location (Line:Column) and scroll percentage (%p%%)
                    local location = get_location()

                    return statusline.combine_groups({
                        { hl = mode_hl, strings = { mode } },
                        { hl = "MiniStatuslineDevinfo", strings = { git, diff } },
                        { hl = "Normal", strings = { diagnostics, lsp } },
                        "%<", -- Truncate point
                        { hl = "MiniStatuslineFilename", strings = { file_display } },
                        "%=", -- Right align
                        { hl = mode_hl, strings = { location } },
                    })
                end,
            },
        })
    end,
}
