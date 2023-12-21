-- This plugin is the pure lua replacement for github/copilot.vim.

---@type LazyPluginSpec
local M = {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
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

        --- Disable copilot for `json` files, except for `package.json`, `*.config.*`, or dot files
        local function json_enabled()
            local name = vim.api.nvim_buf_get_name(0)
            return string.match(name, 'package%.json$') or string.match(name, '%.config%.') or string.match(name, '^%.')
        end

        require('copilot').setup {
            suggestion = {
                auto_trigger = true,
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
                json = json_enabled,
                jsonc = json_enabled,
            },
            copilot_node_command = get_node_command(),
        }
    end,
}

return M
