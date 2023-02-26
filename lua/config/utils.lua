local M = {}

--- Require without throwing an error, but with a warning.
--- Meant to be used to run 'one-shot' configuration scripts. 
--- See https://www.lua.org/manual/5.1/manual.html#pdf-require
--- @param module_path string
--- @return unknown
M.require_with_warn = function(module_path)
    local ok, _ = pcall(require, module_path)

    if not ok then
        vim.notify('Module ' .. module_path .. ' fail to load, please check it', vim.log.levels.ERROR)
    end
end

return M
