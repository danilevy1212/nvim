--- Helper functions for Mason.
local M = {}

--- Check if all packages are installed.
---@param package_handlers InstallHandle[]
local function check_packages_status(package_handlers)
    local is_ok = true

    for _, package_handler in ipairs(package_handlers) do
        if package_handler.state ~= 'CLOSED' then
            is_ok = is_ok and false
        end
    end

    return is_ok
end

--- Ensure that a list of packages from `mason_registry` is installed.
---
--- Calls `on_installed` when all packages are installed, if defined.
---@param packages string[]
---@param on_installed? fun()
function M.ensure_installed(packages, on_installed)
    local mason_registry = require 'mason-registry'
    ---@type InstallHandle[]
    local package_handlers = {}

    for _, package_name in ipairs(packages) do
        local is_ok, package = pcall(mason_registry.get_package, package_name)

        if not is_ok then
            vim.notify('Mason package ' .. package_name .. ' was not found in the registry', vim.log.levels.WARN, {
                title = 'Mason could not download ' .. package_name,
            })
        else
            if not package:is_installed() then
                table.insert(package_handlers, package:install())
            end
        end
    end

    if not on_installed then
        return
    end

    local function on_tick()
        if check_packages_status(package_handlers) then
            on_installed()
        else
            vim.defer_fn(on_tick, 100)
        end
    end

    on_tick()
end

return M
