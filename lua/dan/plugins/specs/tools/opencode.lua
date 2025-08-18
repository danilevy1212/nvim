--- @type LazyPluginSpec
local M = {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    init = function()
        require('which-key').add {
            ['<leader>oc'] = { name = 'Opencode' },
        }
    end,
    config = function()
        ---@param args string[]
        local function make_git_diff_context(args)
            return function()
                local cmd = vim.list_extend({ 'git' }, args)
                local result = vim.fn.system(vim.fn.join(cmd, ' '))
                if result and result ~= '' then
                    return result
                end
                return nil
            end
        end

        local git_diff_staged = make_git_diff_context { '--no-pager', 'diff', '--cached' }
        local git_diff_develop = make_git_diff_context {
            '--no-pager',
            'diff',
            '--no-ext-diff',
            'develop',
        }

        ---@type opencode.Config
        local opts = {
            terminal = {
                win = {
                    enter = true,
                },
            },
            auto_fallback_to_embedded = true,
            auto_reload = true,
            contexts = {
                ['@diff-staged'] = {
                    value = git_diff_staged,
                    description = 'Git diff staged',
                },
                ['@diff-develop'] = {
                    value = git_diff_develop,
                    description = 'Git diff with develop',
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
