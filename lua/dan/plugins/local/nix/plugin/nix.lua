require('dan.lib.mason').ensure_installed({
    'nil',
}, function()
    require('dan.lib.lsp').setup_lsp_server('nil_ls', {
        on_attach = require('dan.lib.lsp').on_attach,
        capabilities = require('dan.lib.lsp').get_default_capabilities(),
        settings = {
            ['nil'] = {
                formatting = {
                    command = { 'alejandra' },
                },
            },
        },
    })
end)
