require('dan.lib.mason').ensure_installed({
    'lua-language-server',
    'stylua',
}, function()
    -- Load 'neodev' before the setting the config
    require('neodev').setup {
        -- Disable neodev setting up `lua_ls`, we do that manually later.
        lspconfig = false,
    }

    -- Setup lua language server
    require('dan.lib.lsp').setup_lsp_server('lua_ls', {
        before_init = require('neodev.lsp').before_init,
        on_attach = require('dan.lib.lsp').on_attach,
        capabilities = require('dan.lib.lsp').get_default_capabilities(),
        settings = {
            Lua = {
                --- Disable telemetry
                telemetry = {
                    enable = false,
                },
                completion = {
                    --- Show only the function
                    callSnippet = 'Disable',
                },
            },
        },
    })

    -- Setup stylua for neovim config
    require('conform').formatters_by_ft = vim.tbl_extend('force', require('conform').formatters_by_ft, {
        lua = { 'stylua' },
    })

    --- TODO When I have installed dap, remove the pcall guard
    -- Setup DAP
    local dap_is_available, dap = pcall(require, 'dap')

    if dap_is_available then
        dap.configurations.lua = {
            {
                type = 'nlua',
                request = 'attach',
                name = 'Attach to running Neovim instance',
            },
        }

        --- @param config {host: string?, port: number?}
        dap.adapters.nlua = function(callback, config)
            callback {
                type = 'server',
                host = config.host or '127.0.0.1',
                port = config.port or 36703,
            }
        end
    end
end)
