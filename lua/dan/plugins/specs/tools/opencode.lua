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
            on_send = function()
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
                ['Commit Message'] = {
                    prompt = 'Write a commit message for the changes staged. Based the formatting on the history of the repository. If it is one line, write a single line commit message. If it is multiple lines, write a multi-line commit message.',
                    description = 'Commit message for git diff --staged',
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
