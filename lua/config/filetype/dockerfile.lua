local capabilities = require('config.utils').capabilities
local lspconfig = require 'lspconfig'
local on_attach = require('config.utils').on_attach

lspconfig.dockerls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

if #vim.lsp.get_active_clients {
    name = 'dockerls',
    bufnr = vim.api.nvim_get_current_buf(),
} == 0 then
    lspconfig.dockerls.launch()
end
