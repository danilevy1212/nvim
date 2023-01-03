-- Category: tools

return {
    'jose-elias-alvarez/null-ls.nvim',
    after = 'nvim-lspconfig',
    config = function()
        local null_ls = require 'null-ls'

        null_ls.setup {
            sources = {
                -- Setup stylua for neovim config
                null_ls.builtins.formatting.stylua,

                --- Setup eslint
                -- Eslint code actions
                null_ls.builtins.code_actions.eslint_d,
                -- Eslint auto formatting
                null_ls.builtins.formatting.eslint_d,
                -- Eslint diagnostics
                null_ls.builtins.diagnostics.eslint_d,

                -- Nix
                null_ls.builtins.formatting.alejandra,
            },
        }
    end,
}
