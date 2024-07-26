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
                    'lazy',
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
