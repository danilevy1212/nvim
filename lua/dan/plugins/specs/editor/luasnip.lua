-- Lua powered snippet completion engine

---@type LazyPluginSpec
local M = {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    keys = {
        {
            '<C-j>',
            function()
                local ls = require 'luasnip'

                if ls.locally_jumpable() then
                    ls.jump(1)
                end
            end,
            desc = 'Jump to the next snippet',
            mode = { 'i', 's' },
        },
        {
            '<C-k>',
            function()
                local ls = require 'luasnip'

                if ls.locally_jumpable() then
                    ls.jump(-1)
                end
            end,
            desc = 'Jump to the previous snippet',
            mode = { 'i', 's' },
        },
        {
            '<C-e>',
            function()
                local ls = require 'luasnip'
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end,
            mode = { 'i', 's' },
        },

        {
            '<M-e>',
            function()
                local ls = require 'luasnip'
                if ls.expandable() then
                    ls.expand()
                end
            end,
            mode = { 'i', 's' },
        },
    },
    config = function()
        local types = require 'luasnip.util.types'

        require('luasnip').config.set_config {
            history = true,
            updateevents = 'TextChanged,TextChangedI',
            enable_autosnippets = true,
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { '<-', 'Error' } },
                    },
                },
            },
        }

        -- Load snippets from friendly-snippets
        require('luasnip.loaders.from_vscode').lazy_load()
    end,
}

return M
