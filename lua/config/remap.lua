local setk = vim.keymap.set

--- Sets clipboard to a string value, announcing it on the echo line.
--- @param value string
local function set_clipboard(value)
    vim.fn.setreg('+', value)
    vim.cmd { cmd = 'echo', args = { '\'Copied to clipboard: "' .. value .. '"\'' } }
end

-- Space as leader key
vim.g.mapleader = ' '

setk('n', '<leader>o-', vim.cmd.Ex, { desc = 'Open file directory' })

setk('n', '<leader>ot', vim.cmd.terminal, { desc = 'Open a terminal' })

setk('n', '<leader>bd', vim.cmd.bdelete, { desc = 'Close current buffer' })

setk('n', '<leader>br', vim.cmd.edit, { desc = 'Reload buffer' })

setk('n', '<C-l>', vim.cmd.nohlsearch, { desc = 'Clear current highlight' })

setk('n', '<leader>cx', vim.diagnostic.setloclist, { desc = 'Preview diagnostics for file' })

setk('n', '<leader>cX', vim.diagnostic.setqflist, { desc = 'Preview diagnostics for workspace' })

setk('n', '<leader>fy', function()
    local file_path = vim.fn.expand '%:po'
    set_clipboard(file_path)
end, { desc = 'Copy filepath to clipboard' })

setk('n', '<leader>fY', function()
    local project_file_path = vim.fn.expand '%:p:.'
    set_clipboard(project_file_path)
end, { desc = 'Copy project filepath to clipboard' })

-- Keep jumps centered
setk('n', '<C-u>', '<C-u>zz', { desc = 'Jump half-page up' })
setk('n', '<C-d>', '<C-d>zz', { desc = 'Jump half-page down' })
setk('n', '<C-b>', '<C-u>zz', { desc = 'Jump page up' })
setk('n', '<C-f>', '<C-f>zz', { desc = 'Jump page down' })
setk('n', 'n', 'nzzzv', { desc = 'Repeat last pattern' })
setk('n', 'N', 'Nzzzv', { desc = 'Repeat last pattern backwards' })
