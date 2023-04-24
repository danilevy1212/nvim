-- TODO Replace with Lazy variant, I may not even need it
-- Reload packages starting by `name`, circunventing the cache
_G.R = function(name)
    require('plenary.reload').reload_module(name)
end

return {
    'nvim-lua/plenary.nvim',
    init = function()
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
