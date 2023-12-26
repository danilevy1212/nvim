require('dan.lib.lsp').setup_lsp_server('dockerls', {
    on_attach = require('dan.lib.lsp').on_attach,
    capabilities = require('dan.lib.lsp').get_default_capabilities(),
})
