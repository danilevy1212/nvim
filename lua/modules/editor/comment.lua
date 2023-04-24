-- Category: editor

-- Comment operator
return {
    'terrortylor/nvim-comment',
    event = { 'BufRead' },
    config = function()
        require('nvim_comment').setup()
    end,
}
