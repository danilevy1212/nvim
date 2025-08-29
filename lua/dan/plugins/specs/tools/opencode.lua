--- @type LazyPluginSpec
local M = {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    init = function()
        require('which-key').add {
            { '<leader>oc', desc = 'Opencode' },
        }
    end,
    config = function()
        ---@type opencode.Config
        local opts = {
            terminal = {
                win = {
                    enter = true,
                },
            },
            auto_fallback_to_embedded = true,
            auto_reload = true,
            prompts = {
                ['Commit Message'] = {
                    prompt = 'Write a commit message for the changes staged. Based the formatting on the history of the repository. If it is one line, write a single line commit message. If it is multiple lines, write a multi-line commit message.',
                    description = 'Commit message for git diff --staged',
                },
            },
        }

        require('opencode').setup(opts)
    end,

    keys = {
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
    },
}

return M
