-- Easier LSP configuration
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Additional type definitions for nvim. Must be configured before lspconfig
        {
            'folke/neodev.nvim',
        },
        -- LSP Completion
        { 'hrsh7th/cmp-nvim-lsp' },
    },
}
