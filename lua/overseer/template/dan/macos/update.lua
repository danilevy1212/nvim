---@diagnostic disable: missing-fields

---@type overseer.TemplateFileDefinition
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
    hide = not require('dan.lib.os').is_macos,
}

return Task
