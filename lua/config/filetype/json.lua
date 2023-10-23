local on_attach = require('config.utils').on_attach
local capabilities = require('config.utils').capabilities
local lspconfig = require 'lspconfig'

-- JSON config
lspconfig.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

if #vim.lsp.get_active_clients {
    name = 'jsonls',
    bufnr = vim.api.nvim_get_current_buf(),
} == 0 then
    lspconfig.jsonls.launch()
end
