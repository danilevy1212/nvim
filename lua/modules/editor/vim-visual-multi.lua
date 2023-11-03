-- Multiple cursors, based on visual selection

local g = vim.g

---@type LazyPluginSpec
local M = {
    'mg979/vim-visual-multi',
    init = function()
        vim.api.nvim_set_var('VM_maps', {
            ['Find Under'] = '<M-d>',
            ['Find Subword Under'] = '<M-d>',
            ['I Next'] = ''
        })

        g.VM_quit_after_leaving_insert_mode = 1
        g.VM_set_statusline = 0
        g.VM_silent_exit = 1
        g.VM_theme = 'nord'
        g.VM_highlight_matches = ''
        g.VM_single_mode_maps = 0
    end,
    event = 'BufRead',
}

return M
