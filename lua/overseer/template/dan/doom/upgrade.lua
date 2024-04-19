---@diagnostic disable: missing-fields

---@type overseer.Task
local Task = {
    name = 'Upgrade doom emacs',
    builder = function()
        return {
            cmd = 'doom sync -u --gc && doom upgrade --force',
        }
    end,
    condition = {
        callback = function()
            return vim.fn.executable 'doom' == 1
        end,
    },
}

return Task
