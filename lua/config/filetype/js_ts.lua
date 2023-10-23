local on_attach = require('config.utils').on_attach
local capabilities = require('config.utils').capabilities
local lspconfig = require 'lspconfig'
local current_bufnr = vim.api.nvim_get_current_buf()

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
lspconfig.eslint.setup {
    ---@param client lsp.Client
    on_attach = function(client)
        -- Use eslint as documentFormattingProvider
        client.server_capabilities.documentFormattingProvider = true
    end,
    settings = {
        -- Make it easier to work with monorepos
        workingDirectory = {
            mode = 'location',
        },
    },
}

local clients = {
    'tsserver',
    'eslint',
}
--- We restart the client to force it to connect if we aren't connected already
for _, name in ipairs(clients) do
    if #vim.lsp.get_active_clients {
        name = name,
        bufnr = current_bufnr,
    } == 0 then
        lspconfig[name].launch()
    end
end
