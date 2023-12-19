-- This plugin is the pure lua replacement for github/copilot.vim.

local function is_nixos()
    local os_release = vim.trim(vim.fn.system 'grep "^ID=" /etc/os-release | cut -d= -f2')

    return os_release == 'nixos'
end

local function get_node_command()
    if is_nixos() then
        return '/etc/profiles/per-user/dlevym/bin/node'
    else
        --- NOTE  Use whatever node version is available in the system.
        ---       This is OK since I am unlikely to use old / deprecated node versions in non NixOS systems.
        return 'node'
    end
end

---@type LazyPluginSpec
local M = {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        local cmp = require 'cmp'

        cmp.event:on('menu_opened', function()
            ---@diagnostic disable-next-line: inject-field
            vim.b.copilot_suggestion_hidden = true
        end)

        cmp.event:on('menu_closed', function()
            ---@diagnostic disable-next-line: inject-field
            vim.b.copilot_suggestion_hidden = false
        end)

        require('copilot').setup {
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = '<Right>',
                },
            },
            panel = {
                auto_refresh = true,
                layout = {
                    position = 'right',
                    ratio = 0.25,
                },
            },
            filetypes = {
                --- Enable copilot for all filetypes by default
                ['*'] = true,
                -- Disable copilot for .env files but not for `.envrc` files from direnv
                sh = function()
                    return not string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env(?!rc).*')
                end,
            },
            copilot_node_command = get_node_command(),
        }
    end,
}

return M
