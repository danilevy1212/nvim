--- @type LazyPluginSpec
local M = {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    ---@type opencode.Config
    opts = {},
    keys = {
        {
            '<leader>oc',
            desc = 'Opencode',
        },
        {
            '<leader>oct',
            function()
                require('opencode').toggle()
            end,
            desc = 'Toggle embedded opencode',
        },
        {
            '<leader>oca',
            function()
                require('opencode').ask()
            end,
            desc = 'Ask opencode',
            mode = 'n',
        },
        {
            '<leader>oca',
            function()
                require('opencode').ask '@selection: '
            end,
            desc = 'Ask opencode about selection',
            mode = 'v',
        },
        {
            '<leader>ocp',
            function()
                require('opencode').select_prompt()
            end,
            desc = 'Select prompt',
            mode = { 'n', 'v' },
        },
        {
            '<leader>ocn',
            function()
                require('opencode').command 'session_new'
            end,
            desc = 'New session',
        },
        {
            '<leader>ocy',
            function()
                require('opencode').command 'messages_copy'
            end,
            desc = 'Copy last message',
        },
        -- { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up', },
        -- { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
    },
}

return M
