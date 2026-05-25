---@diagnostic disable: missing-fields

---@type overseer.TemplateFileDefinition
local Task = {
    name = 'Update nixos flake',
    builder = function()
        return {
            cmd = { 'nix', 'flake', 'update' },
            cwd = '/etc/nixos',
            components = {
                'default',
                'on_complete_notify',
            },
        }
    end,
    hide = not require('dan.lib.os').is_nixos(),
}

return Task
