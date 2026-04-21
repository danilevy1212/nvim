---@diagnostic disable: missing-fields

---@type overseer.Task
local Task = {
    name = 'Update nix-darwin flake',
    builder = function()
        return {
            cmd = { 'nix', 'flake', 'update' },
            cwd = vim.env['HOME'] .. '/.config/darwin',
            components = {
                'default',
                'on_complete_notify',
            },
        }
    end,
    condition = {
        callback = require('dan.lib.os').is_macos,
    },
}

return Task
