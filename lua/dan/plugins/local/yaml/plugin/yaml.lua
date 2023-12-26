require('dan.lib.lsp').setup_lsp_server('yamlls', {
    on_attach = require('dan.lib.lsp').on_attach,
    capabilities = require('dan.lib.lsp').get_default_capabilities(),
    settings = {
        yaml = {
            --- TODO  https://github.com/b0o/SchemaStore.nvim
            -- NOTE Check on https://github.com/SchemaStore/schemastore
            schemas = {
                ['https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json'] = '/*.k8s.yaml',
                ['https://gitlab.com/gitlab-org/gitlab/-/blob/abd04ae7c937daf953e94d5dcfe9c8eb2b90ad01/app/assets/javascripts/editor/schema/ci.json'] = '/*.gitlab-ci.y[a]?ml',
                ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '/*compose.y[a]ml',
            },
        },
    },
})
