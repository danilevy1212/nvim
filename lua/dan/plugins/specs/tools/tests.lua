-- Test runner framework

---@type LazyPluginSpec
local M = {
    'nvim-neotest/neotest',
    init = function()
        local group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'neotest', {})

        -- Create the keybindings in files that support running tests.
        vim.api.nvim_create_autocmd('BufReadPost', {
            group = group,
            pattern = { '*.spec.js', '*.spec.ts' },
            --- @param ev { buf: number }
            callback = function(ev)
                require('which-key').add {
                    {
                        '<leader>cTr',
                        function()
                            require('neotest').run.run()
                        end,
                        desc = 'Run closest test',
                        buffer = ev.buf,
                    },
                    {
                        '<leader>cTf',
                        function()
                            require('neotest').run.run(vim.fn.expand '%')
                        end,
                        desc = 'Run file',
                        buffer = ev.buf,
                    },
                    {
                        '<leader>cTo',
                        function()
                            require('neotest').output_panel.toggle()
                        end,
                        desc = 'Output panel',
                        buffer = ev.buf,
                    },
                    {
                        '<leader>cTs',
                        function()
                            require('neotest').summary.toggle()
                        end,
                        desc = 'Summary',
                        buffer = ev.buf,
                    },
                }
            end,
        })
    end,
    keys = {
        {
            '<leader>oT',
            function()
                require('neotest').summary.toggle()
            end,
            desc = 'Test summary',
        },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        'haydenmeade/neotest-jest',
        'stevearc/overseer.nvim',
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('neotest').setup {
            consumers = {
                ---@diagnostic disable-next-line: assign-type-mismatch
                overseer = require 'neotest.consumers.overseer',
            },
        }
    end,
}

return M
