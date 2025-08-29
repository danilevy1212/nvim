---@diagnostic disable: missing-fields

---@type overseer.Task
local Task = {
    name = 'Update nixos flake',
    builder = function()
        return {
            cmd = { 'nix', 'flake', 'update' },
            cwd = '/etc/nixos',
            components = { { 'on_complete_notify' }, { 'open_output', focus = true, on_result = 'always' } },
        }
    end,
    condition = {
        callback = require('dan.lib.os').is_nixos,
    },
}

return Task
