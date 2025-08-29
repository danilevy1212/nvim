---@diagnostic disable: missing-fields

---@type overseer.Task
local Task = {
    name = 'Upgrade nixos',
    builder = function()
        return {
            cmd = 'sudo nixos-rebuild switch',
            cwd = '/etc/nixos',
            components = {
                { 'on_complete_notify' },
                { 'open_output', direction = 'tab', focus = true, on_result = 'always' },
            },
        }
    end,
    condition = {
        callback = require('dan.lib.os').is_nixos,
    },
}

return Task
