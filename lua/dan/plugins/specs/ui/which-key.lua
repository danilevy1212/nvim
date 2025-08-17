-- Displays a popup with possible key bindings of the command you started typing.

---@type LazyPluginSpec
local M = {
    'folke/which-key.nvim',
    dependencies = {
        --- Load this before which-key.nvim to prevent collisions
        'gbprod/cutlass.nvim',
    },
    opts = {
        delay = 200,
    },
    config = function()
        local wk = require 'which-key'

        -- Setup basic labels
        wk.add {
            { '<leader>b', desc = 'Buffer' },
            { '<leader>c', group = 'Code' },
            { '<leader>cT', desc = 'Test' },
            { '<leader>f', desc = 'File' },
            { '<leader>h', group = 'Help' },
            {
                '<leader>hK',
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
                        wk.show { mode = choice_to_mode[choice] }
                    end)
                end,
                desc = 'Buffer keymaps',
            },
            { '<leader>o', desc = 'Open' },
            { '<leader>p', desc = 'Project' },
            { '<leader>s', desc = 'Search' },
        }

        -- Register the default terminal maps
        wk.add {
            { '<C-\\><C-N>', desc = 'Return to normal mode', mode = 't' },
            { '<C-\\><C-O>', desc = 'Execute one normal mode command', mode = 't' },
        }
    end,
}

return M
