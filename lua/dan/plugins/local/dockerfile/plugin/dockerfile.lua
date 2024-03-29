require('dan.lib.mason').ensure_installed({
    'dockerfile-language-server',
}, function()
    require('dan.lib.lsp').setup_lsp_server('dockerfile', {
        on_attach = require('dan.lib.lsp').on_attach,
        capabilities = require('dan.lib.lsp').get_default_capabilities(),
    })
end)
