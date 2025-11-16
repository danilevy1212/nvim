--- @module 'opencode'
--- @module 'snacks'

--- @type LazyPluginSpec
local M = {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    cond = function()
        return not require('dan.lib.os').is_workstation()
    end,
    init = function()
        require('which-key').add {
            { '<leader>oc', desc = 'Opencode' },
        }
    end,
    config = function()
        ---@type opencode.Opts
        local opts = {
            permissions = {
                enabled = false,
            },
            provider = {
                enabled = 'snacks',
                snacks = {},
            },
            auto_reload = true,
            prompts = {
                ['commit_message'] = {
                    prompt = [[Analyze the staged (cached) changes and create an appropriate commit message. Follow this process:

1. First, examine the staged changes using `git diff --staged` to understand what will be committed
2. Review recent commit history to understand the repository's commit message style and scoping conventions
3. Analyze the nature of the staged changes (new feature, bug fix, refactor, docs, etc.)
4. Draft a commit message that follows the established patterns

After writing the commit message, automatically execute the commit using the message you created.

Use the repository's existing commit message format. Pay attention to:
- Scoping (if used in this repo)
- Line length limits
- Multi-line format when appropriate
- Conventional commit patterns (if used)]],
                    submit = true,
                },
            },
        }

        --- HACK
        --- Auto-reload buffers when opencode makes changes
        vim.api.nvim_create_autocmd('User', {
            group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'OpencodeAutoReload', { clear = true }),
            pattern = 'OpencodeEvent',
            callback = function(args)
                local event = args.data.event
                if event.type == 'permission.replied' and require('opencode.config').opts.auto_reload then
                    vim.schedule(function()
                        vim.cmd 'checktime'
                    end)
                end
            end,
            desc = 'Reload buffers edited by `opencode`',
        })

        vim.g.opencode_opts = opts
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
                require('opencode').prompt('@this', {
                    append = true,
                })
            end,
            desc = 'Ask opencode',
            mode = 'n',
        },
        {
            '<leader>oca',
            function()
                require('opencode').prompt('@this', {
                    append = true,
                })
            end,
            desc = 'Ask opencode about selection',
            mode = 'v',
        },
        {
            '<leader>ocp',
            function()
                require('opencode').select()
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
