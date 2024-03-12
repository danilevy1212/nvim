-- Implementation of gx without the need of netrw

---@type LazyPluginSpec
local M = {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
}

return M
