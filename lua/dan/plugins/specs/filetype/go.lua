-- A modern go neovim plugin based on treesitter, nvim-lsp and dap debugger.

--- @type LazyPluginSpec
local M = {
    'ray-x/go.nvim',
    ft = { 'go', 'gomod' },
    dependencies = {
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
        'L3MON4D3/LuaSnip',
    },
    build = function()
        require('go.install').update_all()
    end,
    config = function()
        local capabilities = require('dan.lib.lsp').get_default_capabilities()
        local on_attach = require('dan.lib.lsp').on_attach

        require('go').setup {
            lsp_cfg = {
                capabilities = capabilities,
            },
            lsp_on_attach = on_attach,
            luasnip = true,
        }
    end,
}

return M
