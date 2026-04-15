---@class SpecExt
---@field src string
---@field name? string
---@field config? function
---@field build? fun(ctx: table, done: fun(ok: boolean, message?: string)?): (boolean|string)?
--- Build runs only when PackChanged reports install/update for this plugin.
--- Return "async" when the build completes later and calls done().
---@field dependencies? SpecExt[]

local pack_changed_kinds = {}

-- Track the latest PackChanged kind by plugin name for this startup.
vim.api.nvim_create_autocmd("User", {
    pattern = "PackChanged",
    callback = function(ev)
        if not ev.data or not ev.data.name then
            return
        end

        pack_changed_kinds[ev.data.name] = ev.data.kind
    end,
})

---@param spec SpecExt
---@return string
local function get_spec_name(spec)
    if spec.name and spec.name ~= "" then
        return spec.name
    end

    local src = spec.src or ""
    local name = src:match("/([^/]+)%.git$") or src:match("/([^/]+)$")
    return name or src
end

---@param plugin_name string
---@return string
local function get_plugin_dir(plugin_name)
    return vim.fn.globpath(
        vim.fn.stdpath("data"),
        "site/pack/*/{start,opt}/" .. plugin_name,
        false,
        true
    )[1] or ""
end

---@param build_task table
---@return boolean
local function should_run_build(build_task)
    -- Build policy: run only for install/update events.
    local changed_kind = pack_changed_kinds[build_task.name]
    return changed_kind == "install" or changed_kind == "update"
end

---@param build_tasks table[]
---@param on_complete function
local function run_build_tasks(build_tasks, on_complete)
    local runnable_tasks = {}
    for _, build_task in ipairs(build_tasks) do
        if should_run_build(build_task) then
            runnable_tasks[#runnable_tasks + 1] = build_task
        end
    end

    if #runnable_tasks == 0 then
        on_complete()
        return
    end

    local pending = #runnable_tasks
    local success_count = 0
    local failure_count = 0

    local function finish_one(plugin_name, ok, message)
        if ok then
            success_count = success_count + 1
            vim.notify("Build succeeded for " .. plugin_name)
        else
            failure_count = failure_count + 1
            local suffix = (message and message ~= "") and (":\n" .. message) or ""
            vim.notify("Build failed for " .. plugin_name .. suffix, vim.log.levels.ERROR)
        end

        pending = pending - 1
        if pending ~= 0 then
            return
        end

        local level = failure_count > 0 and vim.log.levels.WARN or vim.log.levels.INFO
        vim.notify(
            string.format("Build step finished: %d succeeded, %d failed", success_count, failure_count),
            level
        )
        on_complete()
    end

    for _, build_task in ipairs(runnable_tasks) do
        local ctx = {
            name = build_task.name,
            src = build_task.src,
            plugin_dir = get_plugin_dir(build_task.name),
        }

        vim.notify("Running build for " .. build_task.name)

        local finished = false
        local function done(ok, message)
            if finished then
                return
            end

            finished = true
            finish_one(build_task.name, ok ~= false, message)
        end

        -- build() may complete synchronously or return "async" and call done later.
        local ok, ret, extra = pcall(build_task.build, ctx, done)
        if not ok then
            done(false, ret)
        elseif ret ~= "async" then
            local message
            if type(extra) == "string" then
                message = extra
            elseif type(ret) == "string" then
                message = ret
            end

            done(ret ~= false, message)
        end
    end
end

---@param specs_ext SpecExt[]
local function setup_specs(specs_ext)
    local specs = {}
    local seen = {}
    local configs = {}
    local build_tasks = {}

    ---Adds a spec once, keyed by normalized src.
    ---@param spec SpecExt
    local function add(spec)
        if seen[spec.src] then
            return
        end

        seen[spec.src] = true
        local name = get_spec_name(spec)

        local pack_spec = vim.tbl_extend("force", spec, { src = spec.src, name = name })
        pack_spec.config = nil
        pack_spec.dependencies = nil
        pack_spec.build = nil
        specs[#specs + 1] = pack_spec

        if type(spec.build) == "function" then
            build_tasks[#build_tasks + 1] = {
                src = spec.src,
                name = name,
                build = spec.build,
            }
        end

        if type(spec.config) == "function" then
            configs[#configs + 1] = spec.config
        end
    end

    for _, spec in ipairs(specs_ext or {}) do
        for _, dep in ipairs(spec.dependencies or {}) do
            add(dep)
        end

        add(spec)
    end

    if #specs > 0 then
        vim.pack.add(specs)
    end

    local function run_configs()
        for _, config in ipairs(configs) do
            config()
        end
    end

    if #build_tasks == 0 then
        run_configs()
        return
    end

    run_build_tasks(build_tasks, run_configs)
end

--- Recursively searches a directory for Lua files and extracts valid SpecExt tables
---@param dir_path string The root directory to search in
---@return table[] A flat list of all discovered SpecExt tables
local function discover_specs(dir_path)
    local all_specs = {}

    local root = dir_path
    if not root:match("^/") then
        root = vim.fs.joinpath(vim.fn.stdpath("config"), root)
    end

    -- Find all .lua files recursively in the given directory
    -- glob() arguments: pattern, ignore-case, return-as-list
    local files = vim.fn.glob(root .. "/**/*.lua", true, true)

    -- Process each file
    for _, file_path in ipairs(files) do
        local result = dofile(file_path)
        -- Determine if the file returned a single table or a list of tables
        -- We can check if it's a list by seeing if it has a first numeric index
        if result[1] ~= nil then
            -- It's a list of tables: iterate through them
            for _, item in ipairs(result) do
                table.insert(all_specs, item)
            end
        else
            -- It's a single table: validate it directly
            table.insert(all_specs, result)
        end
    end

    return all_specs
end

--- The master setup function to trigger the entire pipeline
---@param dir_path string The root directory containing your plugin spec files
local function setup(dir_path)
    -- Discover all specifications
    local discovered_specs = discover_specs(dir_path)
    -- Pass the discovered specs to the engine
    setup_specs(discovered_specs)
end

local function clean_inactive_packs()
    local names = vim.iter(vim.pack.get())
        :filter(function(p)
            return not p.active and p.spec.name
        end)
        :map(function(p)
            return p.spec.name
        end)
        :totable()

    if #names == 0 then
        vim.notify("No inactive plugins to remove")
        return
    end

    vim.pack.del(names)
    vim.notify(string.format("Removed %d inactive plugin(s)", #names))
end

local function remove_all_packs()
    local names = vim.iter(vim.pack.get())
        :filter(function(p)
            return p.spec.name ~= nil
        end)
        :map(function(p)
            return p.spec.name
        end)
        :totable()

    if #names == 0 then
        vim.notify("No plugins to remove")
        return
    end

    vim.pack.del(names, { force = true })
    vim.notify(string.format("Removed %d plugin(s)", #names))
end

vim.api.nvim_create_user_command("Pack", function(opts)
    local subcommand = opts.fargs[1]

    if subcommand == "clean-inactive" then
        clean_inactive_packs()
        return
    end

    if subcommand == "remove-all" then
        remove_all_packs()
        return
    end

    vim.notify(
        "Unknown Pack subcommand: " .. subcommand .. " (use: clean-inactive, remove-all)",
        vim.log.levels.ERROR
    )
end, {
    nargs = 1,
    complete = function()
        return { "clean-inactive", "remove-all" }
    end,
    desc = "Manage vim.pack plugins",
})

setup("lua/plugins")
