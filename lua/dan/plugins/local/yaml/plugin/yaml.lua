require('dan.lib.lsp').setup_lsp_server('yamlls', {
    on_attach = require('dan.lib.lsp').on_attach,
    capabilities = require('dan.lib.lsp').get_default_capabilities(),
    settings = {
        yaml = {
            schemaStore = {
                -- Must be disabled to use SchemaStore.nvim
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
        },
    },
})
