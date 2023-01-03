-- Category: configuration

return {
    'williamboman/mason.nvim',
    after = 'nvim-lspconfig',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall' },
    config = function()
        require('mason').setup()

        -- Packages to install
        local package_names = {}

        -- For lua (on MacOS)
        if CONSTANTS.IS_MACOS then
            package_names[#package_names + 1] = 'stylua'
        end

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
                local ensure_installed = {
                    -- For JSON
                    'jsonls',
                    -- For JS / TS
                    'tsserver',
                    'eslint',
                    -- For VimL (Yikes!)
                    'vimls',
                    -- For nix
                    'nil_ls',
                }

                -- For lua (on MacOS)
                if CONSTANTS.IS_MACOS then
                    ensure_installed[#ensure_installed + 1] = 'sumneko_lua'
                end

                require('mason-lspconfig').setup {
                    ensure_installed = ensure_installed,
                }
            end,
        },
    },
}
