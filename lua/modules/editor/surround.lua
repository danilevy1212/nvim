-- Surround operator
return {
    'kylechui/nvim-surround',
    version = '*',
    event = { 'BufRead' },
    config = function()
        require('nvim-surround').setup {}
    end,
}
