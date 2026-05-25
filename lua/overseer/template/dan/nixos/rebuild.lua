---@diagnostic disable: missing-fields

---@type overseer.TemplateFileDefinition
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
    hide = not require('dan.lib.os').is_nixos(),
}

return Task
