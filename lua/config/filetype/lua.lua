-- Load 'neodev' before the setting the config
require('neodev').setup {
    -- Disable neodev setting up `lua_ls`, we do that manually later.
    lspconfig = false,
}

local on_attach = require('modules.utils.lsp').on_attach
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require 'lspconfig'
local null_ls = require 'null-ls'

-- Lua config
lspconfig.lua_ls.setup {
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
    bufnr = vim.api.nvim_get_current_buf()
} == 0 then
    lspconfig.lua_ls.launch()
end
