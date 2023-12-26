local on_attach = require('dan.lib.lsp').on_attach
local capabilities = require('dan.lib.lsp').get_default_capabilities()

---@class ServerSetup
---@field server_name string
---@field opts table

---@type ServerSetup[]
local setups = {
    {
        server_name = 'tsserver',
        opts = {
            on_attach = on_attach,
            capabilities = capabilities,
        },
    },
    {
        server_name = 'eslint',
        opts = {
            ---@param client lsp.Client
            on_attach = function(client)
                -- NOTE  In 0.10.0 there is initial support for dynamic capabilities
                --       Revisit this code on upgrade.
                -- Use as `documentFormattingProvider`
                client.server_capabilities.documentFormattingProvider = true
            end,
            capabilities = capabilities,
            settings = {
                -- Make it easier to work with mono-repos
                workingDirectory = {
                    mode = 'location',
                },
            },
        },
    },
}

for _, server_configuration in ipairs(setups) do
    require('dan.lib.lsp').setup_lsp_server(server_configuration.server_name, server_configuration.opts)
end
