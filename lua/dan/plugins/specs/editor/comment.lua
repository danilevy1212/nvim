-- Category: editor

-- TODO Deprecate in favour of https://github.com/numToStr/Comment.nvim
-- Comment operator
return {
    'terrortylor/nvim-comment',
    event = { 'BufRead' },
    config = function()
        require('nvim_comment').setup()
    end,
}
