-- Plugins for `git` integration

---@type LazyPluginSpec[]
local M = {
    --- Magit lesser brother
    {
        'tpope/vim-fugitive',
        cmd = { 'Git', 'G', 'GBrowse' },
        dependencies = {
            -- Make GBrowse work on gitlab
            {
                'shumphrey/fugitive-gitlab.vim',
            },
            --  and github
            {
                'tpope/vim-rhubarb',
            },
        },
        init = function()
            --- TODO Move this to `keys` property
            require('which-key').register({
                g = {
                    name = 'git',
                    g = {
                        function()
                            vim.cmd [[G]]
                        end,
                        'status',
                    },
                    b = {
                        function()
                            vim.cmd [[GBrowse]]
                        end,
                        'open remote in browser',
                    },
                    B = {
                        function()
                            vim.cmd [[GBrowse!]]
                        end,
                        'copy browser link to clipboard',
                    },
                },
            }, {
                prefix = '<leader>',
                mode = { 'n', 'v' },
            })
        end,
    },
    --- Make buffers `git` aware
    {
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
                        '<Cmd>Gitsigns reset_hunk<CR>',
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
                        '<Cmd><C-U>Gitsigns select_hunk<CR>',
                        { desc = 'Inner hunk', buffer = bufnr }
                    )
                end,
            }
        end,
    },
}

return M
