---@diagnostic disable: missing-fields

---@type overseer.Task
local Task = {
    name = 'Upgrade nixos',
    builder = function()
        return {
            cmd = 'rm -f ~/.gtkrc-2.0.backup ~/.gtkrc-2.0 && sudo nixos-rebuild switch',
            cwd = '/etc/nixos',
            components = {
                'default',
                'on_complete_notify',
                { 'open_output', direction = 'tab', focus = true, on_result = 'always' },
            },
        }
    end,
    condition = {
        callback = require('dan.lib.os').is_nixos,
    },
}

return Task
