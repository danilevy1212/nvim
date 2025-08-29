---@diagnostic disable: missing-fields
---@type overseer.Task
local Task = {
    name = 'Connect to work VPN',
    builder = function()
        return {
            cmd = 'awsvpnclient start --config ~/.config/vpn/vpn-config.ovpn',
            components = {
                { 'on_complete_notify' },
                { 'open_output', direction = 'tab', focus = true, on_start = 'always' },
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
