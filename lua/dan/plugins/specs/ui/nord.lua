-- Main colorscheme

---@type LazyPluginSpec
local M = {
    'gbprod/nord.nvim',
    config = function()
        vim.cmd.colorscheme 'nord'
    end,
}

return M
