local M = {}

function M.setup()
    require("obsidian.daily").setup()
    require("obsidian.templates").setup()
    require("obsidian.telescope").setup()
end

return M
