require('config.utils').setup_lsp_server('pyright', {
    on_attach = require('config.utils').on_attach,
    capabilities = require('config.utils').get_default_capabilities(),
    settings = {
        pyright = {
            disableOrganizeImports = false,
            analysis = {
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
                autoImportCompletions = true,
            },
        },
    },
})
