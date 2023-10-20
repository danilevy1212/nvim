--- Functions that make configuration easier

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
