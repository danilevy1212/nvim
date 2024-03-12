-- Smart and Powerful commenting plugin for neovim

---@type LazyPluginSpec
local M = {
    'numToStr/Comment.nvim',
    keys = {
        {
            'gc',
            mode = { 'n', 'x' },
        },
        {
            'gb',
            mode = { 'n', 'x' },
        },
    },
    event = { 'BufRead' },
    opts = {},
}

return M
