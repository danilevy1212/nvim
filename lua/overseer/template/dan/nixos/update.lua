---@diagnostic disable: missing-fields

---@type overseer.Task
local Task = {
    name = 'Update nixos flake',
    builder = function()
        return {
            cmd = { 'nix', 'flake', 'update', '/etc/nixos' },
            cwd = '/etc/nixos',
        }
    end,
    condition = {
        callback = require('dan.lib.os').is_nixos,
    },
}

return Task
