-- Category: core

-- Small window before the popup apears
seto('timeoutlen', 200)

return {
    'folke/which-key.nvim',
    config = function()
        -- Make which-key helper available to all other modules
        local wk = require 'which-key'

        -- Use defaults
        wk.setup()

        -- Setup basic labels
        wk.register({
            b = { 'Buffer' },
            c = { 'Code ' },
            f = { 'File' },
            h = {
                name = 'Help',
                K = {
                    function()
                        vim.ui.select({
                            'insert',
                            'normal',
                            'visual',
                            'select',
                            'select_x',
                            'operator',
                            'replace',
                            'command',
                            'terminal',
                        }, {
                            prompt = 'Show keymap for which mode?',
                        }, function(choice)
                            -- From `which-key.nvim/lua/which-key/util.lua::check_mode`
                            local choice_to_mode = {
                                insert = 'i',
                                visual = 'v',
                                terminal = 't',
                                operator = 'o',
                                select = 's',
                                select_x = 'x',
                                replace = 'R',
                                command = 'c',
                            }

                            wk.show_command('', choice_to_mode[choice])
                        end)
                    end,
                    'Buffer keymaps',
                },
            },
            o = { 'Open' },
            p = { 'Project' },
            s = { 'Search' },
        }, { prefix = '<leader>' })

        -- Register the default terminal maps
        wk.register({
            ['<C-N>'] = { 'Return to normal mode' },
            ['<C-O>'] = { 'Execute one normal mode command' },
        }, {
            prefix = [[<C-\>]],
            mode = 't',
        })
    end,
}
