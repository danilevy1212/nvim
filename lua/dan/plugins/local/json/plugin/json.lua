require('dan.lib.lsp').setup_lsp_server('jsonls', {
    on_attach = require('dan.lib.lsp').on_attach,
    capabilities = require('dan.lib.lsp').get_default_capabilities(),
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
})
