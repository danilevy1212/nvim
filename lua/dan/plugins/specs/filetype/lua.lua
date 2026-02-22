-- Lua, the bedrock of neovim

--- @type LazyPluginSpec
local M = {
    'dan/lua',
    ft = { 'lua' },
    dependencies = {
        {
            'folke/lazydev.nvim',
            opts = {
                library = {
                    'lazy.nvim',
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            },
        },
    },
}

return M
