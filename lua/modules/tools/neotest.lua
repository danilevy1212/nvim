-- Test runner framework

return {
    'nvim-neotest/neotest',
    init = function()
        local group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'neotest', {
            clear = false,
        })

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
            function()
                require('neotest').summary.toggle()
            end,
            '<leader>oT',
            'Test summary',
        },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        'haydenmeade/neotest-jest',
    },
    config = function()
        require('neotest').setup {
            adapters = {
                require 'neotest-jest' {},
            },
            summary = {
                animated = true,
                enabled = true,
                expand_errors = true,
                follow = true,
                mappings = {
                    attach = 'a',
                    clear_marked = 'M',
                    clear_target = 'T',
                    debug = 'd',
                    debug_marked = 'D',
                    expand = { '<CR>', '<2-LeftMouse>' },
                    expand_all = 'e',
                    jumpto = 'i',
                    mark = 'm',
                    next_failed = 'J',
                    output = 'o',
                    prev_failed = 'K',
                    run = 'r',
                    run_marked = 'R',
                    short = 'O',
                    stop = 'u',
                    target = 't',
                    watch = 'w',
                },
                open = 'botright vsplit | vertical resize 50',
            },
        }
    end,
}
