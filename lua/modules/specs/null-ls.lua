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

                -- Nix
                null_ls.builtins.formatting.alejandra,
            },
        }
    end,
}
