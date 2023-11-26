-- Load 'neodev' before the setting the config
require('neodev').setup {
    -- Disable neodev setting up `lua_ls`, we do that manually later.
    lspconfig = false,
}

-- Lua config
require('config.utils').setup_lsp_server('lua_ls', {
    before_init = require('neodev.lsp').before_init,
    on_attach = require('config.utils').on_attach,
    capabilities = require('config.utils').get_default_capabilities(),
    settings = {
        Lua = {
            -- Setup snippets
            completion = {
                -- Show both the snippet and completion
                callSnippet = 'Both',
            },
        },
    },
})


-- Setup stylua for neovim config
local null_ls = require 'null-ls'
null_ls.setup {
    sources = {
        null_ls.builtins.formatting.stylua,
    },
}

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
