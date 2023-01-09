-- Configuration: tools

return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead' },
    config = function()
        require('gitsigns').setup {
            on_attach = function(bufnr)
                local gs = require 'gitsigns'
                local wk = require 'which-key'

                -- Leader keymaps
                wk.register({
                    p = { gs.preview_hunk, 'Preview hunk' },
                }, {
                    prefix = '<leader>g',
                    buffer = bufnr,
                })
                vim.keymap.set(
                    { 'n', 'v' },
                    '<leader>gr',
                    ':Gitsigns reset_hunk<CR>',
                    { desc = 'Reset hunk', buffer = bufnr }
                )

                -- Navigation
                wk.register({
                    [']'] = {
                        name = 'Next',
                        c = {
                            function()
                                if vim.wo.diff then
                                    return ']c'
                                end
                                vim.schedule(function()
                                    gs.next_hunk()
                                end)
                                return '<Ignore>'
                            end,
                            'Next hunk',
                        },
                    },
                    ['['] = {
                        name = 'Previous',
                        c = {
                            function()
                                if vim.wo.diff then
                                    return '[c'
                                end
                                vim.schedule(function()
                                    gs.prev_hunk()
                                end)
                                return '<Ignore>'
                            end,
                            'Previous hunk',
                        },
                    },
                }, {
                    buffer = bufnr,
                })

                -- Text object
                vim.keymap.set(
                    { 'o', 'x' },
                    'ih',
                    ':<C-U>Gitsigns select_hunk<CR>',
                    { desc = 'Inner hunk', buffer = bufnr }
                )
            end,
        }
    end,
}
