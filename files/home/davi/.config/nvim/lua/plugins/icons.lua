return {
    "nvim-mini/mini.icons",
    version = false,
    -- Loaded as a dependency by the plugins that show icons (statusline, files, picker, completion)
    lazy = true,
    init = function()
        -- Serve any `require("nvim-web-devicons")` from mini.icons, so plugins that
        -- only support nvim-web-devicons still get icons without installing it
        package.preload["nvim-web-devicons"] = function()
            require("mini.icons").mock_nvim_web_devicons()
            return package.loaded["nvim-web-devicons"]
        end
    end,
    -- Calls require("mini.icons").setup({}), which creates the global `MiniIcons`
    -- that mini.files, mini.pick and mini.statusline look for to show icons
    opts = {},
}
