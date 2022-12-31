--- Category: configuration

-- Reload packages starting by `name`, circunventing the cache
_G.R = function(name)
    require('plenary.reload').reload_module(name)
end

-- Easy keybind to reload the configuration
vim.keymap.set('n', '<leader>hr', function()
    vim.cmd { cmd = 'PackerSync' }
end, { desc = 'Sync packages configuration', silent = true })

return { 'nvim-lua/plenary.nvim', module_name = '^plenary.*' }
