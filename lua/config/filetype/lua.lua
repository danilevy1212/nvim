-- Load 'neodev' before the setting the config
require('neodev').setup {
    -- Disable neodev setting up `lua_ls`, we do that manually later.
    lspconfig = false,
}

local on_attach = require('config.utils').on_attach
local capabilities = require('config.utils').capabilities
local lspconfig = require 'lspconfig'
local null_ls = require 'null-ls'

-- Lua config
lspconfig.lua_ls.setup {
    before_init = require('neodev.lsp').before_init,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            -- Setup snippets
            completion = {
                -- Show both the snippet and completion
                callSnippet = 'Both',
            },
        },
    },
}

-- Setup stylua for neovim config
null_ls.setup {
    sources = {
        null_ls.builtins.formatting.stylua,
    },
}

--- We restart the client to force it to connect if we aren't connected already
if #vim.lsp.get_active_clients {
    name = 'lua_ls',
    bufnr = vim.api.nvim_get_current_buf(),
} == 0 then
    lspconfig.lua_ls.launch()
end

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
