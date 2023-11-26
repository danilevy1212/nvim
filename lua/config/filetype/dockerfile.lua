require('config.utils').setup_lsp_server('dockerls', {
    on_attach = require('config.utils').on_attach,
    capabilities = require('config.utils').get_default_capabilities(),
})
