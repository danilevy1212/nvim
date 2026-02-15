-- nvim-jdtls provides enhanced Java LSP support with better JDTLS integration
-- https://github.com/mfussenegger/nvim-jdtls

---@type LazyPluginSpec
local M = {
    'dan/java',
    ft = { 'java' },
    dependencies = {
        'mfussenegger/nvim-jdtls',
        'mfussenegger/nvim-dap',
        'williamboman/mason.nvim',
    },
}

return M
