-- Lua, the bedrock of neovim

--- @type LazyPluginSpec
local M = {
    'dan/lua',
    ft = { 'lua' },
    dependencies = {
        {
            'folke/lazydev.nvim',
            dependencies = {
                { 'Bilal2453/luvit-meta' },
            },
            opts = {
                library = {
                    'lazy.nvim',
                    { path = 'luvit-meta/library', words = { 'vim%.uv' } },
                },
                integrations = {
                    lspconfig = true,
                    cmp = true,
                },
            },
        },
    },
}

return M
