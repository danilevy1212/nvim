-- A neovim package manager

return {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall' },
    config = function()
        require('mason').setup {
            PATH = 'prepend',
        }

        -- Packages to install
        local package_names = {
            -- For lua
            'lua-language-server',
            'stylua',
            -- For nix
            'nil',
            -- For JSON
            'json-lsp',
            -- For JS / TS
            'typescript-language-server',
            'eslint-lsp',
            'js-debug-adapter',
            -- For rust
            'rust-analyzer',
            'codelldb',
            -- For docker
            'dockerfile-language-server',
        }

        -- Install packages if not present
        for _, package_name in ipairs(package_names) do
            local is_ok, package = pcall(require('mason-registry').get_package, package_name)

            if not is_ok then
                vim.notify('Mason package ' .. package_name .. ' was not found in the registry', vim.log.levels.WARN, {
                    title = 'Mason could not download ' .. package_name,
                })
            else
                if not package:is_installed() then
                    package:install()
                end
            end
        end
    end,
}
