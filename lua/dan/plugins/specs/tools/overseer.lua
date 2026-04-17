-- A task runner and job management plugin for Neovim

---@type LazyPluginSpec
local M = {
    'stevearc/overseer.nvim',
    version = '2.x.x',
    init = function()
        require('which-key').add {
            { '<Leader>oo', group = 'Overseer' },
            { '<Leader>oot', '<cmd>OverseerToggle<CR>', desc = 'Overseer Toggle', mode = 'n' },
            { '<Leader>oor', '<cmd>OverseerRun<CR>', desc = 'Overseer Run', mode = 'n' },
            { '<Leader>ooc', '<cmd>OverseerRunShell<CR>', desc = 'Overseer Run a command', mode = 'n' },
        }
    end,
    cmd = {
        'OverseerOpen',
        'OverseerClose',
        'OverseerToggle',
        'OverseerRun',
        'OverseerShell',
        'OverseerTaskAction',
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('overseer').setup {
            templates = {
                'builtin',
                -- Nixos related tasks
                'dan.nixos',
                -- Homelab maintanence
                'dan.homelab',
            },
            dap = false,
        }
    end,
}

return M
