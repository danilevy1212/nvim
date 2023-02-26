-- Category: tools

return {
    'neovim/nvim-lspconfig',
    module = 'lspconfig',
    requires = {
        -- Additional type definitions for nvim. Must be configured before lspconfig
        {
            'folke/neodev.nvim',
            module = 'neodev',
        },
        -- LSP Completion
        { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' },
    }
}
