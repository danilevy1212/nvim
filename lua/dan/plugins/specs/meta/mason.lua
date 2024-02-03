-- A neovim package manager

---@type LazyPluginSpec
local M = {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall' },
    opts = {
        PATH = 'prepend',
    },
}

return M
