-- Category: organization
-- Search for To-Dos in project commets easily

return {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    cmd = { 'TodoTelescope', 'TodoQuickFix' },
    setup = function()
        -- Setup keybindings
        require('which-key').register({
            t = {
                function()
                    vim.cmd.TodoQuickFix()
                end,
                'Show all project TODOs (Quickfix)',
            },
            T = {
                function()
                    vim.cmd.TodoTelescope()
                end,
                'Search all project TODOs (Telescope)',
            },
        }, {
            prefix = '<leader>p',
        })
    end,
    config = function()
        require('todo-comments').setup {
            highlight = { pattern = [[.*<(KEYWORDS)\s*:?]] },
            search = { pattern = [[\b(KEYWORDS):?\b]] },
        }
    end,
}
