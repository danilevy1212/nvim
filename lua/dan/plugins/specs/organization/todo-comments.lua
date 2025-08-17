-- Search for To-Dos in project comments

---@type LazyPluginSpec
local M = {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTelescope', 'TodoQuickFix' },
    event = { 'BufRead' },
    init = function()
        -- Setup keybindings
        require('which-key').add {
            {
                '<leader>pt',
                function()
                    vim.cmd.TodoQuickFix()
                end,
                desc = 'Show all project TODOs (Quickfix)',
            },
            {
                '<leader>pT',
                function()
                    vim.cmd.TodoTelescope()
                end,
                desc = 'Search all project TODOs (Telescope)',
            },
        }
    end,
    config = function()
        require('todo-comments').setup {
            highlight = { pattern = [[.*<(KEYWORDS)\s*:?]] },
            search = { pattern = [[\b(KEYWORDS):?\b]] },
        }
    end,
}

return M
