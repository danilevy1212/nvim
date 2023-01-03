--- Category: configuration

-- Reload packages starting by `name`, circunventing the cache
_G.R = function(name)
    require('plenary.reload').reload_module(name)
end

return {
    'nvim-lua/plenary.nvim',
    -- Lazily loaded so other plugins can call it on demand
    module_name = '^plenary.*',
    setup = function()
        -- Easy keybind to reload the configuration
        require('which-key').register({
            r = {
                function()
                    vim.cmd 'PackerSync'
                end,
                'Sync packages configuration',
            },
        }, {
            prefix = '<leader>h',
        })
    end,
}
