local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require 'lspconfig'
local on_attach = require('modules.utils.lsp').on_attach

lspconfig.dockerls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
