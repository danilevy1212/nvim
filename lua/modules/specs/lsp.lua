-- Category: tools

return {
    'neovim/nvim-lspconfig',
    event = 'BufRead',
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
        -- Load 'neodev' before the setting the config
        require('neodev').setup {
            -- Disable neodev setting up `lua-language-server`, we do that manually later.
            lspconfig = false,
        }

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(_, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', '<leader>cD', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<leader>cf', function()
                vim.lsp.buf.format { async = true }
            end, bufopts)
        end

        -- Set up nvim-cmp
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require 'lspconfig'

        -- Lua config
        lspconfig.sumneko_lua.setup {
            before_init = require('neodev.lsp').before_init,
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    -- Remove request action pop up https://github.com/folke/neodev.nvim/issues/88#issuecomment-1314449905
                    workspace = {
                        checkThirdParty = false,
                    },
                    -- Setup snippets
                    completion = {
                        callSnippet = 'Replace',
                    },
                },
            },
        }

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

        -- VimL (Yikes!)
        lspconfig.vimls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }

        -- Nix
        lspconfig.rnix.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
}
