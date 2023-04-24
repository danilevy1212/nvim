-- Easier LSP configuration
return {
    'neovim/nvim-lspconfig',
    module = 'lspconfig',
    dependencies = {
        -- Additional type definitions for nvim. Must be configured before lspconfig
        {
            'folke/neodev.nvim',
            module = 'neodev',
        },
        -- LSP Completion
        { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' },
    },
}
