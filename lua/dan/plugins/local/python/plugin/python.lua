require('dan.lib.lsp').setup_lsp_server('pyright', {
    on_attach = require('dan.lib.lsp').on_attach,
    capabilities = require('dan.lib.lsp').get_default_capabilities(),
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
