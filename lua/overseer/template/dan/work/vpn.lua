---@diagnostic disable: missing-fields
---@type overseer.Task
local Task = {
    name = 'Connect to work VPN',
    builder = function()
        return {
            cmd = 'pkexec awsvpnclient start --config ~/.config/vpn/vpn-config.ovpn',
            components = {
                'default',
                'on_complete_notify',
            },
        }
    end,
    condition = {
        callback = function()
            return vim.fn.executable 'awsvpnclient' == 1
        end,
    },
}

return Task
