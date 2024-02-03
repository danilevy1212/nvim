require('dan.lib.mason').ensure_installed({
    'html-lsp',
}, function()
    require('dan.lib.lsp').setup_lsp_server('html', {
        on_attach = require('dan.lib.lsp').on_attach,
        capabilities = require('dan.lib.lsp').get_default_capabilities(),
    })
end)
