---@diagnostic disable: undefined-global
--- @module 'opencode'
--- @module 'snacks'

--- @type LazyPluginSpec
local M = {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim', opts = { terminal = {} } },
    init = function()
        require('which-key').add {
            { '<leader>oc', desc = 'Opencode' },
        }
    end,
    config = function()
        ---@type opencode.Opts
        local opts = {
            events = {
                enabled = true,
                reload = true,
                permissions = {
                    enabled = false,
                },
            },
            provider = {
                enabled = 'snacks',
                snacks = {},
            },
        }

        vim.api.nvim_create_autocmd('User', {
            group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'OpencodeAutoReload', { clear = true }),
            pattern = 'OpencodeEvent:permission.replied',
            callback = function(_)
                vim.schedule(function()
                    vim.cmd 'checktime'
                end)
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
            '<leader>ocA',
            function()
                require('opencode').ask('@this', {
                    clear = true,
                    submit = true,
                })
            end,
            desc = 'Ask opencode in buffer',
            mode = 'n',
        },
        {
            '<leader>ocA',
            function()
                require('opencode').ask('@this', {
                    clear = true,
                    submit = true,
                })
            end,
            desc = 'Ask opencode about selection in buffer',
            mode = 'v',
        },
        {
            '<leader>oca',
            function()
                require('opencode').prompt('@this', {})
            end,
            desc = 'Ask opencode',
            mode = 'n',
        },
        {
            '<leader>oca',
            function()
                require('opencode').prompt('@this', {})
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
                require('opencode').command 'session.new'
            end,
            desc = 'New session',
        },
        {
            '<leader>ocy',
            function()
                require('opencode').command 'messages.copy'
            end,
            desc = 'Copy last message',
        },
        {
            '<leader>ocI',
            function()
                vim.schedule(function()
                    local opencode = require 'opencode'
                    opencode.command 'session.interrupt'
                    -- Second interrupt required to actually stop
                    vim.schedule(function()
                        opencode.command 'session.interrupt'
                    end)
                end)
            end,
            desc = 'Interrupt the session',
        },
        {
            '<leader>ocS',
            function()
                vim.schedule(function()
                    require('opencode').select_session()
                end)
            end,
            desc = 'Select a session',
        },
    },
}

return M
