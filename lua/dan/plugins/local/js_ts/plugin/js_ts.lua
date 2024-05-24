require('dan.lib.mason').ensure_installed({
    'typescript-language-server',
    'eslint-lsp',
    'js-debug-adapter',
    'eslint_d',
    'prettier',
}, function()
    local on_attach = require('dan.lib.lsp').on_attach
    local capabilities = require('dan.lib.lsp').get_default_capabilities()

    ---@class ServerSetup
    ---@field server_name string
    ---@field opts table

    ---@type ServerSetup[]
    local setups = {
        {
            server_name = 'tsserver',
            opts = {
                on_attach = on_attach,
                capabilities = capabilities,
                init_options = {
                    preferences = {
                        importModuleSpecifierPreference = 'non-relative',
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                settings = {
                    javascript = {
                        preferGoToSourceDefinition = true,
                        preferences = {
                            importModuleSpecifierPreference = 'non-relative',
                        },
                    },
                    typescript = {
                        preferGoToSourceDefinition = true,
                        preferences = {
                            importModuleSpecifierPreference = 'non-relative',
                        },
                    },
                },
            },
        },
        {
            server_name = 'eslint',
            opts = {
                ---@param client { server_capabilities: lsp.ServerCapabilities }
                on_attach = function(client)
                    -- NOTE  In 0.10.0 there is initial support for dynamic capabilities
                    --       Revisit this code on upgrade.
                    -- Use as `documentFormattingProvider`
                    client.server_capabilities.documentFormattingProvider = true
                end,
                capabilities = capabilities,
                settings = {
                    -- Make it easier to work with mono-repos
                    workingDirectory = {
                        mode = 'location',
                    },
                },
            },
        },
    }

    -- Conform settings
    require('conform').formatters_by_ft = vim.tbl_extend('force', require('conform').formatters_by_ft, {
        javascript = { 'prettier', 'eslint_d' },
        typescript = { 'prettier', 'eslint_d' },
        javascriptreact = { 'prettier', 'eslint_d' },
        typescriptreact = { 'prettier', 'eslint_d' },
    })

    -- Setup LSP servers
    for _, server_configuration in ipairs(setups) do
        require('dan.lib.lsp').setup_lsp_server(server_configuration.server_name, server_configuration.opts)
    end

    -- Setup DAP for debugging
    local dap = require 'dap'
    dap.adapters['pwa-node'] = function(callback)
        callback {
            type = 'server',
            host = 'localhost',
            port = '${port}',
            executable = {
                command = os.getenv 'NODE_PATH' or 'node',
                args = {
                    require('mason.settings').current.install_root_dir
                        .. '/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
                    '${port}',
                },
            },
        }
    end
    for _, language in ipairs {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    } do
        dap.configurations[language] = {
            -- NOTE  I could only make "Auto Attach" work with "pwa-node"
            {
                type = 'pwa-node',
                request = 'attach',
                name = 'Auto Attach to any process running `--inspect`',
                cwd = vim.fn.getcwd(),
                protocol = 'inspector',
            },
        }
    end
end)
