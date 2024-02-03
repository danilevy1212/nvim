-- Lightweight yet powerful formatter plugin for Neovim

---@type LazyPluginSpec
local M = {
    'stevearc/conform.nvim',
    init = function()
        vim.o.formatexpr = 'v:lua.require\'conform\'.formatexpr()'
    end,
    keys = {
        {
            '<leader>bf',
            function()
                require('conform').format {
                    async = true,
                    lsp_fallback = true,
                }
            end,
            mode = { 'n', 'x' },
            desc = 'Format buffer',
        },
    },
    opts = {
        --- TODO  Pass this to each "local" plugin
        formatters_by_ft = {
            lua = { 'stylua' },
            nix = { 'alejandra' },
            html = { 'prettier' },
            css = { 'prettier' },
            json = { 'prettier' },
            yaml = { 'prettier' },
            markdown = { 'prettier' },
        },
    },
}

return M
