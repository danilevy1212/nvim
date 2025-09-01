require('dan.lib.mason').ensure_installed({
    'basedpyright',
}, function()
    require('dan.lib.lsp').setup_lsp_server('basedpyright', {
        on_attach = require('dan.lib.lsp').on_attach,
        capabilities = require('dan.lib.lsp').get_default_capabilities(),
        settings = {
            basedpyright = {
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
end)
