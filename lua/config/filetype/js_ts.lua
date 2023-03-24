local on_attach = require('modules.utils.lsp').on_attach
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require 'lspconfig'

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

local clients = {
    'tsserver',
    'eslint',
}
--- We restart the client to force it to connect if we aren't connected already
for _, name in ipairs(clients) do
    if #vim.lsp.get_active_clients {
        name = name,
        bufnr = vim.api.nvim_get_current_buf()
    } == 0 then
        lspconfig[name].launch()
    end
end
