-- Basic settings
vim.opt.number = true         -- show absolute line number for the current line
vim.opt.relativenumber = true -- show relative line numbers for other lines (helps with motions)
vim.opt.wrap = false          -- disable line wrapping; long lines will scroll horizontally
vim.opt.scrolloff = 9         -- minimum screen lines to keep above and below cursor
vim.opt.sidescrolloff = 30    -- minimum screen columns to keep left and right of cursor

--------------------------------------------------------------------------------

-- Spell
vim.opt.spell = true
vim.opt.spelllang = { "en", "pt" }
vim.opt.spelloptions = { "camel" }
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

--------------------------------------------------------------------------------

-- Indentation
vim.opt.tabstop = 4        -- number of spaces a <Tab> in file counts for
vim.opt.shiftwidth = 4     -- number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true   -- convert typed tabs to spaces
vim.opt.softtabstop = 4    -- number of spaces a Tab counts for while editing
vim.opt.autoindent = true  -- copy indent from current line when starting a new line
vim.opt.smartindent = true -- enable smart auto-indenting for C-like languages

--------------------------------------------------------------------------------

-- Search settings
vim.opt.ignorecase = true      -- ignore case in search patterns
vim.opt.smartcase = true       -- if ignore case in search patterns, be case-sensitive if the search contains uppercase letters
vim.opt.inccommand = "nosplit" -- shows partial off-screen results in a preview window for substitute commands

--------------------------------------------------------------------------------

-- Visual settings
vim.cmd.colorscheme("catppuccin") -- Apply color scheme
vim.opt.termguicolors = true      -- enable 24-bit RGB color in the terminal
vim.opt.signcolumn = "yes"        -- always show the sign column to avoid text shifting when signs appear
vim.opt.winborder = "rounded"     -- use rounded borders for floating windows
vim.opt.completeopt = {           -- completion behavior for pop up menu
    "fuzzy",
    "menuone",
    "noinsert",
}
vim.opt.pumheight = 10 -- maximum items to show in completion pop up menu
-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    desc = "highlight selection on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})
vim.diagnostic.config({ -- Configure diagnostics options
    virtual_text = true,
    severity_sort = true,
})
-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = true
    end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = "active_cursorline",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})
vim.opt.colorcolumn = "80" -- Highlight the "Xth" column
-- Highlight "confusing" characters
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = vim.api.nvim_create_augroup("BadCharHighlight", { clear = true }),
    callback = function()
        -- Get the current theme's Warning colors
        -- "link = false" ensures we get the actual hex values, not just a link name
        local warn_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false })
        local warn_bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextWarn", link = false })

        -- Create custom group dynamically
        vim.api.nvim_set_hl(0, "ConfusingChar", {
            fg = warn_fg.fg, -- Use the standard Warning text
            bg = warn_bg.bg, -- Use the soft Warning background (from virtual text)
            underline = true,
        })

        -- [“”‘’]     :: Smart Quotes (Word/Outlook style)
        -- [–—]       :: En-dash and Em-dash (Word auto-correct)
        -- [\u00A0]   :: Non-breaking space
        -- [;]        :: Greek Question Mark (Looks like semicolon)
        -- [−]        :: Mathematical Minus (Looks like hyphen)
        -- [\u200b]   :: Zero-width space
        -- [\u200c]   :: Zero-width non-joiner
        -- [\u200d]   :: Zero-width joiner
        local pattern = "[“”‘’–—\u{00A0};−\u{200b}\u{200c}\u{200d}]"

        -- Apply it
        vim.fn.matchadd("ConfusingChar", pattern, 100, -1)
    end,
})

--------------------------------------------------------------------------------

-- File handling
vim.opt.swapfile = false -- don't create swapfiles for buffers
vim.opt.undofile = true  -- persist undo history to disk
-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function()
                vim.cmd("normal! zz")
            end)
        end
    end,
})

--------------------------------------------------------------------------------

-- Behavior settings
vim.opt.iskeyword:append("-")     -- treat words with '-' as single word for motions
vim.opt.mouse = "a"               -- enable mouse support in all modes
vim.opt.clipboard = "unnamedplus" -- use the system clipboard for yank/copy/paste operations
vim.opt.textwidth = 80            -- automatically break a line before it gets too long

--------------------------------------------------------------------------------

-- Split behavior
vim.opt.splitright = true -- put new vertical splits to the right
vim.opt.splitbelow = true -- put new horizontal splits below

--------------------------------------------------------------------------------

-- netrw options
vim.g.netrw_banner = 0                                   -- disable the netrw banner
vim.g.netrw_browsex_viewer = "xdg-open"                  -- external program to open files
vim.g.netrw_hide = 0                                     -- show hidden files (0 = don't hide dotfiles)
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro" -- Show line numbers

--------------------------------------------------------------------------------
