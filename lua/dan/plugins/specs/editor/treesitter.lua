--- Treesitter enhancements for Neovim

--- @type LazyPluginSpec
local M = {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
        {
            --- This Neovim plugin provides alternating syntax highlighting (“rainbow parentheses”) for Neovim, powered by Tree-sitter.
            'HiPhish/rainbow-delimiters.nvim',
            --- Submodules for this plugin are dev dependencies and should not be installed
            submodules = false,
            enabled = true,
            init = function()
                vim.g.rainbow_delimiters = {
                    highlight = {
                        'RainbowDelimiterCyan',
                        'RainbowDelimiterViolet',
                        'RainbowDelimiterGreen',
                        'RainbowDelimiterBlue',
                        'RainbowDelimiterOrange',
                        'RainbowDelimiterRed',
                        'RainbowDelimiterYellow',
                    },
                }
            end,
        },
    },
    config = function()
        local treesitter = require 'nvim-treesitter'

        treesitter.setup()
        treesitter.install 'all'

        -- Start treesitter if there is a parser for it.
        local group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'treesitter', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = '*',
            callback = function(args)
                local bufnr = args.buf
                local filetype = vim.bo[bufnr].filetype

                if filetype == nil then
                    return
                end

                local lang = vim.treesitter.language.get_lang(filetype)

                if lang and vim.list_contains(treesitter.get_available(), lang) then
                    vim.treesitter.start(bufnr, lang)
                end
            end,
        })
    end,
}

return M
