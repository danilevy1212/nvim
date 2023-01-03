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
            require('which-key').register({
                g = {
                    d = { vim.lsp.buf.definition, 'Go to definition' },
                    D = { vim.lsp.buf.declaration, 'Go to declaration' },
                    i = { vim.lsp.buf.implementation, 'Go to implementation' },
                    R = { vim.lsp.buf.references, 'Find references' },
                },
                K = { vim.lsp.buf.hover, 'Hover' },
                ['C-k'] = { vim.lsp.buf.signature_help, 'Signature Help' },
                ['<leader>'] = {
                    c = {
                        name = 'Code',
                        d = { vim.lsp.buf.definition, 'Go to definition' },
                        f = {
                            function()
                                vim.lsp.buf.format { async = true }
                            end,
                            'Format',
                        },
                        t = { vim.lsp.buf.type_definition, 'Go to type definition' },
                        r = { vim.lsp.buf.rename, 'Rename at point' },
                        R = { vim.lsp.buf.references, 'Find references' },
                        a = { vim.lsp.buf.code_action, 'Code action' },
                        w = {
                            name = 'Workspace',
                            a = { vim.lsp.buf.add_workspace_folder, 'Add workspace' },
                            r = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace' },
                            l = {
                                function()
                                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                                end,
                                'List workspaces',
                            },
                        },
                    },
                },
            }, { buffer = bufnr })
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
        lspconfig.eslint.setup {
            settings = {
                -- Make it easier to work with monorepos
                workingDirectory = {
                    mode = 'auto',
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
        }
    end,
}
