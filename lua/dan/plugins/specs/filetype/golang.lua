--- @type LazyPluginSpec
local M = {
    'dan/golang',
    ft = { 'go', 'gomod' },
    cond = function()
        return vim.fn.executable 'go' == 1
    end,
}

return M
