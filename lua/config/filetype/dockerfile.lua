local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require 'lspconfig'
local on_attach = require('modules.utils.lsp').on_attach

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
