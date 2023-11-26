local on_attach = require('config.utils').on_attach
local capabilities = require('config.utils').get_default_capabilities()

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
                -- Use eslint as documentFormattingProvider
                client.server_capabilities.documentFormattingProvider = true
            end,
            capabilities = capabilities,
            settings = {
                -- Make it easier to work with monorepos
                workingDirectory = {
                    mode = 'location',
                },
            },
        },
    },
}

for _, server_configuration in ipairs(setups) do
    require('config.utils').setup_lsp_server(server_configuration.server_name, server_configuration.opts)
end
