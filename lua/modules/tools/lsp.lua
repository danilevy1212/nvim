-- Easier LSP configuration
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Additional type definitions for nvim. Must be configured before lspconfig
        { 'folke/neodev.nvim' },
        --- Load `mason` before trying to intialize the lsp servers
        { 'williamboman/mason.nvim' },
    },
}
