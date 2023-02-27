local M = {}

--- Require without throwing an error, but notify in case of an error.
--- Meant to be used to run 'one-shot' configuration scripts.
--- See https://www.lua.org/manual/5.1/manual.html#pdf-require
--- @param module_path string
--- @return boolean, unknown|nil
function M.prequire(module_path)
    local ok, package_maybe = pcall(require, module_path)

    if not ok then
        vim.notify(
            'Module ' .. module_path .. ' fail to load, please check it:\n\n' .. tostring(package_maybe),
            vim.log.levels.ERROR
        )
    end

    return ok, package_maybe
end

return M
