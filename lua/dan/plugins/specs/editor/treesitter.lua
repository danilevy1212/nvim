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
    end,
}

return M
