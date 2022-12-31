-- Category: organization
-- Search for To-Dos in project commets easily

-- Setup keybindings
vim.keymap.set('n', '<leader>pt', function()
    vim.cmd.TodoQuickFix()
end, { desc = 'Show all project TODOs in quickfix' })
vim.keymap.set('n', '<leader>pT', function()
    vim.cmd.TodoTelescope()
end, { desc = 'Search all project TODOs' })

return {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    cmd = { 'TodoTelescope', 'TodoQuickFix' },
    config = function()
        require('todo-comments').setup {
            highlight = { pattern = [[.*<(KEYWORDS)\s*:?]] },
            search = { pattern = [[\b(KEYWORDS):?\b]] },
        }
    end,
}
