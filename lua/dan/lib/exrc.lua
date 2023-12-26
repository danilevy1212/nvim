--- Manage `exrc` files.
local M = {}

local log_levels = vim.log.levels
local notify = vim.notify
---@type table<string, string | nil>
local loaded_exrcs = {}

--- Load an `exrc` file securely.
---@param file_path string
function M.load_exrc_file(file_path)
    local notify_opts = { title = 'exrc' }
    local contents = vim.secure.read(file_path)
    if not contents then
        notify('\'exrc\' file ' .. file_path .. ' is not trusted, ignoring.', log_levels.INFO, notify_opts)
        return
    end

    local hash = vim.fn.sha256(contents)
    if loaded_exrcs[hash] then
        notify('\'exrc\' file is already loaded, ignoring', log_levels.DEBUG, notify_opts)
        return
    end

    notify('Loading \'exrc\' file: ' .. file_path, log_levels.INFO, notify_opts)
    vim.cmd.source(file_path)
    loaded_exrcs[hash] = file_path
end

return M
