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
            require('which-key').add {
                {
                    mode = { 'n', 'v' },
                    { '<leader>g', group = 'git' },
                    {
                        '<leader>gg',
                        function()
                            vim.cmd [[G]]
                        end,
                        desc = 'status',
                    },
                    {
                        '<leader>gb',
                        function()
                            vim.cmd [[GBrowse]]
                        end,
                        desc = 'open remote in browser',
                    },
                    {
                        '<leader>gB',
                        function()
                            vim.cmd [[GBrowse!]]
                        end,
                        desc = 'copy browser link to clipboard',
                    },
                },
            }
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
                    wk.add {
                        { '<leader>gp', gs.preview_hunk, desc = 'Preview hunk', buffer = bufnr },
                        {
                            '<leader>gr',
                            '<Cmd>Gitsigns reset_hunk<CR>',
                            desc = 'Reset hunk',
                            buffer = bufnr,
                            mode = { 'n', 'v' },
                        },
                    }

                    -- Navigation
                    wk.add {
                        {
                            ']c',
                            function()
                                vim.schedule(function()
                                    gs.nav_hunk { wrap = true }
                                end)
                            end,
                            desc = 'Next hunk',
                            buffer = bufnr,
                        },
                        {
                            '[c',
                            function()
                                vim.schedule(function()
                                    gs.nav_hunk { wrap = true, reverse = true }
                                end)
                            end,
                            desc = 'Previous hunk',
                            buffer = bufnr,
                        },
                    }

                    -- Text object
                    wk.add {
                        {
                            'ih',
                            '<Cmd><C-U>Gitsigns select_hunk<CR>',
                            desc = 'Inner hunk',
                            buffer = bufnr,
                            mode = { 'o', 'x' },
                        },
                    }
                end,
            }
        end,
    },
}

return M
