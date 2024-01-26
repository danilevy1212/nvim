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
                require('which-key').register({
                    r = {
                        function()
                            require('neotest').run.run()
                        end,
                        'Run closest test',
                    },
                    f = {
                        function()
                            require('neotest').run.run(vim.fn.expand '%')
                        end,
                        'Run file',
                    },
                    o = {
                        function()
                            require('neotest').output_panel.toggle()
                        end,
                        'Output panel',
                    },
                    s = {
                        function()
                            require('neotest').summary.toggle()
                        end,
                        'Summary',
                    },
                }, {
                    prefix = '<leader>cT',
                    buffer = ev.buf,
                })
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
    },
    config = function()
        require('neotest').setup {}
    end,
}

return M
