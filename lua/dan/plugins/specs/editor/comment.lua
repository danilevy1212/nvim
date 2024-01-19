-- Smart and Powerful commenting plugin for neovim

---@type LazyPluginSpec
local M = {
    'numToStr/Comment.nvim',
    keys = { 'gc', 'gb' },
    event = { 'BufRead' },
    opts = {},
}

return M
