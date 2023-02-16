-- Category: tools

return {
    'neovim/nvim-lspconfig',
    event = 'BufRead',
    module = 'lspconfig',
    requires = {
        -- Additional type definitions for nvim. Must be configured before lspconfig
        {
            'folke/neodev.nvim',
            module = 'neodev',
        },
        -- LSP Completion
        { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' },
    },
    config = function()
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = require('modules.utils.lsp').on_attach

        -- Set up nvim-cmp
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require 'lspconfig'


        -- JSON config
        lspconfig.jsonls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }

        -- Typescript / Javascript config
        lspconfig.tsserver.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        lspconfig.eslint.setup {
            settings = {
                -- Make it easier to work with monorepos
                workingDirectory = {
                    mode = 'location',
                },
            },
        }

        -- VimL (Yikes!)
        lspconfig.vimls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }

        -- Nix
        lspconfig.nil_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ['nil'] = {
                    formatting = {
                        command = { 'alejandra' },
                    },
                },
            },
        }
    end,
}
