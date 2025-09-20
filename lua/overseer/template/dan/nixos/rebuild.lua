---@diagnostic disable: missing-fields

---@type overseer.Task
local Task = {
    name = 'Rebuild nixos',
    builder = function()
        return {
            cmd = 'rm -f ~/.gtkrc-2.0.backup ~/.gtkrc-2.0 && pkexec nixos-rebuild -L switch',
            cwd = '/etc/nixos',
            components = {
                'default',
                'on_complete_notify',
            },
        }
    end,
    condition = {
        callback = require('dan.lib.os').is_nixos,
    },
}

return Task
