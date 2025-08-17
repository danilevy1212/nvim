--- Pick a window and returns the window id of the picked window
local function pick_current_window()
    vim.api.nvim_set_current_win(require('window-picker').pick_window() or vim.api.nvim_get_current_win())
end

local function switch_window()
    -- Need to exit terminal mode to pick a window
    if vim.api.nvim_get_mode().mode == 't' then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', true)
        -- Wait for the mode to change before picking a window
        vim.api.nvim_create_autocmd('ModeChanged', {
            buffer = vim.api.nvim_get_current_buf(),
            once = true,
            callback = pick_current_window,
        })
    else
        pick_current_window()
    end
end

--- @type LazyPluginSpec
local M = {
    's1n7ax/nvim-window-picker',
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
            switch_window,
            mode = { 'n' },
            desc = 'Pick a window',
        },
        {
            '<A-S-w><A-S-w>',
            switch_window,
            mode = { 'i', 't' },
            desc = 'Pick a window in terminal mode',
        },
    },
}

return M
