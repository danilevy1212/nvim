local setk = vim.keymap.set

setk('n', '<leader>o-', vim.cmd.Ex, { desc = 'Open file directory' })
setk('n', '<leader>bd', vim.cmd.bdelete, { desc = 'Close current buffer' })
setk('n', '<leader>br', vim.cmd.edit, { desc = 'Reload buffer' })
setk('n', '<leader>bR', function()
    require('dan.lib.buffer').toggle_buffer_modifiable()
end, { desc = 'Toggle buffer modifiable' })

setk('n', '<C-l>', function()
    -- Stop highlight
    vim.cmd.nohlsearch()
    -- Redraw cmdline
    vim.cmd 'echon ""'
end, { desc = 'Clear current highlight' })

--- Clipboard mappings
setk('n', '<leader>fy', function()
    local file_path = vim.fn.expand '%:po'
    require('dan.lib.clipboard').set_clipboard(file_path)
end, { desc = 'Copy filepath to clipboard' })
setk('n', '<leader>fY', function()
    local project_file_path = vim.fn.expand '%:p:.'
    require('dan.lib.clipboard').set_clipboard(project_file_path)
end, { desc = 'Copy project filepath to clipboard' })

-- Keep jumps centered
setk('n', '<C-u>', '<C-u>zz', { desc = 'Jump half-page up' })
setk('n', '<C-d>', '<C-d>zz', { desc = 'Jump half-page down' })
setk('n', '<C-b>', '<C-u>zz', { desc = 'Jump page up' })
setk('n', '<C-f>', '<C-f>zz', { desc = 'Jump page down' })
setk('n', 'n', 'nzzzv', { desc = 'Repeat last pattern' })
setk('n', 'N', 'Nzzzv', { desc = 'Repeat last pattern backwards' })
