---@diagnostic disable: missing-fields

---@type overseer.TemplateFileDefinition
local Task = {
    name = 'Rebuild nix-darwin',
    builder = function()
        return {
            cmd = 'sudo darwin-rebuild switch',
            components = {
                'default',
                'on_complete_notify',
            },
        }
    end,
    hide = not require('dan.lib.os').is_macos,
}

return Task
