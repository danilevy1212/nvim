---@diagnostic disable: missing-fields

---@type overseer.Task
local Task = {
    name = 'Upgrade nixos',
    params = {
        password = {
            type = 'string',
            description = 'Root password for sudo',
            optional = false,
            name = 'Root password',
        },
    },
    builder = function(params)
        return {
            cmd = 'echo \'' .. params.password .. '\' | sudo -S nixos-rebuild switch',
            cwd = '/etc/nixos',
        }
    end,
    condition = {
        callback = require('dan.lib.os').is_nixos,
    },
}

return Task
