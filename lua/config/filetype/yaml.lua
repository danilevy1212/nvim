local on_attach = require('modules.utils.lsp').on_attach
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require 'lspconfig'

lspconfig.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                ['https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json'] = '/*.k8s.yaml',
                ['https://gitlab.com/gitlab-org/gitlab/-/blob/abd04ae7c937daf953e94d5dcfe9c8eb2b90ad01/app/assets/javascripts/editor/schema/ci.json'] = '/*.gitlab-ci.y[a]?ml',
            },
        },
    },
}

if #vim.lsp.get_active_clients {
    name = 'yamlls',
} == 0 then
    lspconfig.yamlls.launch()
end
