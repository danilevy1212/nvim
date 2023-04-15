local lspconfig = require 'lspconfig'
local on_attach = require('modules.utils.lsp').on_attach
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local server_name = 'nil_ls'

lspconfig[server_name].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ['nil'] = {
            formatting = {
                command = { 'alejandra' },
            },
        },
    },
}

--- We restart the client to force it to connect if we aren't connected already
if #vim.lsp.get_active_clients {
    name = server_name,
    bufnr = vim.api.nvim_get_current_buf(),
} == 0 then
    lspconfig[server_name].launch()
end
