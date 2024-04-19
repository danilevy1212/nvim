---@diagnostic disable: missing-fields
---@type overseer.Task
local Task = {
    name = 'Connect to work VPN',
    builder = function()
        return {
            cmd = 'awsvpnclient start --config ~/.config/vpn/vpn-config.ovpn',
        }
    end,
    condition = {
        callback = function()
            return vim.fn.executable 'awsvpnclient' == 1
        end,
    },
}

return Task
