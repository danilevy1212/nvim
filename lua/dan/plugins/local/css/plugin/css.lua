require('dan.lib.lsp').setup_lsp_server('cssls', {
    ---@param client lsp.Client
    ---@param bufnr number
    on_attach = function(client, bufnr)
        require('dan.lib.lsp').on_attach(client, bufnr)
        -- NOTE  In 0.10.0 there is initial support for dynamic capabilities
        --       Revisit this code on upgrade.
        -- Use as documentFormattingProvider
        client.server_capabilities.documentFormattingProvider = true
    end,
    capabilities = require('dan.lib.lsp').get_default_capabilities(),
})
