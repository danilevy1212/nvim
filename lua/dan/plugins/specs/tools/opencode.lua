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
        ---@type opencode.Opts
        local opts = {
            ---@type snacks.terminal.Opts
            terminal = {
                win = {
                    enter = true,
                },
            },
            auto_fallback_to_embedded = true,
            auto_reload = true,
            -- Auto-save all modified buffers within current working directory before sending to opencode
            on_submit = function()
                for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                    local buf_data = vim.bo[bufnr]
                    if
                        vim.api.nvim_buf_is_loaded(bufnr)
                        and buf_data.modified
                        and buf_data.buftype == ''
                        and buf_data.buflisted
                    then
                        local bufname = vim.api.nvim_buf_get_name(bufnr)
                        if bufname ~= '' then
                            local abs_bufname = vim.fn.fnamemodify(bufname, ':p')
                            local abs_cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':p')
                            if vim.startswith(abs_bufname, abs_cwd) then
                                vim.api.nvim_buf_call(bufnr, function()
                                    vim.cmd 'silent write'
                                end)
                            end
                        end
                    end
                end

                -- Call the original on_send
                pcall(require('opencode.terminal').show_if_exists)
            end,
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
                    description = 'Analyze staged changes and commit with generated message',
                },
            },
        }

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
