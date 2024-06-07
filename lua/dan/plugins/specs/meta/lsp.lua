---@type LazyPluginSpec[]
local M = {
    --- Easier LSP configuration
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            --- Load `mason` before trying to initialize the lsp servers
            { 'williamboman/mason.nvim' },
        },
    },
}

return M
