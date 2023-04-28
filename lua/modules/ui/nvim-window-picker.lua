--- Pick a window and returns the window id of the picked window

return {
    's1n7ax/nvim-window-picker',
    version = 'v1.*',
    init = function()
        local wk = require 'which-key'

        wk.register({
            ['<C-w>'] = {
                function()
                    local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
                    vim.api.nvim_set_current_win(picked_window_id)
                end,
                'Jump to other window',
            },
        }, { prefix = '<C-w>' })
    end,
    config = function()
        local editor = require('nord.theme').loadEditor()

        require('window-picker').setup {
            use_winbar = 'always',
            filter_rules = {
                bo = {
                    buftype = {},
                },
            },
            selection_display = function(char)
                return char .. ': %f'
            end,
            fg_color = editor.Search.fg,
            other_win_hl_color = editor.Search.bg,
        }
    end,
}
