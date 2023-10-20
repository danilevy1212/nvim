-- Search for To-Dos in project comments

return {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTelescope', 'TodoQuickFix' },
    event = { 'BufRead' },
    init = function()
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
