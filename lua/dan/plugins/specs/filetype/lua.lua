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
                    "folke/lazy.nvim",
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
