-- TODO  Replace with https://github.com/milanglacier/minuet-ai.nvim
-- This plugin is the pure lua replacement for github/copilot.vim.

---@type LazyPluginSpec
local COPILOT = {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        local function get_node_command()
            if require('dan.lib.os').is_nixos() then
                return '/etc/profiles/per-user/dlevym/bin/node'
            else
                --- NOTE  Use whatever node version is available in the system.
                ---       This is OK since I am unlikely to use old / deprecated node versions in non NixOS systems.
                return 'node'
            end
        end

        require('copilot').setup {
            suggestion = {
                auto_trigger = false,
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
                -- Disable copilot for `.env` files but not for `.envrc` files from direnv
                sh = function()
                    local file_basename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
                    return file_basename == '.envrc' or not string.match(file_basename, '^%.env.*')
                end,
                --- Disable copilot for `csv` files
                csv = false,
                --- Disable copilot for any configuration files
                conf = false,
            },
            copilot_node_command = get_node_command(),
        }
    end,
}

return {
    COPILOT,
}
