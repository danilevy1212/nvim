---@diagnostic disable: undefined-global
--- @module 'agentic'

--- @type LazyPluginSpec
local M = {
    'carlos-algms/agentic.nvim',
    init = function()
        require('which-key').add {
            { '<leader>oa', desc = 'Agentic' },
        }
    end,
    opts = function(_, opts)
        if require('dan.lib.os').is_macos() then
            opts.provider = 'claude-agent-acp'
        else
            opts.provider = 'opencode-acp'
        end
        opts.diff_preview = {
            enabled = true,
            layout = 'inline', -- "split" or "inline"
            center_on_navigate_hunks = true,
        }
        --- Requires an ACP provider CLI on PATH (e.g. `claude-agent-acp`).
        --- This plugin does not install binaries for you.
        require('dan.lib.mason').ensure_installed { 'claude-agent-acp' }
    end,
    keys = {
        {
            '<leader>oat',
            function()
                require('agentic').toggle()
            end,
            desc = 'Toggle Agentic chat',
            mode = { 'n', 'v' },
        },
        {
            '<leader>oaa',
            function()
                require('agentic').add_selection_or_file_to_context()
            end,
            desc = 'Add file/selection to context',
            mode = { 'n', 'v' },
        },
        {
            '<leader>oan',
            function()
                require('agentic').new_session()
            end,
            desc = 'New session',
        },
        {
            '<leader>oaS',
            function()
                require('agentic').restore_session()
            end,
            desc = 'Select a session',
        },
        {
            '<leader>oaI',
            function()
                require('agentic').stop_generation()
            end,
            desc = 'Interrupt generation',
        },
        {
            '<leader>oap',
            function()
                require('agentic').switch_provider()
            end,
            desc = 'Switch provider',
        },
    },
}

return M
