-- Category: configuration

return {
    'williamboman/mason.nvim',
    after = 'nvim-lspconfig',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall' },
    config = function()
        require('mason').setup()

        -- Packages to install
        local package_names = {
            -- For JS / TS
            'eslint_d',
            -- For Lua
            'stylua',
        }

        -- Install packages if not present
        for _, package_name in ipairs(package_names) do
            local package = require('mason-registry').get_package(package_name)
            if not package:is_installed() then
                package:install()
            end
        end
    end,
    requires = {
        -- LSP server installer helper
        {
            'williamboman/mason-lspconfig.nvim',
            after = 'mason.nvim',
            config = function()
                require('mason-lspconfig').setup {
                    ensure_installed = {
                        -- For lua
                        'sumneko_lua',
                        -- For JSON
                        'jsonls',
                        -- For JS / TS
                        'tsserver',
                        -- For VimL (Yikes!)
                        'vimls',
                        -- For nix
                        'rnix',
                    },
                }
            end,
        },
    },
}
