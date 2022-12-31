-- Category: editor

-- Surround operator
return {
    'kylechui/nvim-surround',
    tag = '*',
    event = 'BufRead',
    config = function()
        require('nvim-surround').setup {}
    end,
}
