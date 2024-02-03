---@type LazyPluginSpec[]
local M = {
    --- Easier LSP configuration
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            --- Additional type definitions for nvim. Must be configured before lspconfig
            { 'folke/neodev.nvim' },
            --- Load `mason` before trying to initialize the lsp servers
            { 'williamboman/mason.nvim' },
        },
    },
}

return M
