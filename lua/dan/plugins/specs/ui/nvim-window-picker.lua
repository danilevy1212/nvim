--- Pick a window and returns the window id of the picked window

--- @type LazyPluginSpec
local M = {
    's1n7ax/nvim-window-picker',
    init = function()
        require('which-key').add {
            {
                '<C-w><C-w>',
                function()
                    local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
                    vim.api.nvim_set_current_win(picked_window_id)
                end,
                desc = 'Jump to other window',
            },
        }
    end,
    name = 'window-picker',
    version = '2.*',
    opts = {
        hint = 'floating-big-letter',
        selection_chars = '123456789QWERTYUIOPASDFGHJKLZXCVBNM',
        picker_config = {
            floating_big_letter = {
                font = 'ansi-shadow',
            },
        },
        filter_rules = {
            bo = {
                filetype = { 'notify' },
                buftype = {},
            },
        },
    },
    keys = {
        {
            '<C-w><C-w>',
            function()
                require('window-picker').pick_window {
                    hint = 'floating-big-letter',
                }
            end,
        },
    },
}

return M
