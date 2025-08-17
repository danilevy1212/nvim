-- A task runner and job management plugin for Neovim

---@type LazyPluginSpec
local M = {
    'stevearc/overseer.nvim',
    init = function()
        require('which-key').add {
            { '<Leader>oo', group = 'Overseer' },
            { '<Leader>oot', '<cmd>OverseerToggle<CR>', desc = 'Overseer Toggle', mode = 'n' },
            { '<Leader>oor', '<cmd>OverseerRun<CR>', desc = 'Overseer Run', mode = 'n' },
            { '<Leader>ooc', '<cmd>OverseerRunCmd<CR>', desc = 'Overseer Run a command', mode = 'n' },
        }
    end,
    cmd = {
        'OverseerOpen',
        'OverseerClose',
        'OverseerToggle',
        'OverseerSaveBundle',
        'OverseerLoadBundle',
        'OverseerDeleteBundle',
        'OverseerRunCmd',
        'OverseerRun',
        'OverseerInfo',
        'OverseerBuild',
        'OverseerQuickAction',
        'OverseerTaskAction',
        'OverseerClearCache',
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('overseer').setup {
            templates = {
                'builtin',
                -- Nixos related tasks
                'dan.nixos',
                -- Doom emacs related tasks
                'dan.doom',
                -- Work related tasks
                'dan.work',
            },
            dap = false,
        }
    end,
}

return M
