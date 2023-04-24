-- Main colorscheme

return {
    'shaunsingh/nord.nvim',
    event = { 'UIEnter' },
    config = function()
        require('nord').set()
    end,
}
